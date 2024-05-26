// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:poultry/path_collection.dart';
// import 'dart:io';
//
// import 'package:poultry/modules/edit_profile/edit_profile_view_model.dart';
//
// class EditProfileScreen extends StatefulWidget {
//   final User? user;
//
//   EditProfileScreen({required this.user});
//
//   @override
//   _EditProfileScreenState createState() => _EditProfileScreenState();
// }
//
// class _EditProfileScreenState extends State<EditProfileScreen> {
//   TextEditingController _usernameController = TextEditingController();
//   TextEditingController _emailController = TextEditingController();
//   TextEditingController _firstNameController = TextEditingController();
//   TextEditingController _lastNameController = TextEditingController();
//   TextEditingController _phoneNumberController = TextEditingController();
//   String? _imagePath;
//
//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(Duration.zero, () {
//       Provider.of<EditProfileViewModel>(context, listen: false).user = widget.user;
//       User? userFromProvider = Provider.of<EditProfileViewModel>(context, listen: false).user;
//       _usernameController.text = userFromProvider?.username ?? "";
//       _emailController.text = userFromProvider?.email ?? "";
//       _firstNameController.text = userFromProvider?.firstName ?? "";
//       _lastNameController.text = userFromProvider?.lastName ?? "";
//       _phoneNumberController.text = userFromProvider?.phoneNumber ?? "";
//     });
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     EditProfileViewModel viewModel = Provider.of<EditProfileViewModel>(context);
//
//     if (viewModel.error != null) {
//       String errorMessage =  viewModel.error?.message ?? "Something Went Wrong!";
//       viewModel.error = null;
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               // title: Text(''),
//               content: Text(errorMessage),
//               actions: <Widget>[
//                 TextButton(
//                   onPressed: () {
//                     // setState(() {
//                     //   Navigator.of(context).popUntil((route) => route.isFirst);
//                     // });
//                     Navigator.of(context).pop();
//                     Navigator.of(context).pop();
//                   },
//                   child: Text('OK'),
//                 ),
//               ],
//             );
//           },
//         );
//       });
//     }
//
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Edit Profile'),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//
//
//
//             Center(child: _buildImagePicker()),
//             SizedBox(height: 20),
//             TextFormField(
//               controller: _usernameController,
//               readOnly: true,
//               decoration: InputDecoration(labelText: 'Username'),
//             ),
//             TextFormField(
//               controller: _emailController,
//               decoration: InputDecoration(labelText: 'Email'),
//             ),
//             TextFormField(
//               controller: _firstNameController,
//               decoration: InputDecoration(labelText: 'First Name'),
//             ),
//             TextFormField(
//               controller: _lastNameController,
//               decoration: InputDecoration(labelText: 'Last Name'),
//             ),
//             TextFormField(
//               controller: _phoneNumberController,
//               decoration: InputDecoration(labelText: 'Phone Number'),
//             ),
//             SizedBox(height: 30),
//
//             PrimaryButton(text: 'Save', onPressed: () {
//             viewModel.updateProfile(
//               _emailController.text,
//               _firstNameController.text,
//               _lastNameController.text,
//               _usernameController.text,
//               _phoneNumberController.text,
//               _imagePath,
//             );
//             }, fullWidth: true)
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildImagePicker() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         // Text('Profile Image'),
//         // SizedBox(height: 10),
//         GestureDetector(
//           onTap: () {
//             _showImagePicker(context);
//           },
//           child:
//           ClipRRect(
//             borderRadius: BorderRadius.circular(80),
//             child: Container(
//               width: 160,
//               height: 160.0,
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: _imagePath != null
//                       ? FileImage(File(_imagePath!))
//                       : ImageLoader.getImageProvider(
//                     widget.user?.image ?? "",
//                   ),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   void _showImagePicker(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       builder: (BuildContext context) {
//         return SafeArea(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               ListTile(
//                 leading: Icon(Icons.camera),
//                 title: Text('Take a photo'),
//                 onTap: () {
//                   _getImage(ImageSource.camera);
//                   Navigator.of(context).pop();
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.image),
//                 title: Text('Choose from gallery'),
//                 onTap: () {
//                   _getImage(ImageSource.gallery);
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   Future<void> _getImage(ImageSource source) async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: source);
//
//     setState(() {
//       if (pickedFile != null) {
//         _imagePath = pickedFile.path;
//       }
//     });
//   }
//
//
// }


import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:poultry/path_collection.dart';
import 'dart:io';

import 'package:poultry/modules/edit_profile/edit_profile_view_model.dart';

class EditProfileScreen extends StatefulWidget {
  final User? user;

  EditProfileScreen({required this.user});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  String? _imagePath;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<EditProfileViewModel>(context, listen: false).user = widget.user;
      User? userFromProvider = Provider.of<EditProfileViewModel>(context, listen: false).user;
      _usernameController.text = userFromProvider?.username ?? "";
      _emailController.text = userFromProvider?.email ?? "";
      _firstNameController.text = userFromProvider?.firstName ?? "";
      _lastNameController.text = userFromProvider?.lastName ?? "";
      _phoneNumberController.text = userFromProvider?.phoneNumber ?? "";
    });

  }

  @override
  Widget build(BuildContext context) {
    LocalizationExtension.context = context;
    EditProfileViewModel viewModel = Provider.of<EditProfileViewModel>(context);

    if (viewModel.error != null) {
      String errorMessage =  viewModel.error?.message ?? "Something Went Wrong!";
      viewModel.error = null;
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              // title: Text(''),
              content: Text(errorMessage.translate),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    // setState(() {
                    //   Navigator.of(context).popUntil((route) => route.isFirst);
                    // });
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'.translate),
                ),
              ],
            );
          },
        );
      });
    }


    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'.translate),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: _buildImagePicker()),
            SizedBox(height: 20),
            TextFormField(
              controller: _usernameController,
              readOnly: true,
              decoration: InputDecoration(labelText: 'Username'.translate),
            ),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'.translate),
            ),
            TextFormField(
              controller: _firstNameController,
              decoration: InputDecoration(labelText: 'First Name'.translate),
            ),
            TextFormField(
              controller: _lastNameController,
              decoration: InputDecoration(labelText: 'Last Name'.translate),
            ),
            TextFormField(
              controller: _phoneNumberController,
              decoration: InputDecoration(labelText: 'Phone Number'.translate),
            ),
            SizedBox(height: 30),
            PrimaryButton(text: 'Save'.translate, onPressed: () {
              viewModel.updateProfile(
                _emailController.text,
                _firstNameController.text,
                _lastNameController.text,
                _usernameController.text,
                _phoneNumberController.text,
                _imagePath,
              );
            }, fullWidth: true)
          ],
        ),
      ),
    );
  }

  Widget _buildImagePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            _showImagePicker(context);
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(80),
            child: Container(
              width: 160,
              height: 160.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: _imagePath != null
                      ? FileImage(File(_imagePath!))
                      : ImageLoader.getImageProvider(
                    widget.user?.image ?? "",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showImagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.camera),
                title: Text('Take a photo'.translate),
                onTap: () {
                  _getImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.image),
                title: Text('Choose from gallery'.translate),
                onTap: () {
                  _getImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _getImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _imagePath = pickedFile.path;
      }
    });
  }
}
