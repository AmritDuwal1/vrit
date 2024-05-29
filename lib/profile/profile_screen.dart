// import 'package:flutter/material.dart';
// import 'package:poultry/modules/edit_profile/edit_profile.dart';
//
//
// import 'package:poultry/modules/login/login_screen.dart';
// import 'package:poultry/path_collection.dart';
// import 'package:poultry/profile/profile_view_model.dart';
//
// class ProfileScreen extends StatefulWidget {
//   final VoidCallback onLogout;
//   const ProfileScreen({Key? key, required this.onLogout});
//
//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(Duration.zero, () {
//       Provider.of<ProfileViewModel>(context, listen: false).fetchUserDetails();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     LocalizationExtension.context = context;
//     ProfileViewModel viewModel = Provider.of<ProfileViewModel>(context);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('My Profile'.translate),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(75),
//                 child: Container(
//                   width: 150,
//                   height: 150.0,
//                   decoration: BoxDecoration(
//                     image: DecorationImage(
//                       image: ImageLoader.getImageProvider(
//                           viewModel.user?.image ?? ""),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               Center(
//                 child: Text(
//                   viewModel.user?.username ?? 'User'.translate,
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   textAlign: TextAlign.center, // Optional: This ensures the text is centered within the Text widget
//                 ),
//               ),
//               Text(
//                 viewModel.user?.email ?? 'email'.translate,
//                 style: TextStyle(fontSize: 16, color: Colors.grey),
//               ),
//               const SizedBox(height: 16),
//               Container(
//                 height: 1,
//                 color: Colors.grey,
//                 margin: const EdgeInsets.symmetric(vertical: 16),
//               ),
//               ListView(
//                 shrinkWrap: true,
//                 physics: NeverScrollableScrollPhysics(),
//                 children: [
//                   buildProfileOption('Edit Profile'.translate, Icons.edit),
//                   buildProfileOption('delete_account'.translate, Icons.delete, color: Colors.blue,
//                       onTap: () {
//                     showDialog(
//                       context: context,
//                       builder: (BuildContext context) {
//                         return AlertDialog(
//                           title:  Text('Delete Account'.translate),
//                           content:
//                                Text('are_you_sure_delete_account'.translate),
//                           actions: [
//                             TextButton(
//                               onPressed: () {
//                                 Navigator.of(context).pop(); // Close the dialog
//                               },
//                               child: Text('cancel_action'.translate),
//                             ),
//                             TextButton(
//                               onPressed: () {
//                                 listen();
//                                 viewModel.deleteUser();
//                               },
//                               child: Text('delete_account'.translate),
//                             ),
//                           ],
//                         );
//                       },
//                     );
//                   }),
//                   buildProfileOption('Logout'.translate, Icons.logout, color: Colors.blue,
//                       onTap: () {
//                         AlertDialogUtils.showConfirmationDialog(
//                           context,
//                           'Confirm Logout'.translate,
//                           'sure_logout'.translate,
//                               () {
//                             // Handle logout
//                             GlobalConstants.removeUser(); // Clear user data
//                             widget.onLogout();
//                             // Perform other logout actions
//                           },
//                           cancelButtonText: 'cancel_logout'.translate,
//                           confirmButtonText: 'Sign Out'.translate,
//                         );
//
//                       }),
//                 ],
//               ),
//               const SizedBox(height: 16),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//
//
//   void listen() {
//     ProfileViewModel viewModel = Provider.of<ProfileViewModel>(context, listen: false);
//
//     // Remove any existing listener
//     viewModel.removeListener(listenerFunction);
//
//     // Add the new listener
//     viewModel.addListener(listenerFunction);
//   }
//
//
//   void listenerFunction() {
//     ProfileViewModel viewModel = Provider.of<ProfileViewModel>(context, listen: false);
//
//     if (viewModel.result != null) {
//       showResultDialog(context, viewModel.result!, () {
//         if (viewModel.result!.isSuccess) {
//           GlobalConstants.removeUser(); // Clear user data
//           widget.onLogout();
//           Navigator.of(context).pop();
//         }
//         viewModel.result = null;
//       });
//     }
//   }
//
//   Widget buildProfileOption(String title, IconData icon,
//       {Color? color, VoidCallback? onTap}) {
//     return ListTile(
//       title: Text(
//         title,
//         style: const TextStyle(fontSize: 16),
//       ),
//       leading: Icon(
//         icon,
//         color: color ?? Colors.blue,
//       ),
//       onTap: onTap != null
//           ? onTap
//           : () {
//               if (title == 'Edit Profile'.translate) {
//                 if (!GlobalConstants.isLoggedIn) {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => LoginScreen(),
//                     ),
//                   );
//                 } else {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => EditProfileScreen(
//                             user: GlobalConstants.getUser())), // Navigate to EditProfileScreen
//                   );
//                 }
//               }
//             },
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:poultry/helper/language_change_provider.dart';
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
  // Define language options (for example)
  List<Map<String, String>> languageOptions = [
    {"code": "en", "name": "English"},
    {"code": "es", "name": "नेपाली"}
  ];

  String selectedLanguageCode = GlobalConstants.getSelectedLanguage();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<ProfileViewModel>(context, listen: false).fetchUserDetails();
    });
  }

  @override
  Widget build(BuildContext context) {
    LocalizationExtension.context = context;
    ProfileViewModel viewModel = Provider.of<ProfileViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'.translate),
        actions: [
          // Language selection dropdown
          DropdownButton(
            value: selectedLanguageCode,
            items: languageOptions.map((language) {
              return DropdownMenuItem(
                value: language["code"],
                child: Text(language["name"]!),
              );
            }).toList(),
            onChanged: (String? code) {
              if (code != null) {
                setState(() {
                  selectedLanguageCode = code;
                  GlobalConstants.saveSelectedLanguage(code);
                });
              }
            },
          ),
          SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ClipRRect(
              //   borderRadius: BorderRadius.circular(75),
              //   child: Container(
              //     width: 150,
              //     height: 150.0,
              //     decoration: BoxDecoration(
              //       image: DecorationImage(
              //         image: ImageLoader.getImageProvider(
              //             viewModel.user?.image ?? ""),
              //         fit: BoxFit.cover,
              //       ),
              //     ),
              //   ),
              // ),

              ClipRRect(
                borderRadius: BorderRadius.circular(80),
                child: Container(
                  width: 160,
                  height: 160.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(File(GlobalConstants.getImagePath() ?? ""))
                      ,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  viewModel.user?.username ?? 'User'.translate,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              Text(
                viewModel.user?.email ?? 'email'.translate,
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
                  buildProfileOption('Edit Profile'.translate, Icons.edit),
                  buildProfileOption('delete_account'.translate, Icons.delete, color: Colors.blue,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title:  Text('Delete Account'.translate),
                              content:
                              Text('are_you_sure_delete_account'.translate),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(); // Close the dialog
                                  },
                                  child: Text('cancel_action'.translate),
                                ),
                                TextButton(
                                  onPressed: () {
                                    listen();
                                    viewModel.deleteUser();
                                  },
                                  child: Text('delete_account'.translate),
                                ),
                              ],
                            );
                          },
                        );
                      }),
                  buildProfileOption('Logout'.translate, Icons.logout, color: Colors.blue,
                      onTap: () {
                        AlertDialogUtils.showConfirmationDialog(
                          context,
                          'Confirm Logout'.translate,
                          'sure_logout'.translate,
                              () {
                            // Handle logout
                            GlobalConstants.removeUser(); // Clear user data
                            widget.onLogout();
                            // Perform other logout actions
                          },
                          cancelButtonText: 'cancel_logout'.translate,
                          confirmButtonText: 'Sign Out'.translate,
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
    viewModel.removeListener(listenerFunction);
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
        if (title == 'Edit Profile'.translate) {
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
                      user: GlobalConstants.getUser())),
            );
          }
        }
      },
    );
  }
}

