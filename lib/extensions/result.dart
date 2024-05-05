import '../path_collection.dart';

class Result {
  final bool isSuccess;
   String? message;

  Result.success({this.message})
      : isSuccess = true;

  Result.error(this.message)
      : isSuccess = false;

  @override
  String toString() {
    if (isSuccess) {
      return 'Success: $message';
    } else {
      return 'Error: $message';
    }
  }
}
