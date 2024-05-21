// import 'package:flutter/material.dart';
// import 'package:poultry/model/cart.dart';
//
//
//
// class CartViewModel extends ChangeNotifier {
//   List<CartItem> _cartItems = [];
//
//   List<CartItem> get cartItems => _cartItems;
//
//   void addToCart({
//     required int id,
//     required String eggType,
//     required int numberOfCrates,
//     required DateTime createdAt,
//   }) {
//     // Create a new cart item and add it to the cart
//     final newItem = CartItem(
//       id: id,
//       eggType: eggType,
//       numberOfCrates: numberOfCrates,
//       createdAt: createdAt,
//     );
//     _cartItems.add(newItem);
//
//     // Notify listeners that the cart has been updated
//     notifyListeners();
//   }
//
//   void removeFromCart(int id) {
//     // Remove the cart item with the specified id from the cart
//     _cartItems.removeWhere((item) => item.id == id);
//
//     // Notify listeners that the cart has been updated
//     notifyListeners();
//   }
//
//   void clearCart() {
//     // Clear all items from the cart
//     _cartItems.clear();
//
//     // Notify listeners that the cart has been updated
//     notifyListeners();
//   }
// }


import 'package:flutter/material.dart';
import 'package:poultry/api/cart_api.dart';
import 'package:poultry/model/cart_item.dart';
import 'package:poultry/path_collection.dart';

class CartViewModel extends ChangeNotifier {
  final CartAPI cartAPI = CartAPI();
  bool isLoading = false;
  List<CartItem>? cartItems;
  FlutterError? error;
  int? currentPage;
  CartItem? item;
  Result? result;

  Future<void> addItemToCart(CartItem item) async {
    isLoading = true;
    notifyListeners();
    try {
      await cartAPI.requestItem(
        item,
            (response) {
          item = response;
          isLoading = false;
          result = Result.success(message: "Successfully Requested!, if its urgent you make call right away.");
          notifyListeners();
        },
            (error) {
          result = Result.error('Error: $error');
          this.error = error;
          isLoading = false;
          notifyListeners();
        },
      );
    } catch (e) {
      error = FlutterError("$e");
      isLoading = false;
      notifyListeners();
    }
  }
}
