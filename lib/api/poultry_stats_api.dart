import 'package:poultry/model/poultry_stats_summary.dart';
import 'package:poultry/path_collection.dart';

class PoultryStatsAPI {
  Future<SingleContainer<PoultryStatsResults>> fetchPoultryStats(
      Function(SingleContainer<PoultryStatsResults>) success,
      Function(FlutterError) failure,
      ) async {
    try {
      final apiRequest = Endpoint.poultryStatsSummary.apiRequest({});
      var response = await  apiRequest.sendForSingleContainer<PoultryStatsResults>((json) => PoultryStatsResults.fromJson(json));
      print('API Request: ${apiRequest.request.method} ${apiRequest.request.url}');
      // ArrayContainer<List<PoultryStats>> response =
      // await apiRequest.send<List<PoultryStats>>((json) => [PoultryStats.fromJson(json)]);

      if (response.results != null) {
        success(response); // Success callback
        return response; // Return the response
      } else {
        failure(FlutterError(response.error?.message ?? response.detail ?? 'Something Went Wrong!'));
        throw FlutterError("Failed to fetch poultry stats");
      }
    } catch (e) {
      print('Error: $e');
      failure(FlutterError("$e")); // Failure callback
      throw FlutterError("Failed to fetch poultry stats");
    }
  }

// Add methods for adding and removing poultry stats if needed
}
