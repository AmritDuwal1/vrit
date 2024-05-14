
import 'package:flutter/material.dart';
import 'package:poultry/helper/show_result_dialog.dart';
import 'package:poultry/model/cart_item.dart';
import 'package:poultry/modules/cart/cart_view_model.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Your Cart:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Expanded(
              child: CartPage(),
            ),
          ],
        ),
      ),
    );
  }
}

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int _numberOfCrates = 1;
  String _selectedEggType = 'Hen';


  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      listenToViewModel();
    });

  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CartViewModel>(context, listen: false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Number of Crates:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.remove),
              onPressed: () {
                setState(() {
                  if (_numberOfCrates > 1) {
                    _numberOfCrates--;
                  }
                });
              },
            ),
            Text(
              '$_numberOfCrates',
              style: TextStyle(fontSize: 16),
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                setState(() {
                  _numberOfCrates++;
                });
              },
            ),
          ],
        ),
        SizedBox(height: 16),
        Text(
          'Select Egg Type:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        DropdownButton<String>(
          value: _selectedEggType,
          onChanged: (String? newValue) {
            setState(() {
              _selectedEggType = newValue!;
            });
          },
          items: <String>['Hen', 'Duck']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            viewModel.addItemToCart(
              CartItem(
                numberOfCrates: _numberOfCrates,
                eggType: _selectedEggType,
              ),
            );
          },
          child: Text('Add to Cart'),
        ),
      ],
    );
  }

  void listenToViewModel() {
    Provider.of<CartViewModel>(context, listen: false).removeListener(listenerFunction);
    Provider.of<CartViewModel>(context, listen: false).addListener(listenerFunction);
  }

  void listenerFunction() {
   var viewModel = Provider.of<CartViewModel>(context, listen: false);
    showResultDialog(context, viewModel.result!, () {
      if (viewModel.result!.isSuccess) {
        // Navigator.pop(context, true);

      }
      viewModel.result = null;
    });
  }

}
