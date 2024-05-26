
import 'package:flutter/material.dart';
import 'package:poultry/extensions/string_extension.dart';


import 'package:poultry/modules/request/request_view_model.dart';
import 'package:poultry/path_collection.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart'; // Import provider package

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
    LocalizationExtension.context = context;
    return Scaffold(
      appBar: AppBar(
        title: Text('Requests'.translate),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'today_requests'.translate + ':',
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
                    return Center(child: Text('${"Error".translate}: ${model.error}'));
                  } else if (model.cartItems != null && model.cartItems!.isEmpty) {
                    // Show empty data message
                    return EmptyDataMessage(message: 'no_orders_found'.translate);
                  } else {
                    // Show list when data is loaded
                    return RequestList(cartItems: model.cartItems!, scrollController: _scrollController, context: context,);
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
  final BuildContext context; // Add context parameter

  const RequestList({
    required this.cartItems,
    required this.scrollController,
    required this.context, // Accept context parameter
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController, // Attach the scroll controller here
      itemCount: cartItems.length,
      itemBuilder: (BuildContext context, int index) {
        final cartItem = cartItems[index];
        return RequestItem(
          // orderNumber: "#Request Number: ${cartItem.id.toString()}",
          orderNumber: "${'request_number'.translate}: ${cartItem.id.toString()}",
          status: "${(cartItem.status ?? "Pending"
          .translate).formatAndCapitalize}".translate, // Replace with the actual status
          date: cartItem.createdAt.toString(), // Replace with the actual date
          numberOfCrates: cartItem.numberOfCrates ?? 1,
          customerName: cartItem.user?.username ?? "",
          customerNumber: cartItem.user?.phoneNumber ?? "",
          customerImage: 'https://example.com/image.jpg', // Replace with the actual customer image URL
          eggType: "${cartItem.eggType ?? "Hen"}".translate,
          onUpdateStatus: (status) {
            // Call updateRequestStatus method from RequestViewModel
            Provider.of<RequestViewModel>(context, listen: false).updateRequestStatus(
              status: status,
              itemId: cartItem.id ?? 0,
            );
          },
          context: context, // Pass context to RequestItem
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
  final String eggType;
  final Function(String) onUpdateStatus; // Callback to update status
  final BuildContext context; // Add context parameter

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
    required this.context, // Accept context parameter

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
        title: Text("# ${orderNumber}",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PrimaryText(text: '${"Status".translate}: $status'),
            PrimaryText(text: '${"egg_type".translate}: $eggType'),
            PrimaryText(text: '${"Date".translate}: ${date.formatDateString()}'),
            PrimaryText(text: '${"number_of_crates".translate}: $numberOfCrates'),
            if (userRole == "owner") Text('${"Customer".translate}: $customerName',
              style: TextStyle(fontSize: 22),),
            // Text('${"Contact".translate}: $customerNumber'),
            Row(
              children: [
                PrimaryText(text: '${"Contact".translate}: $customerNumber'),
                IconButton(
                  icon: Icon(Icons.call),
                  onPressed: () {
                    final Uri phoneUri = Uri(scheme: 'tel', path: customerNumber);
                    launchUrl(phoneUri);
                  },
                ),
              ],
            ),
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
            child: Text('pending'.translate),
          ),
          PopupMenuItem<String>(
            value: 'on_the_way',
            child: Text('on_the_way'.translate),
          ),
          PopupMenuItem<String>(
            value: 'completed',
            child: Text('Completed'.translate),
          ),
          PopupMenuItem<String>(
            value: 'rejected',
            child: Text('Rejected'.translate),
          ),
        ],
        onSelected: (String value) {
          onUpdateStatus(value); // Call callback with selected value
        },
      );
    } else {
      if (status.toLowerCase() == 'cancelled') {
        return null; // Return null to hide the trailing widget
      }
      return IconButton(
        icon: Icon(Icons.cancel),
        onPressed: () {
          // print('Cancel action for order: $orderNumber');
          AlertDialogUtils.showConfirmationDialog(
            context,
            'Confirmation'.translate,
            'Are you sure you want to proceed?',
                () {
              // Handle confirmation
              print('User confirmed action');
              onUpdateStatus("cancelled"); // Call callback with selected value
            },
            cancelButtonText: 'Cancel'.translate, // Optional: Custom cancel button text
            confirmButtonText: 'Proceed'.translate, // Optional: Custom confirm button text
            showCancelButton: true, // Optional: Whether to show the cancel button
          );
        },
      );
    }
  }
}
