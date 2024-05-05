class SuccessResponse {
  final String? message;

  SuccessResponse({this.message});

  factory SuccessResponse.fromJson(Map<String, dynamic> json) {
    return SuccessResponse(
      message: json['message'] as String?, // Ensure message is casted as String?
    );
  }
}
