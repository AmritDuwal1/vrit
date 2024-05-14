
import 'package:flutter/material.dart';

import 'package:poultry/modules/request/request_view_model.dart';
import 'package:poultry/path_collection.dart';
import 'package:provider/provider.dart'; // Import provider package

class RequestScreen extends StatefulWidget {

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    Provider.of<RequestViewModel>(context, listen: false).currentPage = null;
    // Fetch initial data
    Provider.of<RequestViewModel>(context, listen: false).fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Requests'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Today Requests:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Expanded(
              child: Consumer<RequestViewModel>(
                builder: (context, model, child) {
                  // Show spinner while loading data
                  // if (model.isLoading && model.currentPage == 1) {
                  //   return Center(child: CircularProgressIndicator());
                  // }
                  // // Show list when data is loaded
                  // else if (model.cartItems != null) {
                  //   return RequestList(cartItems: model.cartItems!, scrollController: _scrollController,);
                  // }
                  // // Show error message if there's an error
                  // else if (model.error != null) {
                  //   return Center(child: Text('Error: ${model.error}'));
                  // }
                  // // Show empty state if there are no cart items
                  // else {
                  //   return Center(child: Text('No orders found.'));
                  // }

                  if (model.isLoading && model.currentPage == 1) {
                    // Show loading indicator
                    return Center(child: CircularProgressIndicator());
                  } else if (model.error != null) {
                    // Show error message
                    return Center(child: Text('Error: ${model.error}'));
                  } else if (model.cartItems != null && model.cartItems!.isEmpty) {
                    // Show empty data message
                    return EmptyDataMessage(message: 'No orders found.');
                  } else {
                    // Show list when data is loaded
                    return RequestList(cartItems: model.cartItems!, scrollController: _scrollController);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _scrollListener() {
    final model = Provider.of<RequestViewModel>(context, listen: false);
    if (_scrollController.offset >=
        _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      // At the bottom of the list, load more data
      if (model.arrayContainer?.pagination?.next != null) {
        model.fetchData(); // Load more data
      }
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }
}


class RequestList extends StatelessWidget {
  final List<CartItem> cartItems;
  final ScrollController scrollController;

  const RequestList({
    required this.cartItems,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController, // Attach the scroll controller here
      itemCount: cartItems.length,
      itemBuilder: (BuildContext context, int index) {
        final cartItem = cartItems[index];
        return RequestItem(
          orderNumber: "#Request Number: ${cartItem.id.toString()}",
          status: 'Pending', // Replace with the actual status
          date: cartItem.createdAt.toString(), // Replace with the actual date
          numberOfCrates: cartItem.numberOfCrates ?? 1,
          customerName: cartItem.user?.username ?? "",
          customerNumber: cartItem.user?.phoneNumber ?? "",
          customerImage: 'https://example.com/image.jpg', // Replace with the actual customer image URL
        );
      },
    );
  }
}


class RequestItem extends StatelessWidget {
  final String orderNumber;
  final String status;
  final String date;
  final int numberOfCrates;
  final String customerName;
  final String customerNumber;
  final String customerImage;

  const RequestItem({
    required this.orderNumber,
    required this.status,
    required this.date,
    required this.numberOfCrates,
    required this.customerName,
    required this.customerNumber,
    required this.customerImage,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(orderNumber),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Status: $status'),
            Text('Date: ${date.formatDateString()}'),
            Text('Number of Crates: $numberOfCrates'),
            if (GlobalConstants.getUser()?.role == "owner")
              Text('Customer: $customerName'),
            Text('Contact: $customerNumber'),
          ],
        ),
        // leading: CircleAvatar(
        //   backgroundImage: NetworkImage(customerImage),
        // ),
        trailing: IconButton(
          icon: Icon(Icons.info),
          onPressed: () {
          },
        ),
      ),
    );
  }

}