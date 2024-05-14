


import 'package:poultry/path_collection.dart';
import 'dart:convert';

class CartAPI {
  Future<ArrayContainer<List<CartItem>>> fetchCartItems(
      int page,
      Function(ArrayContainer<List<CartItem>>) success,
      Function(FlutterError) failure,
      ) async {
    try {
      var remainingUrl = "?page=$page&items_per_page=10";
      var body = {
        "remaining_url": remainingUrl
      };
      ArrayContainer<List<CartItem>> response = await APIRequest<List<CartItem>>(
        request: Endpoint.cartList.apiRequest(body).request,
        endpoint: Endpoint.cartList,
      ).send<List<CartItem>>((json) => [CartItem.fromJson(json)]);

      // print('API Request: ${apiRequest.request.method} ${apiRequest.request.url}');
      // ArrayContainer<List<CartItem>> response = await apiRequest.send<List<CartItem>>(
      //       (json) => (json as List).map((item) => CartItem.fromJson(item)).toList(),
      // );

      if (response.data != null) {
        success(response); // Success callback
        return response; // Return the response
      } else {
        String errorMessage = response.error?.message  ?? "Something Went Wrong!";
        failure(FlutterError(errorMessage));
        throw FlutterError(errorMessage);
      }
    } catch (e) {
      print('Error: $e');
      failure(FlutterError("$e")); // Failure callback
      throw FlutterError("Failed to fetch cart items");
    }
  }

  Future<void> requestItem(
      CartItem item,
      Function(CartItem) success,
      Function(FlutterError) failure,
      ) async {
    try {
      // Convert CartItem object to JSON
      // var jsonItem = item.toJson();
      final apiRequest = APIRequest<SingleContainer<User>>(
        request: Endpoint.addToCart.apiRequest({
          "number_of_crates": item.numberOfCrates ?? 1,
          "egg_type": item.eggType ?? "hen"
        }).request,
        endpoint: Endpoint.login,
      );
      SingleContainer<CartItem> response = await apiRequest
          .sendForSingleContainer<CartItem>((json) => CartItem.fromJson(json));

      if (response.data != null) {
        success(response.data!); // Success callback
        // return response; // Return the response
      } else {
        String errorMessage = response.error?.message  ?? "Something Went Wrong!";
        failure(FlutterError(errorMessage));
        throw FlutterError(errorMessage);
      }

    } catch (e) {
      print('Error: $e');
      failure(FlutterError("$e")); // Failure callback
      throw FlutterError("Failed to add item to cart");
    }
  }

}
