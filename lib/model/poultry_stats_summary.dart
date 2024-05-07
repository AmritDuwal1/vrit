// import 'dart:convert';
//
// class PoultryStatsResults {
//   late final List<PoultryStats> last7DaysStats;
//   late final PoultryStats todayStats;
//
//   PoultryStatsResults.fromJson(Map<String, dynamic> json) {
//     last7DaysStats = List<PoultryStats>.from(json['last_7_days_stats'].map((x) => PoultryStats.fromJson(x)));
//     todayStats = PoultryStats.fromJson(json['today_stats']);
//   }
// }
//
// class PoultryStats {
//   late final int totalFilledEggCrates;
//   late final int numDeadHens;
//   late final int numHensSold;
//   late final String createdAt;
//
//   PoultryStats.fromJson(Map<String, dynamic> json) {
//     totalFilledEggCrates = json['total_filled_egg_crates'];
//     numDeadHens = json['num_dead_hens'];
//     numHensSold = json['num_hens_sold'];
//     createdAt = json['created_at'];
//   }
// }


import 'dart:convert';

class PoultryStatsResults {
  late final List<PoultryStats>? last7DaysStats;
  late final PoultryStats? todayStats;

  PoultryStatsResults.fromJson(Map<String, dynamic> json) {
    last7DaysStats = (json['last_7_days_stats'] as List<dynamic>?)
        ?.map((x) => PoultryStats.fromJson(x))
        .toList();
    // todayStats = json['today_stats'] != null ? PoultryStats.fromJson(json['today_stats']) : null;
    todayStats = PoultryStats.fromJson(json['today_stats']);
  }
}

class PoultryStats {
  late final int? totalFilledEggCrates;
  late final int? numDeadHens;
  late final int? numHensSold;
  late final String? createdAt;

  PoultryStats.fromJson(Map<String, dynamic> json) {
    totalFilledEggCrates = json['total_filled_egg_crates'];
    numDeadHens = json['num_dead_hens'];
    numHensSold = json['num_hens_sold'];
    createdAt = json['created_at'];
  }
}
