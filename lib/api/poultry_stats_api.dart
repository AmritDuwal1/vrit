import 'package:poultry/model/poultry_stats_summary.dart';
import 'package:poultry/path_collection.dart';

class PoultryStatsAPI {
  Future<void> fetchPoultryStats(
    Function(SingleContainer<PoultryStatsResults>) success,
    Function(FlutterError) failure,
  ) async {
    try {
      final apiRequest = Endpoint.poultryStatsSummary.apiRequest({});
      var response =
          await apiRequest.sendForSingleContainer<PoultryStatsResults>(
              (json) => PoultryStatsResults.fromJson(json));
      print(
          'API Request: ${apiRequest.request.method} ${apiRequest.request.url}');
      if (response.data != null) {
        success(response); // Success callback
      } else {
        failure(
            FlutterError(response.error?.message ?? 'Something Went Wrong!'));
      }
    } catch (e) {
      print('Error: $e');
      failure(FlutterError("$e")); // Failure callback
    }
  }

  Future<void> postPoultryStats(
    int totalFilledEggCrates,
    int numDeadHens,
    int numHensSold,
    double? eggPrice,
    Function(SingleContainer<PoultryStats>) success,
    Function(FlutterError) failure,
  ) async {
    try {
      final apiRequest = Endpoint.dailyUpdate.apiRequest({
        "total_filled_egg_crates": totalFilledEggCrates.toString(),
        "num_dead_hens": numDeadHens.toString(),
        "num_hens_sold": numHensSold.toString(),
        "egg_price": eggPrice?.toString() ?? "", // Convert to string or leave empty if null
      });

      var response = await apiRequest.sendForSingleContainer<PoultryStats>(
          (json) => PoultryStats.fromJson(json));
      print(
          'API Request: ${apiRequest.request.method} ${apiRequest.request.url}');
      if (response.data != null) {
        success(response); // Success callback
      } else {
        failure(
            FlutterError(response.error?.message ?? 'Something Went Wrong!'));
      }
    } catch (e) {
      print('Error: $e');
      failure(FlutterError("$e")); // Failure callback
    }
  }

  Future<void> updateRequestStatus(
      String? status,
      int itemId,
      Function(SingleContainer<PoultryStats>) success,
      Function(FlutterError) failure,
      ) async {
    try {
      final apiRequest = Endpoint.updateRequestStatus.apiRequest({
        "remaining_url": "item_id=$itemId",
        "status": status
      });
      var response = await apiRequest.sendForSingleContainer<PoultryStats>(
              (json) => PoultryStats.fromJson(json));
      print(
          'API Request: ${apiRequest.request.method} ${apiRequest.request.url}');
      if (response.data != null) {
        success(response); // Success callback
      } else {
        failure(
            FlutterError(response.error?.message ?? 'Something Went Wrong!'));
      }
    } catch (e) {
      print('Error: $e');
      failure(FlutterError("$e")); // Failure callback
    }
  }
}
