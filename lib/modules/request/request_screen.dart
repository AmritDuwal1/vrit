
import 'package:flutter/material.dart';
import 'package:poultry/extensions/string_extension.dart';

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
          status: (cartItem.status ?? "Pending").formatAndCapitalize, // Replace with the actual status
          date: cartItem.createdAt.toString(), // Replace with the actual date
          numberOfCrates: cartItem.numberOfCrates ?? 1,
          customerName: cartItem.user?.username ?? "",
          customerNumber: cartItem.user?.phoneNumber ?? "",
          customerImage: 'https://example.com/image.jpg', // Replace with the actual customer image URL
          eggType: cartItem.eggType ?? "Hen",
          onUpdateStatus: (status) {
            // Call updateRequestStatus method from RequestViewModel
            Provider.of<RequestViewModel>(context, listen: false).updateRequestStatus(
              status: status,
              itemId: cartItem.id ?? 0,
            );
          },
        );
      },
    );
  }
}

// class RequestItem extends StatelessWidget {
//   final String orderNumber;
//   final String status;
//   final String date;
//   final int numberOfCrates;
//   final String customerName;
//   final String customerNumber;
//   final String customerImage;
//   final Function(String) onUpdateStatus; // Callback to update status
//
//   const RequestItem({
//     required this.orderNumber,
//     required this.status,
//     required this.date,
//     required this.numberOfCrates,
//     required this.customerName,
//     required this.customerNumber,
//     required this.customerImage,
//     required this.onUpdateStatus, // Pass callback to constructor
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final userRole = GlobalConstants.getUser()?.role;
//
//     return Card(
//       elevation: 2,
//       margin: EdgeInsets.symmetric(vertical: 8),
//       child: ListTile(
//         title: Text(orderNumber),
//         subtitle: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Status: $status'),
//             Text('Date: ${date.formatDateString()}'),
//             Text('Number of Crates: $numberOfCrates'),
//             if (userRole == "owner") Text('Customer: $customerName'),
//             Text('Contact: $customerNumber'),
//           ],
//         ),
//         trailing: _buildTrailingWidget(userRole),
//       ),
//     );
//   }
//
//   Widget? _buildTrailingWidget(String? userRole) {
//     if (userRole == "owner") {
//       return PopupMenuButton<String>(
//         itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
//           PopupMenuItem<String>(
//             value: 'pending',
//             child: Text('pending'),
//           ),
//           PopupMenuItem<String>(
//             value: 'on_the_way',
//             child: Text('On the Way'),
//           ),
//           PopupMenuItem<String>(
//             value: 'completed',
//             child: Text('Completed'),
//           ),
//           PopupMenuItem<String>(
//             value: 'rejected',
//             child: Text('Rejected'),
//           ),
//         ],
//         onSelected: (String value) {
//           // Handle status update based on selected value
//           // _handleStatusUpdate(value);
//           onUpdateStatus(value); // Call callback with selected value
//         },
//       );
//     } else {
//       return IconButton(
//         icon: Icon(Icons.cancel),
//         onPressed: () {
//           // Handle cancel action
//           // This could be showing a confirmation dialog and updating status accordingly
//           // For simplicity, let's assume we just log the action
//           print('Cancel action for order: $orderNumber');
//           onUpdateStatus("cancelled"); // Call callback with selected value
//         },
//       );
//     }
//   }
//
// }


class RequestItem extends StatelessWidget {
  final String orderNumber;
  final String status;
  final String date;
  final int numberOfCrates;
  final String customerName;
  final String customerNumber;
  final String customerImage;
  final String eggType;
  final Function(String) onUpdateStatus; // Callback to update status

  const RequestItem({
    required this.orderNumber,
    required this.status,
    required this.date,
    required this.numberOfCrates,
    required this.customerName,
    required this.customerNumber,
    required this.customerImage,
    required this.onUpdateStatus, // Pass callback to constructor
    required this.eggType,
  });

  @override
  Widget build(BuildContext context) {
    final userRole = GlobalConstants.getUser()?.role;
    Color cardColor = _getStatusColor(status);

    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 8),
      color: cardColor,
      child: ListTile(
        title: Text(orderNumber),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Status: $status'),
            Text('Egg Type: $eggType'),
            Text('Date: ${date.formatDateString()}'),
            Text('Number of Crates: $numberOfCrates'),
            if (userRole == "owner") Text('Customer: $customerName'),
            Text('Contact: $customerNumber'),
          ],
        ),
        trailing: _buildTrailingWidget(userRole),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.reverseFormatAndCapitalize) {
      case 'pending':
        return Colors.yellow[100] ?? Colors.yellow;
      case 'on_the_way':
        return Colors.blue[100] ?? Colors.blue;
      case 'completed':
        return Colors.green[100] ?? Colors.green;
      case 'rejected':
        return Colors.red[100] ?? Colors.red;
      case 'cancelled':
        return Colors.grey[100] ?? Colors.grey;
      default:
        return Colors.white; // Default color
    }
  }

  Widget? _buildTrailingWidget(String? userRole) {
    if (userRole == "owner") {
      return PopupMenuButton<String>(
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          PopupMenuItem<String>(
            value: 'pending',
            child: Text('pending'),
          ),
          PopupMenuItem<String>(
            value: 'on_the_way',
            child: Text('On the Way'),
          ),
          PopupMenuItem<String>(
            value: 'completed',
            child: Text('Completed'),
          ),
          PopupMenuItem<String>(
            value: 'rejected',
            child: Text('Rejected'),
          ),
        ],
        onSelected: (String value) {
          onUpdateStatus(value); // Call callback with selected value
        },
      );
    } else {
      return IconButton(
        icon: Icon(Icons.cancel),
        onPressed: () {
          print('Cancel action for order: $orderNumber');
          onUpdateStatus("cancelled"); // Call callback with selected value
        },
      );
    }
  }
}
