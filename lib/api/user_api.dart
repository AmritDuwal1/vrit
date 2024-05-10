import 'dart:io';
import 'package:http/http.dart' as http;



import 'package:poultry/path_collection.dart';
import 'dart:convert';


import 'endpoint.dart';

class UserAPI {
  Future<void> loginUser(
    String username,
    String password,
    Function(User) success,
    Function(FlutterError) failure,
  ) async {
    try {
      final apiRequest = APIRequest<SingleContainer<User>>(
        request: Endpoint.login.apiRequest({
          'username': username,
          'password': password,
          "fcm_token": GlobalConstants.getFirebaseToken(),
        }).request,
        endpoint: Endpoint.login,
      );
      print(
          'API Request: ${apiRequest.request.method} ${apiRequest.request.url}');
      SingleContainer<User> response = await apiRequest
          .sendForSingleContainer<User>((json) => User.fromJson(json));
      if (response.data != null) {
        print('API Response: ${response.data}');
        success(response.data!); // Unwrap results since it's nullable
      } else {
        String errorMessage = response.error?.message ??
            response.detail ??
            "Something Went Wrong!";
        failure(FlutterError(errorMessage));
      }
    } catch (e) {
      print('Error: $e');
      failure(FlutterError("$e")); // Failure callback
    }
  }

  // Future<void> getUserDetail(
  //   Function(User) success,
  //   Function(FlutterError) failure,
  // ) async {
  //   try {
  //     final apiRequest = Endpoint.getUserDetail.apiRequest({});
  //     print(
  //         'API Request: ${apiRequest.request.method} ${apiRequest.request.url}');
  //     SingleContainer<User> response = await apiRequest
  //         .sendForSingleContainer<User>((json) => User.fromJson(json));
  //     if (response.results != null) {
  //       print('API Response: ${response.results}');
  //       success(response.results!); // Unwrap results since it's nullable
  //     } else {
  //       String errorMessage = response.error?.message ??
  //           response.detail ??
  //           "Something Went Wrong!";
  //       failure(FlutterError(errorMessage));
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //     failure(FlutterError("$e")); // Failure callback
  //   }
  // }

  // Future<void> updateUser(
  //   String? email,
  //   String? firstName,
  //   String? lastName,
  //   String? userName,
  //   String? phoneNumber,
  //   String? imagePath,
  //   Function(User) success,
  //   Function(FlutterError) failure,
  // ) async {
  //   try {
  //     var request;
  //
  //     // Add request parameters
  //     var requestParams = {
  //       'email': email ?? '',
  //       'first_name': firstName ?? '',
  //       'last_name': lastName ?? '',
  //       'username': userName ?? '',
  //       'phone_number': phoneNumber ?? '',
  //     };
  //
  //     if (imagePath != null) {
  //       // Create a multipart request
  //       request = http.MultipartRequest(
  //         'PUT',
  //         Uri.parse('${GlobalConstants.baseUrl}/api/user/profile/update/'),
  //       );
  //       request.headers.addAll({
  //         'Authorization': 'Token ${GlobalConstants.getUser()?.token ?? ""}',
  //         'Content-Type': 'application/json',
  //         'Cookie':
  //             'csrftoken=N355V1xEPuAor6lVfOO89TMl781aOiYkmL4jaJehVeUYBqm1JbPNVr6ln8V7ilgx; sessionid=ogyylqshoq4n48dzhz4b46ebu1jdbzxl',
  //       });
  //       // Convert the image file to a byte stream
  //       List<int> imageBytes = await File(imagePath).readAsBytes();
  //       // Convert the byte stream to a multipart file
  //       var multipartFile = http.MultipartFile.fromBytes(
  //         'image',
  //         imageBytes,
  //         filename: 'image.jpg', // Change the filename as needed
  //         contentType:
  //             MediaType('image', 'jpg'), // Change the content type as needed
  //       );
  //
  //       request.files.add(multipartFile);
  //     } else {
  //       // Create a simple request
  //       request = http.Request(
  //         'PUT',
  //         Uri.parse('${GlobalConstants.baseUrl}/api/user/profile/update/'),
  //       );
  //
  //       // Set the request body with request parameters
  //       (request as http.Request).body = jsonEncode(requestParams);
  //       // Set the request headers
  //       request.headers.addAll({
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Token ${GlobalConstants.getUser()?.token ?? ""}',
  //         'Cookie':
  //             'csrftoken=N355V1xEPuAor6lVfOO89TMl781aOiYkmL4jaJehVeUYBqm1JbPNVr6ln8V7ilgx; sessionid=ogyylqshoq4n48dzhz4b46ebu1jdbzxl',
  //       });
  //     }
  //
  //     // Send the request and await the response
  //     var response = await request.send();
  //
  //     // Read the response stream
  //     String responseBody = await response.stream.bytesToString();
  //
  //     // Decode the response body
  //     dynamic decodedBody = jsonDecode(responseBody);
  //     print(decodedBody);
  //
  //     // Handle the decoded response
  //     if (decodedBody != null) {
  //       SingleContainer<User> singleContainer = SingleContainer<User>.fromJson(
  //           decodedBody, (json) => User.fromJson(json));
  //       if (singleContainer.results != null) {
  //         success(singleContainer.results!);
  //       } else {
  //         String errorMessage = singleContainer.error?.message ??
  //             singleContainer.detail ??
  //             "Something Went Wrong!";
  //         failure(FlutterError(errorMessage));
  //       }
  //     } else {
  //       throw Exception('Decoded body is null');
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //     failure(FlutterError("$e"));
  //   }
  // }

  Future<void> registerUser({
    required String username,
    required String password,
    required String email,
    required String firstName,
    required String lastName,
    required String photo,
    required String phoneNumber,
    required bool isHotelOwner,
    required Function(User) success,
    required Function(FlutterError) failure,
  }) async {
    try {
      final apiRequest = APIRequest<SingleContainer<User>>(
        request: Endpoint.register.apiRequest({
          'username': username,
          'password': password,
          'email': email,
          'first_name': firstName,
          'last_name': lastName,
          // 'photo': photo,
          'phone_number': phoneNumber,
          'is_hotel_owner': isHotelOwner
        }).request,
        endpoint: Endpoint.register,
      );

      var requestBody = {
        'username': username,
        'password': password,
        'email': email,
        'first_name': firstName,
        'last_name': lastName,
        // 'photo': photo,
        'phone_number': phoneNumber,
        'is_hotel_owner': isHotelOwner
      };
      print(
          'API Request: ${apiRequest.request.method} ${apiRequest.request.url}');

      var filesByField = <String, List<String>>{};
      if (!photo.isEmpty) {
        filesByField = <String, List<String>>{
          'image': [
            photo
          ], // Assuming 'image' is the key for the hotel image file
          // 'banner_images': hotel.bannerImages?.map((banner) => banner.image ?? "").toList() ?? [], // Assuming 'image' is the key for banner images
        };
      }

      var response = await apiRequest.sendMultimediaForSingleContainer(
          "POST", (json) => User.fromJson(json), requestBody, filesByField);
      if (response.data != null) {
        print('API Response: ${response.data}');
        success(response.data!); // Unwrap results since it's nullable
      } else {
        String errorMessage = response.error?.message ??
            response.detail ??
            "Something Went Wrong!";
        failure(FlutterError(errorMessage));
      }
    } catch (e) {
      print('Error: $e');
      failure(FlutterError("$e")); // Failure callback
    }
  }

  Future<void> deleteUser(
    int userId,
    Function(String) success,
    Function(FlutterError) failure,
  ) async {
    try {
      final apiRequest = APIRequest<SuccessResponse>(
        request:
            Endpoint.deleteUser.apiRequest({'appendInUrl': '$userId/'}).request,
        endpoint: Endpoint.deleteUser,
      );
      print(
          'API Request: ${apiRequest.request.method} ${apiRequest.request.url}');
      SingleContainer<String> response = await apiRequest
          .sendForSingleContainer<String>((json) => json.toString());

      if (response.data != null) {
        print('API Response: User deleted successfully');
        success(response.data!); // Pass true to indicate successful deletion
      } else {
        failure(FlutterError(response.error?.message ??
            response.detail ??
            'Something Went Wrong!'));
      }
    } catch (e) {
      print('Error: $e');
      failure(FlutterError("$e")); // Failure callback
    }
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  Future<void> loginWithGoogle(
      String googleToken,
      bool isGoogleLogin,
      AuthorizationCredentialAppleID? credential,
      Function(User) success,
      Function(FlutterError) failure,
      ) async {
    try {

      Map<String, String> googleBody = {
        'access_token': googleToken,
      };

      Map<String, String> appleBody = {
        'id_token': googleToken,
        'code': credential?.authorizationCode ?? "",
        'user_identifier': credential?.userIdentifier ?? "",
        'email': credential?.email ?? "",
        'first_name': credential?.givenName ?? "",
        'last_name': credential?.familyName ?? "",
      };

      var body = isGoogleLogin ?  googleBody :  appleBody;
      final apiRequest = APIRequest<SingleContainer<User>>(
        request: Endpoint.googleLogin.apiRequest(body).request,
        endpoint: Endpoint.googleLogin,
      );
      print('API Request: ${apiRequest.request.method} ${apiRequest.request.url}');
      SingleContainer<User> response = await apiRequest
          .sendForSingleContainer<User>((json) => User.fromJson(json));
      if (response.data != null) {
        print('API Response: ${response.data}');
        success(response.data!); // Unwrap results since it's nullable
      } else {
        String errorMessage = response.error?.message ??
            response.detail ??
            "Something Went Wrong!";
        failure(FlutterError(errorMessage));
      }
    } catch (e) {
      print('Error: $e');
      failure(FlutterError("$e")); // Failure callback
    }
  }

}
