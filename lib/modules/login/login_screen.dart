
import 'package:poultry/path_collection.dart';
import 'package:poultry/tabbar/tabbar_screen.dart';

class LoginScreen extends StatefulWidget {
   LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  late LoginViewModel viewModel;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    viewModel = LoginViewModel();
    listenToViewModel();
    usernameController.text = "";
    passwordController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Center(
              child: Text(
                "Duwal Poultry",
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 32.0),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 32.0),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Call the login function when the button is pressed
                  login(context);
                },
                child: const Text('Login'),
              ),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              height: 50, // Set the desired height here
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterScreen(),
                    ),
                  );
                },
                child: const Text('Register'),
              ),
            ),

            // const SizedBox(height: 12.0),
            // buildLoginOption('Continue with Google', 'assets/google.webp', () {
            //   // Handle Google sign-in
            //   viewModel.loginWithGoogle();
            // }),
            // const SizedBox(height: 12.0),
            // buildLoginOption('Continue with Apple', 'assets/apple.png', () {
            //   viewModel.loginWithApple();
            // }),

            const SizedBox(height: 32.0),
            Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(),
                  buildLoginOption('Continue with \n Google', 'assets/google.webp', () {
                    // Handle Google sign-in
                    viewModel.loginWithGoogle();
                  }),
                  Spacer(),
                  buildLoginOption('Continue with \nApple', 'assets/apple.png', () {
                    viewModel.loginWithApple();
                  }),
                  Spacer(),
                ],
              ),

          ],
        ),
      ),
    );
  }

  Widget buildLoginOption(String title, String imagePath, Function() onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.only(top: 12, bottom: 12),
        child: Row(
          children: [
            Image.asset(
              imagePath,
              height: 25.0,
            ),
            const SizedBox(width: 6.0),
            Text(title),
          ],
        ),
      ),
    );
  }

  void login(BuildContext context) {
    viewModel.login(usernameController.text, passwordController.text);
  }

  void listenToViewModel() {
    viewModel.removeListener(listenerFunction);
    viewModel.addListener(listenerFunction);
    viewModel.addListener(() {
      showResultDialog(context, viewModel.result!, () {
        if (viewModel.result!.isSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => TabBarScreen(), // Replace TabBarScreen with your actual TabBar implementation
            ),
          );
        }
        viewModel.result = null;
      });
    });
  }


  void listenerFunction() {
    // Callback logic
    showResultDialog(context, viewModel.result!, () {
      if (viewModel.result!.isSuccess) {
        Navigator.pop(context, true);
      }
      viewModel.result = null;
    });
  }

}
