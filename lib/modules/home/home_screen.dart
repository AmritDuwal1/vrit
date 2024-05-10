//
//
// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:poultry/modules/home/home_view_model.dart';
// import 'package:poultry/path_collection.dart';
// import 'package:provider/provider.dart';
// import 'package:intl/intl.dart';
// class HomeScreen extends StatefulWidget {
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(Duration.zero, () {
//       Provider.of<HomeViewModel>(context, listen: false).fetchData();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     HomeViewModel viewModel = Provider.of<HomeViewModel>(context);
//     var todayStats = viewModel.todayStats ;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             TodayUpdateWidget(
//               totalHenDied: todayStats?.numDeadHens ?? 0,
//               totalFilledCrates: todayStats?.totalFilledEggCrates ?? 0,
//               totalHenSold: todayStats?.numHensSold ?? 0,
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   buildEggProductionGraph(), // Implement this method to display the egg production graph
//                   SizedBox(height: 16),
//                   buildSectionTitle('Number of Egg Crates 7 Days'),
//                   buildHensSoldGraph(),
//                   SizedBox(height: 16),
//                   buildSectionTitle('Hen Sold for the Last 7 Days'),
//                   buildHenDeathsGraph(),
//                   buildSectionTitle('Hen Deaths for the Last 7 Days'),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
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
//
//   Widget buildEggProductionGraph() {
//     var last7DaysStats = Provider.of<HomeViewModel>(context, listen: false).last7DaysStats;
//     List<FlSpot> dataSpots = [];
//
//     // Parse data and generate FlSpot objects
//     for (int i = 0; i < (last7DaysStats?.length ?? 0) ; i++) {
//       final stats = last7DaysStats![i];
//       final totalFilledEggCrates = stats.totalFilledEggCrates ?? 0;
//       final numDeadHens = stats.numDeadHens ?? 0;
//       final numHensSold = stats.numHensSold ?? 0;
//
//       // Calculate some metric for the graph (e.g., total eggs produced)
//       final eggsProduced = totalFilledEggCrates ; // Assuming 12 eggs per crate
//
//       // Add the data point to the graph
//       dataSpots.add(FlSpot(i.toDouble(), eggsProduced.toDouble()));
//     }
//
//     return Container(
//       height: 200,
//       child: LineChart(
//         LineChartData(
//           titlesData: FlTitlesData(
//             show: true,
//             bottomTitles: SideTitles(
//               showTitles: true,
//               getTitles: (value) {
//                 // Convert value to int to get index
//                 final index = value.toInt();
//                 // Get the date from the data spots
//                 final date = DateTime.parse(last7DaysStats?[index].createdAt ?? "");
//                 // Get the day of the week
//                 final dayOfWeek = DateFormat.E().format(date); // E is for abbreviated day of the week (e.g., Sun, Mon)
//                 return dayOfWeek;
//               },
//             ),
//             leftTitles: SideTitles(
//               showTitles: true,
//               getTitles: (value) {
//                 return value.toInt().toString();
//               },
//             ),
//           ),
//           borderData: FlBorderData(show: false),
//           gridData: FlGridData(show: false),
//           lineBarsData: [
//             LineChartBarData(
//               spots: dataSpots,
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
//
//   Widget buildHensSoldGraph() {
//     var last7DaysStats = Provider.of<HomeViewModel>(context, listen: false).last7DaysStats;
//     List<FlSpot> dataSpots = [];
//
//     // Parse data and generate FlSpot objects
//     for (int i = 0; i < (last7DaysStats?.length ?? 0); i++) {
//       final stats = last7DaysStats![i];
//       final numHensSold = stats.numHensSold ?? 0;
//
//       // Get the date and convert it to a day of the week (e.g., Sun, Mon)
//       final createdAt = DateTime.parse(stats.createdAt ?? "");
//       final dayOfWeek = DateFormat.E().format(createdAt); // E is for abbreviated day of the week (e.g., Sun, Mon)
//
//       // Add the data point to the graph
//       dataSpots.add(FlSpot(i.toDouble(), numHensSold.toDouble()));
//     }
//
//     return buildLineChart(dataSpots, [Colors.green]);
//   }
//
//   Widget buildHenDeathsGraph() {
//     var last7DaysStats = Provider.of<HomeViewModel>(context, listen: false).last7DaysStats;
//     List<FlSpot> dataSpots = [];
//
//     // Parse data and generate FlSpot objects
//     for (int i = 0; i < (last7DaysStats?.length ?? 0); i++) {
//       final stats = last7DaysStats![i];
//       final numDeadHens = stats.numDeadHens ?? 0;
//
//       // Add the data point to the graph
//       dataSpots.add(FlSpot(i.toDouble(), numDeadHens.toDouble()));
//     }
//
//     return buildLineChart(dataSpots, [Colors.red]);
//   }
//
//
// // Inside the _HomeScreenState class
//   Widget buildLineChart(List<FlSpot> dataSpots, List<Color> colors) {
//     var last7DaysStats = Provider.of<HomeViewModel>(context, listen: false).last7DaysStats;
//     return Container(
//       height: 200,
//       child: LineChart(
//         LineChartData(
//           titlesData: FlTitlesData(
//             bottomTitles: SideTitles(
//               showTitles: true,
//               getTitles: (value) {
//                 // Convert value to int to get index
//                 final index = value.toInt();
//                 // Get the date from the data spots
//                 final date = DateTime.parse(last7DaysStats?[index].createdAt ?? "");
//                 // Get the day of the week
//                 final dayOfWeek = DateFormat.E().format(date); // E is for abbreviated day of the week (e.g., Sun, Mon)
//                 return dayOfWeek;
//               },
//             ),
//             leftTitles: SideTitles(
//               showTitles: true,
//               getTitles: (value) {
//                 // Return the Y-axis labels based on the maximum value in the data
//                 final maxValue = dataSpots.map((spot) => spot.y).reduce((a, b) => a > b ? a : b);
//                 final step = (maxValue / 5).ceil(); // Divide into 5 segments
//                 return (value.toInt() * step).toString();
//               },
//             ),
//           ),
//           borderData: FlBorderData(show: false),
//           gridData: FlGridData(show: false),
//           lineBarsData: [
//             LineChartBarData(
//               spots: dataSpots,
//               isCurved: true,
//               colors: colors,
//               barWidth: 5,
//               isStrokeCapRound: true,
//               belowBarData: BarAreaData(show: false),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//
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
import 'package:intl/intl.dart';
import 'package:poultry/model/poultry_stats_summary.dart';
import 'package:poultry/modules/home/home_view_model.dart';
import 'package:poultry/path_collection.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<HomeViewModel>(context, listen: false).fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    HomeViewModel viewModel = Provider.of<HomeViewModel>(context);
    var todayStats = viewModel.todayStats;

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TodayUpdateWidget(
              totalHenDied: todayStats?.numDeadHens ?? 0,
              totalFilledCrates: todayStats?.totalFilledEggCrates ?? 0,
              totalHenSold: todayStats?.numHensSold ?? 0,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  LineChartWidget(
                    dataSpots: extractDataSpots(viewModel.last7DaysStats),
                    colors: [Colors.blue],
                    titlesData: buildTitlesData(viewModel.last7DaysStats),
                  ),
                  SizedBox(height: 16),
                  buildSectionTitle('Number of Egg Crates 7 Days'),
                  LineChartWidget(
                    dataSpots: extractHensSoldDataSpots(viewModel.last7DaysStats),
                    colors: [Colors.green],
                    titlesData: buildTitlesData(viewModel.last7DaysStats),
                  ),
                  SizedBox(height: 16),
                  buildSectionTitle('Hen Sold for the Last 7 Days'),
                  LineChartWidget(
                    dataSpots: extractHenDeathsDataSpots(viewModel.last7DaysStats),
                    colors: [Colors.red],
                    titlesData: buildTitlesData(viewModel.last7DaysStats),
                  ),
                  buildSectionTitle('Hen Deaths for the Last 7 Days'),
                ],
              ),
            ),
          ],
        ),
      ),
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

  List<FlSpot> extractDataSpots(List<PoultryStats>? statsList) {
    List<FlSpot> dataSpots = [];

    if (statsList != null) {
      for (int i = 0; i < statsList.length; i++) {
        final totalFilledEggCrates = statsList[i].totalFilledEggCrates ?? 0;
        dataSpots.add(FlSpot(i.toDouble(), totalFilledEggCrates.toDouble()));
      }
    }

    return dataSpots;
  }

  List<FlSpot> extractHensSoldDataSpots(List<PoultryStats>? statsList) {
    List<FlSpot> dataSpots = [];

    if (statsList != null) {
      for (int i = 0; i < statsList.length; i++) {
        final numHensSold = statsList[i].numHensSold ?? 0;
        dataSpots.add(FlSpot(i.toDouble(), numHensSold.toDouble()));
      }
    }

    return dataSpots;
  }

  List<FlSpot> extractHenDeathsDataSpots(List<PoultryStats>? statsList) {
    List<FlSpot> dataSpots = [];

    if (statsList != null) {
      for (int i = 0; i < statsList.length; i++) {
        final numDeadHens = statsList[i].numDeadHens ?? 0;
        dataSpots.add(FlSpot(i.toDouble(), numDeadHens.toDouble()));
      }
    }

    return dataSpots;
  }

  FlTitlesData buildTitlesData(List<PoultryStats>? statsList) {
    var last7DaysStats = statsList;
    return FlTitlesData(
      bottomTitles: SideTitles(
        showTitles: true,
        getTitles: (value) {
          // Convert value to int to get index
          final index = value.toInt();
          // Get the date from the data spots
          final date = DateTime.parse(last7DaysStats?[index].createdAt ?? "");
          // Get the day of the week
          final dayOfWeek = DateFormat.E().format(date); // E is for abbreviated day of the week (e.g., Sun, Mon)
          return dayOfWeek;
        },
      ),
      leftTitles: SideTitles(
        showTitles: true,
        getTitles: (value) {
          // Return the Y-axis labels based on the maximum value in the data
          final maxValue = statsList
              ?.map((stats) => [stats.totalFilledEggCrates, stats.numHensSold, stats.numDeadHens].reduce((a, b) => a! > b! ? a : b))
              .reduce((a, b) => a! > b! ? a : b)!;
          final step = ((maxValue ?? 0) / 5).ceil(); // Divide into 5 segments
          return (value.toInt() * step).toString();
        },
      ),
    );
  }
}

// class LineChartWidget extends StatelessWidget {
//   final List<FlSpot> dataSpots;
//   final List<Color> colors;
//   final FlTitlesData titlesData;
//
//   LineChartWidget({
//     required this.dataSpots,
//     required this.colors,
//     required this.titlesData,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 200,
//       child: LineChart(
//         LineChartData(
//           titlesData: titlesData,
//           borderData: FlBorderData(show: false),
//           gridData: FlGridData(show: false),
//           lineBarsData: [
//             LineChartBarData(
//               spots: dataSpots,
//               isCurved: true,
//               colors: colors,
//               barWidth: 5,
//               isStrokeCapRound: true,
//               belowBarData: BarAreaData(show: false),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



class LineChartWidget extends StatelessWidget {
  final List<FlSpot> dataSpots;
  final List<Color> colors;
  final FlTitlesData titlesData;

  LineChartWidget({
    required this.dataSpots,
    required this.colors,
    required this.titlesData,
  });

  @override
  Widget build(BuildContext context) {
    if (dataSpots.isEmpty) {
      return Container(
        height: 200,
        alignment: Alignment.center,
        child: Text(
          'No data available',
          style: TextStyle(fontSize: 16),
        ),
      );
    }

    return Container(
      height: 200,
      child: LineChart(
        LineChartData(
          titlesData: titlesData,
          borderData: FlBorderData(show: false),
          gridData: FlGridData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: dataSpots,
              isCurved: true,
              colors: colors,
              barWidth: 5,
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
