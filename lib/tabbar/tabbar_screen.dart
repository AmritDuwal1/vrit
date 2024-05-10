
import 'dart:async';
import 'package:poultry/path_collection.dart';

class TabBarScreen extends StatefulWidget {
  const TabBarScreen({Key? key}) : super(key: key);

  @override
  _TabBarScreenState createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen> {
  late int _currentIndex;
  // late ProfileScreen _profileScreen;
  late StreamSubscription<bool> _loginStatusSubscription;

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
    // _profileScreen = ProfileScreen(onLogout: () {
    //   setState(() {
    //     _currentIndex = 0;
    //   });
    //   _loginStatusSubscription = GlobalConstants.loginStatusStream.listen((loggedIn) {
    //     setState(() {}); // Update the UI
    //   });
    // });
  }

  @override
  void dispose() {
    _loginStatusSubscription.cancel(); // Cancel the stream subscription
    super.dispose();
  }

  final List<Widget> _tabs = [
    const Tab1(),
    CartTab(),
    const Tab2(),
    const Tab3(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: _currentIndex == 2 ? _profileScreen : _tabs[_currentIndex],
      body:  _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: const Color(0xFF3498DC),
        unselectedItemColor: Colors.grey, // Customize the color of unselected items
        unselectedLabelStyle: TextStyle(
          fontSize: 16, // Set the font size for unselected labels
          color: Colors.blueGrey, // Set the color for unselected labels
        ),
        selectedLabelStyle: TextStyle(
          fontSize: 16, // Set the font size for unselected labels
          color: Colors.blueGrey, // Set the color for unselected labels
        ),
        items:  [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 24),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart, size: 24),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list, size: 24),
            label: 'Orders',
          ),
          // if (GlobalConstants.isLoggedIn == true)
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 24),
            label: 'Profile',
          ),
        ],
      ),

    );
  }
}

class Tab1 extends StatelessWidget {
  const Tab1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  HomeScreen();
  }
}

class Tab2 extends StatelessWidget {
  const Tab2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RequestScreen();
  }
}

class Tab3 extends StatelessWidget {
  const Tab3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProfileScreen(onLogout: () {

    });; // Placeholder for Tab3
  }
}


class CartTab extends StatelessWidget {
  const CartTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CartScreen(); // Placeholder for Tab3
  }
}
