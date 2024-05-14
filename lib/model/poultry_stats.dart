import 'package:poultry/path_collection.dart';

class PoultryStats {
  final int totalFilledEggCrates;
  final int numDeadHens;
  final int numHensSold;
  final User createdBy;
  final String createdAt;

  PoultryStats({
    required this.totalFilledEggCrates,
    required this.numDeadHens,
    required this.numHensSold,
    required this.createdBy,
    required this.createdAt,
  });

  factory PoultryStats.fromJson(Map<String, dynamic> json) {
    return PoultryStats(
      totalFilledEggCrates: int.parse(json['total_filled_egg_crates']),
      numDeadHens: int.parse(json['num_dead_hens']),
      numHensSold: int.parse(json['num_hens_sold']),
      createdBy: User.fromJson(json['created_by']),
      createdAt: json['created_at'],
    );
  }
}
