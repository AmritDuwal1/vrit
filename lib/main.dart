import 'package:flutter/material.dart';
import 'package:poultry/helper/alert_manager.dart';
import 'package:poultry/helper/global_constants.dart';
import 'package:poultry/modules/cart/cart_view_model.dart';
import 'package:poultry/modules/edit_profile/edit_profile_view_model.dart';
import 'package:poultry/modules/home/home_view_model.dart';
import 'package:poultry/modules/login//login_screen.dart';
import 'package:poultry/modules/request/request_view_model.dart';
import 'package:poultry/path_collection.dart';
import 'package:poultry/profile/profile_view_model.dart';
import 'package:poultry/tabbar/tabbar_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalConstants.initSharedPreferences(); // Initialize SharedPreferences
  User? user = GlobalConstants.getUser(); // Retrieve user from SharedPreferences
  Widget homeScreen = user != null ? TabBarScreen() : LoginScreen(); // Determine the home screen based on user login status

  // runApp(const MyApp());
  runApp(MyApp(homeScreen: homeScreen));
}

class MyApp extends StatelessWidget {
  final Widget homeScreen;

  // const MyApp({super.key});
   MyApp({Key? key, required this.homeScreen}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeViewModel>(
          create: (context) => HomeViewModel(),
        ),
        // ChangeNotifierProvider<BaseViewModel>(
        //   create: (context) {
        //     // Create the BaseViewModel instance
        //     BaseViewModel viewModel = BaseViewModel();
        //
        //
        //     // showResultDialog(context, viewModel.result!, () {
        //     //   viewModel.result = null;
        //     // });
        //
        //     // Add a listener to viewModel.result
        //     viewModel.addListener(() {
        //       // Check if viewModel.result is not null
        //       if (viewModel.result != null) {
        //         // Show the result dialog
        //         showResultDialog(context, viewModel.result!, () {
        //           viewModel.result = null;
        //         });
        //       }
        //     });
        //
        //     return viewModel;
        //   },
        // ),
        ChangeNotifierProvider<ProfileViewModel>(
          create: (context) => ProfileViewModel(),
        ),
        ChangeNotifierProvider<RequestViewModel>(
          create: (context) => RequestViewModel(),
        ),
        ChangeNotifierProvider<CartViewModel>(
          create: (context) => CartViewModel(),
        ),

        ChangeNotifierProvider<AlertManager>(
          create: (context) => AlertManager(),
        ),
        ChangeNotifierProvider<EditProfileViewModel>(
          create: (context) => EditProfileViewModel(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        // home: homeScreen,
        home:  StreamBuilder<bool>(
          stream: GlobalConstants.loginStatusStream,
          builder: (context, snapshot) {
              bool isLoggedIn = snapshot.data ?? false;
              return isLoggedIn ? TabBarScreen() : LoginScreen();
          },
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
