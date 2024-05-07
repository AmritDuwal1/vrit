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

  void fetchData() {
    isLoading = true;
    notifyListeners();

    poultryStatsAPI.fetchPoultryStats(
          (response) {
        last7DaysStats = response.results?.last7DaysStats;
        todayStats = response.results?.todayStats;
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

  void notify() {
    notifyListeners();
  }
}
