


import 'package:poultry/path_collection.dart';

class CartAPI {
  Future<ArrayContainer<List<CartItem>>> fetchCartItems(
      int page,
      Function(List<CartItem>) success,
      Function(FlutterError) failure,
      ) async {
    try {
      ArrayContainer<List<CartItem>> response = await APIRequest<List<CartItem>>(
        request: Endpoint.cartList.apiRequest({'page': page}).request,
        endpoint: Endpoint.cartList,
      ).send<List<CartItem>>((json) => [CartItem.fromJson(json)]);

      // print('API Request: ${apiRequest.request.method} ${apiRequest.request.url}');
      // ArrayContainer<List<CartItem>> response = await apiRequest.send<List<CartItem>>(
      //       (json) => (json as List).map((item) => CartItem.fromJson(item)).toList(),
      // );

      if (response.data != null) {
        success(response.data!.expand((items) => items).toList()); // Success callback
        return response; // Return the response
      } else {
        String errorMessage = response.error?.message ?? response.detail ?? "Something Went Wrong!";
        failure(FlutterError(errorMessage));
        throw FlutterError(errorMessage);
      }
    } catch (e) {
      print('Error: $e');
      failure(FlutterError("$e")); // Failure callback
      throw FlutterError("Failed to fetch cart items");
    }
  }


// Add more API functions for removing items from the cart, getting the cart contents, etc.
}
