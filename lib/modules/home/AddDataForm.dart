import 'package:flutter/material.dart';
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
          TextFormField(
            controller: _henDiedController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Total Number of Hen Died'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the total number of hen died';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _filledCratesController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Total Number of Filled Crates'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the total number of filled crates';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _henSoldController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Total Number of Hen Sold'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the total number of hen sold';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _eggPriceController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: "Today's Egg Price (Optional)"),
            validator: (value) {
              // No validation logic for egg price, allowing it to be empty
              return null;
            },
          ),
          SizedBox(height: 16),
          ElevatedButton(
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
                _submitFormData();
              }
            },
            child: Text('Submit'),
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
