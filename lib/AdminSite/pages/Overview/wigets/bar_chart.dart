import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

import '../../../constants/style.dart';
import '../overview.dart';

class SimpleBarChart extends StatelessWidget {
  final List<charts.Series<LastDaysReport, String>> seriesList;
  final bool? animate;

  SimpleBarChart(this.seriesList, {this.animate});

  factory SimpleBarChart.withSampleData(List<LastDaysReport> lastdata) {
    return SimpleBarChart(
      _createSampleData(lastdata),
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      seriesList,
      animate: animate,
    );
  }

  static List<charts.Series<LastDaysReport, String>> _createSampleData(List<LastDaysReport> lastdata) {
    return [
      charts.Series<LastDaysReport, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(active),
        domainFn: (LastDaysReport sales, _) => sales.name.toString(),
        measureFn: (LastDaysReport sales, _) => sales.count,
        data: lastdata,
      ),
    ];
  }
}
