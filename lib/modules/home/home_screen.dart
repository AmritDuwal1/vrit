
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

import 'package:poultry/helper/alert_manager.dart';

import 'package:poultry/model/poultry_stats_summary.dart';
import 'package:poultry/modules/home/add_data_form.dart';
import 'package:poultry/modules/home/home_view_model.dart';
import 'package:poultry/path_collection.dart';
import 'package:provider/provider.dart';
import 'package:poultry/helper/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>  {

  @override
  HomeViewModel get viewModel => HomeViewModel();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<HomeViewModel>(context, listen: false).fetchData();
    });
    // Future.delayed(const Duration(seconds: 5), () {
    //   Provider.of<AlertManager>(context, listen: false).showAlert('This is an alert!');
    // });
  }

  Future<void> _refreshData() async {
    // Fetch new data
    Provider.of<HomeViewModel>(context, listen: false).fetchData();
    // Simulate a delay for 2 seconds (adjust duration as needed)
    await Future.delayed(Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    // HomeViewModel viewModel = Provider.of<HomeViewModel>(context);
    var todayStats = Provider.of<HomeViewModel>(context).todayStats;
    var viewModel = Provider.of<HomeViewModel>(context);
    var localizedStrings = AppLocalizations.of(context)!;
    LocalizationExtension.context = context;

    return Scaffold(
      appBar: AppBar(
        // title: Text('Home'),
        // title: Text(localizedStrings.translate('Home') ?? 'Default Text'),
        title: Text('home'.translate),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Consumer<HomeViewModel>(
                builder: (context, viewModel, child) {
                  if (viewModel.result != null) {
                    Future.delayed(Duration.zero, () {
                      // AlertManager.showAlert(context, viewModel.result!.message);
                      showResultDialog(context, viewModel.result!, () {
                        viewModel.result = null;
                      });
                    });
                  }
                  return Container();
                },
              ),
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
                    buildSectionTitle('num_egg_crates_7_days'.translate),
                    LineChartWidget(
                      dataSpots: extractHensSoldDataSpots(viewModel.last7DaysStats),
                      colors: [Colors.green],
                      titlesData: buildTitlesData(viewModel.last7DaysStats),
                    ),
                    SizedBox(height: 16),
                    buildSectionTitle('hen_sold_7_days'.translate),
                    LineChartWidget(
                      dataSpots: extractHenDeathsDataSpots(viewModel.last7DaysStats),
                      colors: [Colors.red],
                      titlesData: buildTitlesData(viewModel.last7DaysStats),
                    ),
                    buildSectionTitle('hen_deaths_7_days'.translate),
                  ],
                ),
              ),
            ],
          ),
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
          'no_data_available'.translate,
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
            "today_update".translate,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          if (totalHenDied == 0 && totalFilledCrates == 0 && totalHenSold == 0)
            AddDataForm()
          else
            Column(
              children: [
                buildUpdateRow('total_hen_died'.translate, totalHenDied.toString()),
                buildUpdateRow('total_filled_crates'.translate, totalFilledCrates.toString()),
                buildUpdateRow('total_hen_sold'.translate, totalHenSold.toString()),
              ],
            ),
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
