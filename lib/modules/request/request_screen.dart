

import 'package:flutter/material.dart';

class RequestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
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
              child: OrderList(),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10, // Replace with the actual number of orders
      itemBuilder: (BuildContext context, int index) {
        return OrderItem(
          orderNumber: 'Order ${index + 1}',
          status: 'Pending', // Replace with the actual status
          date: DateTime.now().toString(), // Replace with the actual date
          numberOfCrates: 10, // Replace with the actual number of crates
          customerName: 'Customer Name', // Replace with the actual customer name
          customerNumber: '1234567890', // Replace with the actual customer number
          customerImage: 'https://example.com/image.jpg', // Replace with the actual customer image URL
        );
      },
    );
  }
}

class OrderItem extends StatelessWidget {
  final String orderNumber;
  final String status;
  final String date;
  final int numberOfCrates;
  final String customerName;
  final String customerNumber;
  final String customerImage;

  const OrderItem({
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
            Text('Date: $date'),
            Text('Number of Crates: $numberOfCrates'),
            Text('Customer: $customerName'),
            Text('Contact: $customerNumber'),
          ],
        ),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(customerImage),
        ),
        trailing: IconButton(
          icon: Icon(Icons.info),
          onPressed: () {
            // Implement action to view order details
          },
        ),
      ),
    );
  }
}
