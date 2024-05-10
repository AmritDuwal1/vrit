
import 'package:http/http.dart' as http;
class ArrayContainer<T> {
  final int? count;
  final String? next;
  final String? previous;
  final List<T>? data;
  final ErrorResponse? error;
  final String? detail;

  ArrayContainer({
    required this.count,
    this.next,
    this.previous,
    this.data,
    this.error,
    this.detail,
  });

  factory ArrayContainer.fromJson(Map<String, dynamic> json, T Function(dynamic) fromJsonT) {
    return ArrayContainer<T>(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      // results: (json['results'] as List<dynamic>).map((e) => fromJsonT(e)).toList(),
      data: (json['data'] as List<dynamic>?)?.map((e) => fromJsonT(e)).toList(), // Handle null results
      error: json['error'],
      detail: json['detail'],
    );
  }
}

class SingleContainer<T> {
  final int? count;
  final String? next;
  final String? previous;
  final T? data;
  final ErrorResponse? error;
  final String? detail;

  SingleContainer({
    this.count,
    this.next,
    this.previous,
    this.data,
    this.error,
    this.detail,
  });

  factory SingleContainer.fromJson(Map<String, dynamic> json, T Function(dynamic) fromJsonT) {
    return SingleContainer<T>(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      // results: fromJsonT(json['results']), // Parse 'results' directly with fromJsonT
      data: json.containsKey('data') ? fromJsonT(json['data']) : null, // Check if 'results' key exists before parsing
      error: json['error'] != null ? ErrorResponse.fromJson(json['error']) : null,
      detail: json['detail'],
    );
  }
}

class ErrorResponse {
  final String message;

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
