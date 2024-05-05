// import 'package:flutter/material.dart';
// import 'package:poultry/module/register/register_Screen.dart';
//
//
// class LoginScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Poultry App Login', style: TextStyle(color: Colors.black)), // Black text
//         centerTitle: true,
//         elevation: 0, // No shadow
//       ),
//       body: Container(
//         padding: EdgeInsets.all(20.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               alignment: Alignment.center,
//               padding: EdgeInsets.all(20.0),
//               child: Image.asset('assets/chick_logo.png', width: 100, height: 100), // Chick logo
//             ),
//             TextField(
//               decoration: InputDecoration(
//                 labelText: 'Username',
//                 labelStyle: TextStyle(color: Colors.black), // Black text for label
//               ),
//             ),
//             SizedBox(height: 20),
//             TextField(
//               obscureText: true,
//               decoration: InputDecoration(
//                 labelText: 'Password',
//                 labelStyle: TextStyle(color: Colors.black), // Black text for label
//               ),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {},
//               style: ElevatedButton.styleFrom(
//                 foregroundColor: Colors.black, backgroundColor: Colors.yellow, // Black text on button
//               ),
//               child: Text('Login'),
//             ),
//             const SizedBox(height: 20),
//             TextButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const RegisterScreen()),
//                 );
//               },
//               child: const Text('Sign Up'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:poultry/module/register/register_Screen.dart';
// import 'package:poultry/model/user.dart'; // Import your User model
// import 'package:poultry/helper/global_constants.dart'; // Import your GlobalConstants
//
// class LoginScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     String username = ''; // Local variables to store user input
//     String password = ''; // Local variables to store user input
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Poultry App Login',
//           style: TextStyle(color: Colors.black),
//         ),
//         centerTitle: true,
//         elevation: 0,
//       ),
//       body: Container(
//         padding: EdgeInsets.all(20.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               alignment: Alignment.center,
//               padding: EdgeInsets.all(20.0),
//               child: Image.asset('assets/chick_logo.png', width: 100, height: 100),
//             ),
//             TextField(
//               onChanged: (value) => username = value, // Update username variable on change
//               decoration: InputDecoration(
//                 labelText: 'Username',
//                 labelStyle: TextStyle(color: Colors.black),
//               ),
//             ),
//             SizedBox(height: 20),
//             TextField(
//               onChanged: (value) => password = value, // Update password variable on change
//               obscureText: true,
//               decoration: InputDecoration(
//                 labelText: 'Password',
//                 labelStyle: TextStyle(color: Colors.black),
//               ),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 // Perform login action
//                 // You can call your authentication API here and handle the response accordingly
//                 User user = User(username: username, password: password); // Create a User object
//                 GlobalConstants.saveUser(user); // Save user to SharedPreferences
//                 // Navigate to the home screen or perform other actions
//               },
//               style: ElevatedButton.styleFrom(
//                 foregroundColor: Colors.black,
//                 backgroundColor: Colors.yellow,
//               ),
//               child: Text('Login'),
//             ),
//             const SizedBox(height: 20),
//             TextButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const RegisterScreen()),
//                 );
//               },
//               child: const Text('Sign Up'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:poultry/module/register/register_Screen.dart';
import 'package:poultry/model/user.dart'; // Import your User model
import 'package:poultry/helper/global_constants.dart'; // Import your GlobalConstants

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String username = 'admin146'; // Local variables to store user input
  String password = 'Nepal@123'; // Local variables to store user input
  bool isLoading = false; // Flag to track loading state


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Poultry App Login',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(20.0),
              child: Image.asset('assets/chick_logo.png', width: 100, height: 100),
            ),
            TextField(
              onChanged: (value) => username = value, // Update username variable on change
              decoration: InputDecoration(
                labelText: 'Username',
                labelStyle: TextStyle(color: Colors.black),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              onChanged: (value) => password = value, // Update password variable on change
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.black),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: isLoading ? null : () => _loginAction(), // Disable button when isLoading is true
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.yellow,
              ),
              child: isLoading
                  ? CircularProgressIndicator() // Show spinner when isLoading is true
                  : Text('Login'),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegisterScreen()),
                );
              },
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }

  void _loginAction() {
    setState(() {
      isLoading = true; // Set isLoading to true when login action starts
    });

    // Perform login action
    // You can call your authentication API here and handle the response accordingly
    User user = User(username: username, password: password); // Create a User object
    GlobalConstants.saveUser(user); // Save user to SharedPreferences
    // Navigate to the home screen or perform other actions

    setState(() {
      isLoading = false; // Set isLoading to false when login action finishes
    });
  }
}
