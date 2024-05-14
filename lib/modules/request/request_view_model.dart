import 'package:flutter/material.dart';
import 'package:poultry/api/cart_api.dart';
import 'package:poultry/helper/data_task.dart';
import 'package:poultry/model/cart_item.dart';

class RequestViewModel extends ChangeNotifier {
  final CartAPI cartAPI = CartAPI();
  bool isLoading = false;
  List<CartItem>? cartItems;
  FlutterError? error;
  int? currentPage;
  ArrayContainer<List<CartItem>>? arrayContainer;

  Future<void>fetchData() async {
    isLoading = true;
    notifyListeners();
    currentPage =  (currentPage ?? 0) + 1;
    cartAPI.fetchCartItems(
      currentPage ?? 1,
          (response) {
            arrayContainer = response;
            var items = response.data?.expand((cartItem) => cartItem).toList() ?? [];
            if (currentPage != 1) {
              cartItems = (cartItems ?? []) + items;
              // List<Hotel>  currentList = response.results!.expand((hotels) => hotels).toList();
              // _hotelList = _hotelList + currentList;
            } else {
              cartItems = items;
            }
        isLoading = false;
        notifyListeners();
      }, (error) {
        this.error = error;
        isLoading = false;
        notifyListeners();
      },
    );
  }

  Future<void> loadMoreData() async {
    await fetchData();
  }

  void notify() {
    notifyListeners();
  }
}
