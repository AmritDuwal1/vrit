
import 'package:http/http.dart' as http;
import 'package:poultry/model/pagination.dart';

class ArrayContainer<T> {
  // final int? count;
  // final String? next;
  // final String? previous;
  final List<T>? data;
  final ErrorResponse? error;
  // final String? detail;
  final Pagination? pagination;

  ArrayContainer({
    // required this.count,
    // this.next,
    // this.previous,
    this.data,
    this.error,
    this.pagination,
    // this.detail,
  });

  factory ArrayContainer.fromJson(Map<String, dynamic> json, T Function(dynamic) fromJsonT) {
    return ArrayContainer<T>(
      // count: json['count'],
      // next: json['next'],
      // previous: json['previous'],
      // results: (json['results'] as List<dynamic>).map((e) => fromJsonT(e)).toList(),
      data: (json['data'] as List<dynamic>?)?.map((e) => fromJsonT(e)).toList(), // Handle null results
      // error: ErrorResponse.fromJson(json['error']),
      error: json.containsKey('error') ? ErrorResponse.fromJson(json['error']) : null, // Check if 'error' key exists
      // detail: json['detail'],
      // pagination: Pagination.fromJson(json['pagination']),
      pagination: json.containsKey('pagination') ? Pagination.fromJson(json['pagination']) : null,
    );
  }
}

class SingleContainer<T> {
  final T? data;
  final ErrorResponse? error;

  SingleContainer({
    this.data,
    this.error,
  });

  factory SingleContainer.fromJson(Map<String, dynamic> json, T Function(dynamic) fromJsonT) {
    return SingleContainer<T>(
      data: json.containsKey('data') ? fromJsonT(json['data']) : null, // Check if 'results' key exists before parsing
      error: json['error'] != null ? ErrorResponse.fromJson(json['error']) : null,
    );
  }
}

class ErrorResponse {
  final String? message;

  ErrorResponse({required this.message});

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    return ErrorResponse(
      message: json['message'] ?? 'Unknown error occurred.',
    );
  }
}

class Request {
  final http.Request request;
  final Map<String, String> body;

  Request({
    required this.request,
    required this.body,
  });
}

// class File {
//   final String name;
//   final List<int> data;
//   final String contentType;
//
//   File({
//     required this.name,
//     required this.data,
//     required this.contentType,
//   });
// }

// class Container {}
