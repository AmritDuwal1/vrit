import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:poultry/extensions/string_extension.dart';
import 'package:poultry/helper/data_task.dart';
import 'package:poultry/helper/global_constants.dart';

import 'package:poultry/path_collection.dart';
import 'package:http_parser/http_parser.dart';
import 'dart:io';

class APIRequest<T> {
  final http.Request request;
  final Endpoint endpoint;

  APIRequest({required this.request, required this.endpoint});

  Future<ArrayContainer<T>> send<T>(T Function(dynamic) fromJsonT) async {
    try {
      var request1 = http.Request(request.method, request.url);
      request1.headers.addAll(request.headers);
      switch (request.method) {
        case "GET":
          break;
        default:
          request1.body = request.body;
      }

      http.StreamedResponse response = await request1.send();

      String responseBody = await response.stream.bytesToString();

      print('Response Body: $responseBody  \n response $response');

      dynamic decodedBody = jsonDecode(responseBody);

      // Parse decodedBody into ArrayContainer
      ArrayContainer<T> arrayContainer =
      ArrayContainer<T>.fromJson(decodedBody, fromJsonT);

      return arrayContainer;
    } catch (error) {
      print("Error: $error");
      throw error;
    }
  }

  Future<SingleContainer<T>> sendForSingleContainer<T>(
      T Function(dynamic) fromJsonT) async {
    try {
      var request1 = http.Request(request.method, request.url);
      request1.headers.addAll(request.headers);
      switch (request.method) {
        case "GET":
        case "DELETE":
          request1.headers['Accept'] = 'application/json';
          request1.headers['Vary'] = 'Accept';
          // request1.headers['Cookie'] =
          //     'csrftoken=kqKOdAfpxHsPoAet9BtLaphPUmlZok6BeTZMxO12FyoxCxrDvV7in13KxIs2Yq7u; sessionid=u95xym9jd45yvr1k3u9srsfsfxppgkko';  //this is not necessary remove it later
          // request1.body = '''''';
          break;
        default:
          request1.body = request.body;
      }

      print(
          '\n token: ${GlobalConstants.getUser()?.token ?? ""} Response Body:  \n:method ${request1.method} \n:body  ${request1.body} \n all header: ${request1.headers} ');
      http.StreamedResponse response = await request1.send();

      // String responseBody = await response.stream.bytesToString();
      String responseBody;
      if (response.contentLength == 0) {
        responseBody = "";
      } else {
        responseBody = await response.stream.bytesToString();
      }
      print("responseBody: ${responseBody}");
      dynamic decodedBody = jsonDecode(responseBody);
      if (decodedBody != null) {
        SingleContainer<T> singleContainer =
        SingleContainer<T>.fromJson(decodedBody, fromJsonT);
        return singleContainer;
      } else {
        throw Exception(
            'Decoded body is null'); // Or handle the error in another way
      }
    } catch (error) {
      print("Error: $error");
      throw error;
    }
  }

  Future<SingleContainer<T>> sendMultimediaForSingleContainer<T>(
      String method,
      T Function(dynamic) fromJsonT,
      Map<String, dynamic> bodyParams,
      Map<String, List<String>> filesByField,
      ) async {
    try {
      var request1 = http.MultipartRequest(method, request.url);
      request1.headers.addAll(request.headers);
      print(filesByField.length);
      // Add files for each field
      filesByField.forEach((fieldName, filePaths) {
        for (var filePath in filePaths) {
          if (File(filePath).existsSync()) {
            List<int> fileBytes = File(filePath).readAsBytesSync();
            var multipartFile = http.MultipartFile.fromBytes(
              fieldName,
              fileBytes,
              // filename: '${fieldName}.jpg', // Change filename if needed
              filename: '${DateTime.now().microsecondsSinceEpoch}.jpg', // Use a unique filename
              contentType: MediaType('image', 'jpg'), // Change content type if needed
            );
            request1.files.add(multipartFile);
            print(multipartFile);
          } else {
            print('File not found: $filePath');
          }
        }
      });

      // Add other form fields
      bodyParams.forEach((key, value) {
        request1.fields[key] = value.toString();
      });

      // print(
      //     '\n token: ${GlobalConstants.getUser()?.token ?? ""} Response Body:  \n:method ${request1.method} \n:body  ${bodyParams} \n all header: ${request1.headers} ');
      print('Request details:');
      print('Token: ${GlobalConstants.getUser()?.token ?? ""}');
      print('Method: ${request1.method}');
      print('Body: $bodyParams');
      print('Headers: ${request1.headers}');

      http.StreamedResponse response = await request1.send();
      String responseBody = await response.stream.bytesToString();

      dynamic decodedBody = jsonDecode(responseBody);
      print('Decoded Body: $decodedBody');

      if (decodedBody != null) {
        SingleContainer<T> singleContainer =
        SingleContainer<T>.fromJson(decodedBody, fromJsonT);
        return singleContainer;
      } else {
        throw Exception('Decoded body is null');
      }
    } catch (error) {
      print("Error: $error");
      throw error;
    }
  }

  String getKey(Uri url) {
    switch (endpoint) {
      default:
        return url.toString();
    }
  }
}

enum Endpoint {
  login,
  register,
  poultryStatsSummary,
  deleteUser,
  googleLogin,
  addToCart,
  cartList,
  dailyUpdate,
}

extension EndpointExtension on Endpoint {
  String get path {
    switch (this) {
      case Endpoint.login:
        return "poultryapp/api/login/";
      case Endpoint.register:
        return "api/users/create/";
      case Endpoint.poultryStatsSummary:
        return "poultryapp/api/poultry-stats-summary/";
      case Endpoint.deleteUser:
        return "poultryapp/api/delete-user/";
      case Endpoint.googleLogin:
        return "poultryapp/api/rest-auth/google/";
      case Endpoint.addToCart:
      case Endpoint.cartList:
        return "poultryapp/api/carts/";
      case Endpoint.dailyUpdate:
        return "poultryapp/api/poultry-stats/";
    }
  }


  String get method {
    switch (this) {
      case Endpoint.login:
      case Endpoint.addToCart:
      case Endpoint.dailyUpdate:
        return "POST";
      case Endpoint.deleteUser:
        return "DELETE";
      default:
        return "GET";
    }
  }

  bool get needsAuthorization {
    switch (this) {
      case Endpoint.deleteUser:
      case Endpoint.poultryStatsSummary:
      case Endpoint.addToCart:
      case Endpoint.cartList:
      case Endpoint.dailyUpdate:
        return true;
      default:
        return false;
    }
  }

  APIRequest request(String urlString, Map<String, dynamic>? body) {
    final url = Uri.parse(urlString);
    print(url);
    var request = http.Request(method, url);
    request.headers['Content-Type'] = 'application/json';
    //  commented the token part
    if ((GlobalConstants.getUser()?.token ?? "") != "" &&  needsAuthorization) {
      request.headers['Authorization'] =
      'Token ${GlobalConstants.getUser()?.token ?? ""}';
    }
    if (method == "POST" || method == "PUT" || method == "PATCH") {
      // request.headers['Cookie'] = 'csrftoken=sRtN2uTkQ3fXPPPdUG56XYLkkytGkszYfwXcHYHjYlTuEKzsyNm4MgQydHt4PNZx; sessionid=iv7asvbuyljfxlwf8nrqvz35trcny99g';
      if (body != null) {
        request.body = jsonEncode(body);
      }
    }
    return APIRequest(request: request, endpoint: this);
  }

  APIRequest apiRequest(Map<String, dynamic> params) {
    var urlString = "${GlobalConstants.baseUrl}/$path";
    String page = "?page=${params['page'] ?? 1}";

    String remainingUrl = "${params['remaining_url']}";

    // only for url changes
    switch (this) {
      default:
        urlString = "${GlobalConstants.baseUrl}/$path";
    }

    if (remainingUrl.isEmpty || !remainingUrl.isNotNull || remainingUrl == "null") {
      // remainingUrl is empty
    } else {
      urlString = "$urlString$remainingUrl";
      print('remainingUrl is not empty');
    }
    return request(urlString, params);
  }
}
