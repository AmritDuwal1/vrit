import 'package:flutter/material.dart';
import 'package:poultry/modules/edit_profile/edit_profile.dart';


import 'package:poultry/modules/login/login_screen.dart';
import 'package:poultry/path_collection.dart';
import 'package:poultry/profile/profile_view_model.dart';

class ProfileScreen extends StatefulWidget {
  final VoidCallback onLogout;
  const ProfileScreen({Key? key, required this.onLogout});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<ProfileViewModel>(context, listen: false).fetchUserDetails();
    });
  }

  @override
  Widget build(BuildContext context) {
    ProfileViewModel viewModel = Provider.of<ProfileViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(75),
                child: Container(
                  width: 150,
                  height: 150.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: ImageLoader.getImageProvider(
                          viewModel.user?.image ?? ""),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  viewModel.user?.username ?? 'User',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center, // Optional: This ensures the text is centered within the Text widget
                ),
              ),
              Text(
                viewModel.user?.email ?? 'email',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 16),
              Container(
                height: 1,
                color: Colors.grey,
                margin: const EdgeInsets.symmetric(vertical: 16),
              ),
              ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  buildProfileOption('Edit Profile', Icons.edit),
                  // buildProfileOption('Notifications', Icons.notifications),
                  // if (GlobalConstants.getUser()?.isHotelOwner == true)
                  //   buildProfileOption('Create Hotel', Icons.hotel, onTap: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => CreateAndEditHotelScreen(),
                  //       ),
                  //     );
                  //   }),
                  // if (GlobalConstants.getUser()?.isHotelOwner == true)
                  //   buildProfileOption('My Hotels', Icons.hotel_class_rounded,
                  //       onTap: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => CreatorHotelsScreen(),
                  //       ),
                  //     );
                  //   }),
                  // buildProfileOption(
                  //     GlobalConstants.getUser()?.isHotelOwner == true
                  //         ? 'Booking Requests'
                  //         : 'My Requests',
                  //     Icons.people, onTap: () {
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => BookingRequestScreen(),
                  //     ),
                  //   );
                  // }),
                  buildProfileOption('Delete Account', Icons.delete, color: Colors.blue,
                      onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Delete Account'),
                          content:
                              const Text('Are you sure you want to delete your Account?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                listen();
                                viewModel.deleteUser();
                              },
                              child: const Text('Delete'),
                            ),
                          ],
                        );
                      },
                    );
                  }),
                  buildProfileOption('Logout', Icons.logout, color: Colors.blue,
                      onTap: () {
                    // showDialog(
                    //   context: context,
                    //   builder: (BuildContext context) {
                    //     return AlertDialog(
                    //       title: const Text('Confirm Logout'),
                    //       content:
                    //           const Text('Are you sure you want to logout?'),
                    //       actions: [
                    //         TextButton(
                    //           onPressed: () {
                    //             Navigator.of(context).pop(); // Close the dialog
                    //           },
                    //           child: const Text('Cancel'),
                    //         ),
                    //         TextButton(
                    //           onPressed: () {
                    //             // Handle logout
                    //             GlobalConstants.removeUser(); // Clear user data
                    //             widget.onLogout();
                    //             Navigator.of(context).pop();
                    //             // Navigator.pushReplacement(
                    //             //   context,
                    //             //   MaterialPageRoute(builder: (context) => HomeScreen()), // Navigate to login screen
                    //             // );
                    //             // Navigator.popUntil(context, (route) => route.isFirst);
                    //           },
                    //           child: const Text('Logout'),
                    //         ),
                    //       ],
                    //     );
                    //   },
                    // );
                        AlertDialogUtils.showConfirmationDialog(
                          context,
                          'Confirm Logout',
                          'Are you sure you want to logout?',
                              () {
                            // Handle logout
                            GlobalConstants.removeUser(); // Clear user data
                            widget.onLogout();
                            // Perform other logout actions
                          },
                          cancelButtonText: 'Dismiss',
                          confirmButtonText: 'Sign Out',
                        );

                      }),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }



  void listen() {
    ProfileViewModel viewModel = Provider.of<ProfileViewModel>(context, listen: false);

    // Remove any existing listener
    viewModel.removeListener(listenerFunction);

    // Add the new listener
    viewModel.addListener(listenerFunction);
  }


  void listenerFunction() {
    ProfileViewModel viewModel = Provider.of<ProfileViewModel>(context, listen: false);

    if (viewModel.result != null) {
      showResultDialog(context, viewModel.result!, () {
        if (viewModel.result!.isSuccess) {
          GlobalConstants.removeUser(); // Clear user data
          widget.onLogout();
          Navigator.of(context).pop();
        }
        viewModel.result = null;
      });
    }
  }

  Widget buildProfileOption(String title, IconData icon,
      {Color? color, VoidCallback? onTap}) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(fontSize: 16),
      ),
      leading: Icon(
        icon,
        color: color ?? Colors.blue,
      ),
      onTap: onTap != null
          ? onTap
          : () {
              if (title == 'Edit Profile') {
                if (!GlobalConstants.isLoggedIn) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditProfileScreen(
                            user: GlobalConstants.getUser())), // Navigate to EditProfileScreen
                  );
                }
              }
            },
    );
  }
}
