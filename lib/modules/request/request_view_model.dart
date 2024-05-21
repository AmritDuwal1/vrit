import 'package:flutter/material.dart';
import 'package:poultry/api/cart_api.dart';
import 'package:poultry/api/poultry_stats_api.dart';
import 'package:poultry/helper/data_task.dart';
import 'package:poultry/model/cart_item.dart';
import 'package:poultry/path_collection.dart';

class RequestViewModel extends ChangeNotifier {
  final CartAPI api = CartAPI();
  final PoultryStatsAPI poultryStatsAPI = PoultryStatsAPI();

  bool isLoading = false;
  List<CartItem>? cartItems;
  FlutterError? error;
  int? currentPage;
  ArrayContainer<List<CartItem>>? arrayContainer;
  Result? result;

  Future<void>fetchData() async {
    isLoading = true;
    notifyListeners();
    currentPage =  (currentPage ?? 0) + 1;
    api.fetchCartItems(
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


  Future<void> updateRequestStatus({
    String? status,
    required int itemId,
  }) async {
    poultryStatsAPI.updateRequestStatus(
         status, itemId,(response)  {
      result = Result.success(message: 'Successfully Updated');
      currentPage = null;
      fetchData();
      isLoading = false;
      notifyListeners();
    },
          (error) {
        this.error = error;
        result = Result.error(error.message);
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
