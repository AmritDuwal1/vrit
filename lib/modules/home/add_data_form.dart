// import 'package:flutter/material.dart';
// import 'package:poultry/modules/home/home_view_model.dart';
// import 'package:poultry/path_collection.dart';
//
// class AddDataForm extends StatefulWidget {
//   @override
//   _AddDataFormState createState() => _AddDataFormState();
// }
//
// class _AddDataFormState extends State<AddDataForm> {
//   final _formKey = GlobalKey<FormState>();
//   late TextEditingController _henDiedController;
//   late TextEditingController _filledCratesController;
//   late TextEditingController _henSoldController;
//   late TextEditingController _eggPriceController;
//
//   @override
//   void initState() {
//     super.initState();
//     _henDiedController = TextEditingController();
//     _filledCratesController = TextEditingController();
//     _henSoldController = TextEditingController();
//     _eggPriceController = TextEditingController();
//   }
//
//   @override
//   void dispose() {
//     _henDiedController.dispose();
//     _filledCratesController.dispose();
//     _henSoldController.dispose();
//     _eggPriceController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           TextFormField(
//             controller: _henDiedController,
//             keyboardType: TextInputType.number,
//             decoration: InputDecoration(labelText: 'total_hen_died'.translate),
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'please_enter_total_hen_died'.translate;
//               }
//               return null;
//             },
//           ),
//           TextFormField(
//             controller: _filledCratesController,
//             keyboardType: TextInputType.number,
//             decoration: InputDecoration(labelText: 'total_filled_crates'.translate),
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'please_enter_total_filled_crates'.translate;
//               }
//               return null;
//             },
//           ),
//           TextFormField(
//             controller: _henSoldController,
//             keyboardType: TextInputType.number,
//             decoration: InputDecoration(labelText: 'total_hen_sold'.translate),
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'please_enter_total_hen_sold'.translate;
//               }
//               return null;
//             },
//           ),
//           TextFormField(
//             controller: _eggPriceController,
//             keyboardType: TextInputType.number,
//             decoration: InputDecoration(labelText: "egg_price_optional".translate),
//             validator: (value) {
//               // No validation logic for egg price, allowing it to be empty
//               return null;
//             },
//           ),
//           SizedBox(height: 16),
//           SizedBox(
//             width: double.infinity,
//             child: ElevatedButton(
//               onPressed: () {
//                 if (_formKey.currentState!.validate()) {
//                   // Process form data here
//                   final int totalHenDied = int.parse(_henDiedController.text);
//                   final int totalFilledCrates = int.parse(_filledCratesController.text);
//                   final int totalHenSold = int.parse(_henSoldController.text);
//                   double? todayEggPrice;
//                   if (_eggPriceController.text.isNotEmpty) {
//                     todayEggPrice = double.parse(_eggPriceController.text);
//                   }
//                   // Perform action with the data, such as submitting it
//                   if (totalHenDied > -1 && totalFilledCrates != 0 && totalHenSold != 0) {
//                     _submitFormData(context);
//                   }
//                 }
//
//               },
//               child: Text('Submit'.translate),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _submitFormData(BuildContext context) {
//     if (_formKey.currentState!.validate()) {
//       final int totalHenDied = int.parse(_henDiedController.text);
//       final int totalFilledCrates = int.parse(_filledCratesController.text);
//       final int totalHenSold = int.parse(_henSoldController.text);
//       double? todayEggPrice;
//       if (_eggPriceController.text.isNotEmpty) {
//         todayEggPrice = double.parse(_eggPriceController.text);
//       }
//
//       Provider.of<HomeViewModel>(context, listen: false).submitFormData(
//         totalHenDied: totalHenDied,
//         totalFilledCrates: totalFilledCrates,
//         totalHenSold: totalHenSold,
//         todayEggPrice: todayEggPrice,
//       );
//     }
//   }
//
// }

//
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:poultry/modules/home/home_view_model.dart';
// import 'package:poultry/path_collection.dart';
//
// class AddDataForm extends StatefulWidget {
//   @override
//   _AddDataFormState createState() => _AddDataFormState();
// }
//
// class _AddDataFormState extends State<AddDataForm> {
//   final _formKey = GlobalKey<FormState>();
//   late TextEditingController _henDiedController;
//   late TextEditingController _filledCratesController;
//   late TextEditingController _henSoldController;
//   late TextEditingController _eggPriceController;
//
//   @override
//   void initState() {
//     super.initState();
//     _henDiedController = TextEditingController();
//     _filledCratesController = TextEditingController();
//     _henSoldController = TextEditingController();
//     _eggPriceController = TextEditingController();
//   }
//
//   @override
//   void dispose() {
//     _henDiedController.dispose();
//     _filledCratesController.dispose();
//     _henSoldController.dispose();
//     _eggPriceController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8.0),
//             child: TextFormField(
//               controller: _henDiedController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 labelText: 'total_hen_died'.translate,
//                 labelStyle: TextStyle(fontSize: 25),
//                 contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
//                 border: OutlineInputBorder(),
//               ),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'please_enter_total_hen_died'.translate;
//                 }
//                 return null;
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8.0),
//             child: TextFormField(
//               controller: _filledCratesController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 labelText: 'total_filled_crates'.translate,
//                 labelStyle: TextStyle(fontSize: 25),
//                 contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
//                 border: OutlineInputBorder(),
//               ),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'please_enter_total_filled_crates'.translate;
//                 }
//                 return null;
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8.0),
//             child: TextFormField(
//               controller: _henSoldController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 labelText: 'total_hen_sold'.translate,
//                 labelStyle: TextStyle(fontSize: 25),
//                 contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
//                 border: OutlineInputBorder(),
//               ),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'please_enter_total_hen_sold'.translate;
//                 }
//                 return null;
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8.0),
//             child: TextFormField(
//               controller: _eggPriceController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 labelText: "egg_price_optional".translate,
//                 labelStyle: TextStyle(fontSize: 25),
//                 contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
//                 border: OutlineInputBorder(),
//               ),
//               validator: (value) {
//                 // No validation logic for egg price, allowing it to be empty
//                 return null;
//               },
//             ),
//           ),
//           SizedBox(height: 16),
//           SizedBox(
//             width: double.infinity,
//             child: ElevatedButton(
//               onPressed: () {
//                 if (_formKey.currentState!.validate()) {
//                   // Process form data here
//                   final int totalHenDied = int.parse(_henDiedController.text);
//                   final int totalFilledCrates = int.parse(_filledCratesController.text);
//                   final int totalHenSold = int.parse(_henSoldController.text);
//                   double? todayEggPrice;
//                   if (_eggPriceController.text.isNotEmpty) {
//                     todayEggPrice = double.parse(_eggPriceController.text);
//                   }
//                   // Perform action with the data, such as submitting it
//                   if (totalHenDied > -1 && totalFilledCrates != 0 && totalHenSold != 0) {
//                     _submitFormData(context);
//                   }
//                 }
//               },
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 15.0),
//                 child: Text(
//                   'Submit'.translate,
//                   style: TextStyle(fontSize: 20),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _submitFormData(BuildContext context) {
//     if (_formKey.currentState!.validate()) {
//       final int totalHenDied = int.parse(_henDiedController.text);
//       final int totalFilledCrates = int.parse(_filledCratesController.text);
//       final int totalHenSold = int.parse(_henSoldController.text);
//       double? todayEggPrice;
//       if (_eggPriceController.text.isNotEmpty) {
//         todayEggPrice = double.parse(_eggPriceController.text);
//       }
//
//       Provider.of<HomeViewModel>(context, listen: false).submitFormData(
//         totalHenDied: totalHenDied,
//         totalFilledCrates: totalFilledCrates,
//         totalHenSold: totalHenSold,
//         todayEggPrice: todayEggPrice,
//       );
//     }
//   }
// }


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:poultry/modules/home/home_view_model.dart';
import 'package:poultry/path_collection.dart';

class AddDataForm extends StatefulWidget {
  @override
  _AddDataFormState createState() => _AddDataFormState();
}

class _AddDataFormState extends State<AddDataForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _henDiedController;
  late TextEditingController _filledCratesController;
  late TextEditingController _henSoldController;
  late TextEditingController _eggPriceController;

  @override
  void initState() {
    super.initState();
    _henDiedController = TextEditingController();
    _filledCratesController = TextEditingController();
    _henSoldController = TextEditingController();
    _eggPriceController = TextEditingController();
  }

  @override
  void dispose() {
    _henDiedController.dispose();
    _filledCratesController.dispose();
    _henSoldController.dispose();
    _eggPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextFormField(
              controller: _henDiedController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'total_hen_died'.translate,
                labelStyle: TextStyle(fontSize: 25),
                contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.local_hospital),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'please_enter_total_hen_died'.translate;
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextFormField(
              controller: _filledCratesController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'total_filled_crates'.translate,
                labelStyle: TextStyle(fontSize: 25),
                contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.storage),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'please_enter_total_filled_crates'.translate;
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextFormField(
              controller: _henSoldController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'total_hen_sold'.translate,
                labelStyle: TextStyle(fontSize: 25),
                contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.shopping_cart),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'please_enter_total_hen_sold'.translate;
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextFormField(
              controller: _eggPriceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "egg_price_optional".translate,
                labelStyle: TextStyle(fontSize: 25),
                contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.attach_money),
              ),
              validator: (value) {
                // No validation logic for egg price, allowing it to be empty
                return null;
              },
            ),
          ),
          SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Process form data here
                  final int totalHenDied = int.parse(_henDiedController.text);
                  final int totalFilledCrates = int.parse(_filledCratesController.text);
                  final int totalHenSold = int.parse(_henSoldController.text);
                  double? todayEggPrice;
                  if (_eggPriceController.text.isNotEmpty) {
                    todayEggPrice = double.parse(_eggPriceController.text);
                  }
                  // Perform action with the data, such as submitting it
                  if (totalHenDied > -1 && totalFilledCrates != 0 && totalHenSold != 0) {
                    _submitFormData(context);
                  }
                }
              },
              icon: Icon(Icons.send),
              label: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Text(
                  'submit'.translate,
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _submitFormData(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final int totalHenDied = int.parse(_henDiedController.text);
      final int totalFilledCrates = int.parse(_filledCratesController.text);
      final int totalHenSold = int.parse(_henSoldController.text);
      double? todayEggPrice;
      if (_eggPriceController.text.isNotEmpty) {
        todayEggPrice = double.parse(_eggPriceController.text);
      }

      Provider.of<HomeViewModel>(context, listen: false).submitFormData(
        totalHenDied: totalHenDied,
        totalFilledCrates: totalFilledCrates,
        totalHenSold: totalHenSold,
        todayEggPrice: todayEggPrice,
      );
    }
  }
}
