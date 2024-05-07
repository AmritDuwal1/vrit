import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:poultry/api/endpoint.dart';
import 'package:poultry/helper/data_task.dart';
import 'package:poultry/model/user.dart';

class LoginAPI {
  Future<void> login(
      String username,
      String password,
      Function(Map<String, dynamic>) success,
      Function(dynamic) failure,
      ) async {
    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/poultryapp/api/login/'),
        body: {
          'username': username,
          'password': password,
        },
      );
      Map<String, String>  body =  {
        'username': username,
      'password': password,
  };
      // final apiRequest = APIRequest<SingleContainer<User>>(
      //   request: Endpoint.login.apiRequest(body).request,
      //   endpoint: Endpoint.googleLogin,
      // );
       var a =   Endpoint.login.apiRequest(body).sendForSingleContainer<User>((json) => User.fromJson(json));
      // SingleContainer<User> response1 = await apiRequest
      //     .sendForSingleContainer<User>((json) => User.fromJson(json));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        success(data['results']);
      } else {
        throw Exception('Failed to login');
      }
    } catch (error) {
      failure(error.toString());
    }
  }
}
