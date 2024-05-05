import 'package:poultry/path_collection.dart';

class ProfileViewModel extends ChangeNotifier {
  final UserAPI userAPI = UserAPI(); // Initialize your API object
  bool isLoading = false; // Flag to track loading state
  User? user;
  FlutterError? error;
  Result? result;

  // Method to fetch user details
  void fetchUserDetails() {
    isLoading = true; // Set loading flag to true
    notifyListeners(); // Notify listeners to update the UI

    // Call the API method to fetch user details
    // userAPI.getUserDetail((response) {
    //   print('User details fetched: $response');
    //   user = response; // Store the fetched user details
    //   isLoading = false; // Set loading flag to false
    //   notifyListeners(); // Notify listeners to update the UI
    // }, (error) {
    //   // Handle failure
    //   this.error = error;
    //   print('Error fetching user details: $error');
    //   isLoading = false; // Set loading flag to false
    //   notifyListeners(); // Notify listeners to update the UI
    // });
  }

  void deleteUser() {
    isLoading = true; // Set loading flag to true
    notifyListeners(); // Notify listeners to update the UI

    // Call the API method to delete the user
    userAPI.deleteUser(
      GlobalConstants.getUser()?.id ?? 0,
          (response) {
        isLoading = false; // Set loading flag to false
        result = Result.success(message: response); // Set success result
        notifyListeners(); // Notify listeners to update the UI
      },
          (error) {
        result = Result.error(error.message); // Set error result
        isLoading = false; // Set loading flag to false
        notifyListeners(); // Notify listeners to update the UI
      },
    );
  }


  // Method to notify listeners
  void notify() {
    notifyListeners();
  }
}
