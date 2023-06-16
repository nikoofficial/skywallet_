import 'package:flutter/material.dart';
import 'package:skywallet/Modules/Models/Keuangan.dart';
import 'package:skywallet/Modules/Services/keuangan.dart';
import 'package:skywallet/Modules/Variables/Global.dart';
import 'package:skywallet/Modules/Variables/Theme.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TotalSpending extends StatefulWidget {
  TotalSpending({Key key, this.type}) : super(key: key);
  String type;

  @override
  State<TotalSpending> createState() => _TotalSpendingState();
}

class _TotalSpendingState extends State<TotalSpending> {
  List<LineData> chartData = [];
  KeuanganService apiService;

  @override
  void initState() {
    super.initState();
    apiService = KeuanganService();
  }

  @override
  Widget build(BuildContext context) {
    int year = DateTime.now().year;

    return SafeArea(
      maintainBottomViewPadding: false,
      child: FutureBuilder(
        future: apiService.getTotalSpendMonth(year,widget.type),
        builder: (BuildContext context,
            AsyncSnapshot<List<QueriesKeuanganLineChartModel>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                  "Something wrong with message: ${snapshot.error.toString()}"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            List<QueriesKeuanganLineChartModel> contents = snapshot.data;

            contents.forEach((content) {
              String label = content.ctx;
              int total = content.total;
              LineData lineData = LineData(label, total.toDouble());
              chartData.add(lineData);
            });

            return _buildListView(chartData, year.toString());
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  @override
  Widget _buildListView(List<LineData> contents, String year) {
    // double fullHeight = MediaQuery.of(context).size.height;
    // double fullWidth = MediaQuery.of(context).size.width;

    return Container(
        margin: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            title: ChartTitle(text: 'Total ${widget.type} $year'),
            legend: Legend(isVisible: false),
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <ChartSeries<LineData, String>>[
              LineSeries<LineData, String>(
                  dataSource: chartData,
                  xValueMapper: (LineData dt, _) => dt.month,
                  yValueMapper: (LineData dt, _) => dt.total,
                  name: 'Total',
                  dataLabelSettings: const DataLabelSettings(isVisible: true))
            ]));
  }
}