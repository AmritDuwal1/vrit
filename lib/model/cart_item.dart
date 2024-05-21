
import 'package:poultry/path_collection.dart';

// class CartItem {
//   final int id;
//   final User user;
//   final int numberOfCrates;
//   final String eggType;
//   final String createdAt;
//
//   CartItem({
//     required this.id,
//     required this.user,
//     required this.numberOfCrates,
//     required this.eggType,
//     required this.createdAt,
//   });
//
//   factory CartItem.fromJson(Map<String, dynamic> json) {
//     return CartItem(
//       id: json['id'],
//       user: User.fromJson(json['user']),
//       numberOfCrates: json['number_of_crates'],
//       eggType: json['egg_type'],
//       createdAt: json['created_at'],
//     );
//   }
// }


// class CartItem {
//   final int? id;
//   final User? user;
//   final int? numberOfCrates;
//   final String? eggType;
//   final String? createdAt;
//
//   CartItem({
//     this.id,
//     this.user,
//     this.numberOfCrates,
//     this.eggType,
//     this.createdAt,
//   });
//
//   factory CartItem.fromJson(Map<String, dynamic> json) {
//     return CartItem(
//       id: json['id'],
//       user: json['user'] != null ? User.fromJson(json['user']) : null,
//       numberOfCrates: json['number_of_crates'],
//       eggType: json['egg_type'],
//       createdAt: json['created_at'],
//     );
//   }
// }

class CartItem {
  final int? id;
  final User? user;
  final int? numberOfCrates;
  final String? eggType;
  final String? createdAt;
  final String? status; // Add status field
  final User? updatedBy; // Add updatedBy field
  final String? updatedAt; // Add updatedAt field

  CartItem({
    this.id,
    this.user,
    this.numberOfCrates,
    this.eggType,
    this.createdAt,
    this.status,
    this.updatedBy,
    this.updatedAt,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      numberOfCrates: json['number_of_crates'],
      eggType: json['egg_type'],
      createdAt: json['created_at'],
      status: json['status'], // Assign status field from JSON
      updatedBy: json['updated_by'] != null ? User.fromJson(json['updated_by']) : null, // Assign updatedBy field from JSON
      updatedAt: json['updated_at'],
    );
  }
}

