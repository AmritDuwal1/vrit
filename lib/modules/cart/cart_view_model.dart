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
