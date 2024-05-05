//
//
// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
//
// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home'),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           buildTodayUpdateWidget(), // Display the TodayUpdateWidget at the top
//           Expanded(
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     buildSectionTitle('Number of Egg Crates Today:'),
//                     buildGraphContainer(), // Implement this method to display the graph
//                     SizedBox(height: 16),
//                     buildSectionTitle('Egg Production for the Last 30 Days:'),
//                     buildEggProductionGraph(), // Implement this method to display the egg production graph
//                     SizedBox(height: 16),
//                     buildSectionTitle('Number of Chick Deaths:'),
//                     buildGraphContainer(), // Implement this method to display the graph for chick deaths
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget buildTodayUpdateWidget() {
//     // Implement the TodayUpdateWidget here
//     return TodayUpdateWidget(
//       totalHenDied: 5,
//       totalFilledCrates: 20,
//       totalHenSold: 15,
//     );
//   }
//
//   Widget buildSectionTitle(String title) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           title,
//           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//         ),
//         SizedBox(height: 8),
//       ],
//     );
//   }
//
//   Widget buildGraphContainer() {
//     return Container(
//       height: 200,
//       padding: EdgeInsets.all(8.0),
//       decoration: BoxDecoration(
//         color: Colors.grey.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(8.0),
//         border: Border.all(color: Colors.grey.withOpacity(0.3)),
//       ),
//       child: LineChart(
//         LineChartData(
//           titlesData: FlTitlesData(show: false),
//           borderData: FlBorderData(show: false),
//           gridData: FlGridData(show: false),
//           lineBarsData: [
//             LineChartBarData(
//               spots: [
//                 // Sample data for the graph (replace with actual data)
//                 FlSpot(0, 10),
//                 FlSpot(1, 20),
//                 FlSpot(2, 15),
//                 FlSpot(3, 25),
//                 // Add more data spots as needed
//               ],
//               isCurved: true,
//               colors: [Colors.green],
//               barWidth: 2,
//               isStrokeCapRound: true,
//               belowBarData: BarAreaData(show: false),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget buildEggProductionGraph() {
//     return Container(
//       height: 200,
//       child: LineChart(
//         LineChartData(
//           titlesData: FlTitlesData(show: false),
//           borderData: FlBorderData(show: false),
//           gridData: FlGridData(show: false),
//           lineBarsData: [
//             LineChartBarData(
//               spots: [
//                 // Sample data for the last 30 days (replace with actual data)
//                 FlSpot(0, 5),
//                 FlSpot(1, 8),
//                 FlSpot(2, 6),
//                 FlSpot(3, 9),
//                 // Add more data spots for the last 30 days
//               ],
//               isCurved: true,
//               colors: [Colors.blue],
//               barWidth: 3,
//               isStrokeCapRound: true,
//               belowBarData: BarAreaData(show: false),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class TodayUpdateWidget extends StatelessWidget {
//   final int totalHenDied;
//   final int totalFilledCrates;
//   final int totalHenSold;
//
//   TodayUpdateWidget({
//     required this.totalHenDied,
//     required this.totalFilledCrates,
//     required this.totalHenSold,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(16.0),
//       decoration: BoxDecoration(
//         color: Colors.grey.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(8.0),
//         border: Border.all(color: Colors.grey.withOpacity(0.3)),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Today\'s Update',
//             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 12),
//           buildUpdateRow('Total Number of Hen Died', totalHenDied.toString()),
//           buildUpdateRow('Total Number of Filled Crates', totalFilledCrates.toString()),
//           buildUpdateRow('Total Number of Hen Sold', totalHenSold.toString()),
//         ],
//       ),
//     );
//   }
//
//   Widget buildUpdateRow(String title, String value) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             title,
//             style: TextStyle(fontSize: 16),
//           ),
//           Text(
//             value,
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildTodayUpdateWidget(), // Display the TodayUpdateWidget at the top
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  buildSectionTitle('Number of Egg Crates Today:'),
                  buildGraphContainer(), // Implement this method to display the graph
                  SizedBox(height: 16),
                  buildSectionTitle('Egg Production for the Last 30 Days:'),
                  buildEggProductionGraph(), // Implement this method to display the egg production graph
                  SizedBox(height: 16),
                  buildSectionTitle('Number of Chick Deaths:'),
                  buildGraphContainer(), // Implement this method to display the graph for chick deaths
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTodayUpdateWidget() {
    // Implement the TodayUpdateWidget here
    return TodayUpdateWidget(
      totalHenDied: 5,
      totalFilledCrates: 20,
      totalHenSold: 15,
    );
  }

  Widget buildSectionTitle(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
      ],
    );
  }

  Widget buildGraphContainer() {
    return Container(
      height: 200,
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey.withOpacity(0.3)),
      ),
      child: LineChart(
        LineChartData(
          titlesData: FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          gridData: FlGridData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: [
                // Sample data for the graph (replace with actual data)
                FlSpot(0, 10),
                FlSpot(1, 20),
                FlSpot(2, 15),
                FlSpot(3, 25),
                // Add more data spots as needed
              ],
              isCurved: true,
              colors: [Colors.green],
              barWidth: 2,
              isStrokeCapRound: true,
              belowBarData: BarAreaData(show: false),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildEggProductionGraph() {
    return Container(
      height: 200,
      child: LineChart(
        LineChartData(
          titlesData: FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          gridData: FlGridData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: [
                // Sample data for the last 30 days (replace with actual data)
                FlSpot(0, 5),
                FlSpot(1, 8),
                FlSpot(2, 6),
                FlSpot(3, 9),
                // Add more data spots for the last 30 days
              ],
              isCurved: true,
              colors: [Colors.blue],
              barWidth: 3,
              isStrokeCapRound: true,
              belowBarData: BarAreaData(show: false),
            ),
          ],
        ),
      ),
    );
  }
}

class TodayUpdateWidget extends StatelessWidget {
  final int totalHenDied;
  final int totalFilledCrates;
  final int totalHenSold;

  TodayUpdateWidget({
    required this.totalHenDied,
    required this.totalFilledCrates,
    required this.totalHenSold,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Today\'s Update',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          buildUpdateRow('Total Number of Hen Died', totalHenDied.toString()),
          buildUpdateRow('Total Number of Filled Crates', totalFilledCrates.toString()),
          buildUpdateRow('Total Number of Hen Sold', totalHenSold.toString()),
        ],
      ),
    );
  }

  Widget buildUpdateRow(String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
