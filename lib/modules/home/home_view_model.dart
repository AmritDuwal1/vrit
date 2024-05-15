import 'package:flutter/material.dart';
import 'package:poultry/api/poultry_stats_api.dart';
import 'package:poultry/model/poultry_stats_summary.dart';
import 'package:poultry/path_collection.dart';

class HomeViewModel extends ChangeNotifier {
  final PoultryStatsAPI poultryStatsAPI = PoultryStatsAPI();
  bool isLoading = false;
  List<PoultryStats>? last7DaysStats;
  PoultryStats? todayStats;
  FlutterError? error;
  Result? result;

  void fetchData() {
    isLoading = true;
    notifyListeners();

    poultryStatsAPI.fetchPoultryStats(
          (response) {
        last7DaysStats = response.data?.last7DaysStats;
        todayStats = response.data?.todayStats;
        isLoading = false;
        notifyListeners();
      },
          (error) {
        this.error = error;
        isLoading = false;
        notifyListeners();
      },
    );
  }

  Future<void> submitFormData({
    required int totalHenDied,
    required int totalFilledCrates,
    required int totalHenSold,
    double? todayEggPrice,
  }) async {
    // final Map<String, dynamic> data = {
    //   'total_hen_died': totalHenDied,
    //   'total_filled_crates': totalFilledCrates,
    //   'total_hen_sold': totalHenSold,
    //   'today_egg_price': todayEggPrice,
    // };

    poultryStatsAPI.postPoultryStats(
      totalFilledCrates,
       totalHenDied,
      totalHenSold,
      todayEggPrice,(response)  {
        result = Result.success(message: 'Successfully Updated');
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


  void notify() {
    notifyListeners();
  }
}
