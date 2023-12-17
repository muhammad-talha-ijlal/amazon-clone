import 'package:amazonclone/const/global_var.dart';
import 'package:amazonclone/model/sales.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class SalesData extends StatefulWidget {
  List<Sales> sales;
  SalesData({super.key, required this.sales});

  @override
  State<SalesData> createState() => _SalesDataState();
}

class _SalesDataState extends State<SalesData> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 400,
        padding: EdgeInsets.only(right: 20),
        child: BarChart(BarChartData(
            maxY: 10000,
            minY: 0,
            gridData: FlGridData(show: false),
            titlesData: FlTitlesData(
              show: true,
              topTitles: AxisTitles(
                  sideTitles: SideTitles(
                      showTitles: true, getTitlesWidget: getRightTitle)),
              rightTitles:
                  AxisTitles(sideTitles: SideTitles(showTitles: false)),
              bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                      showTitles: true, getTitlesWidget: getBottomTitle)),
            ),
            barGroups: [
              BarChartGroupData(x: 1, barRods: [
                BarChartRodData(
                    width: 60,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5)),
                    toY: double.parse(widget.sales[0].earning.toString()),
                    color: GlobalVariables.selectedNavBarColor)
              ]),
              BarChartGroupData(x: 2, barRods: [
                BarChartRodData(
                    width: 60,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5)),
                    toY: double.parse(widget.sales[1].earning.toString()),
                    color: GlobalVariables.selectedNavBarColor)
              ]),
              BarChartGroupData(x: 3, barRods: [
                BarChartRodData(
                    width: 60,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5)),
                    toY: double.parse(widget.sales[2].earning.toString()),
                    color: GlobalVariables.selectedNavBarColor)
              ]),
              BarChartGroupData(x: 4, barRods: [
                BarChartRodData(
                    width: 60,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5)),
                    toY: double.parse(widget.sales[3].earning.toString()),
                    color: GlobalVariables.selectedNavBarColor)
              ]),
              BarChartGroupData(x: 5, barRods: [
                BarChartRodData(
                    width: 60,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5)),
                    toY: double.parse(widget.sales[4].earning.toString()),
                    color: GlobalVariables.selectedNavBarColor)
              ]),
            ])));
  }
}

Widget getBottomTitle(double value, TitleMeta meta) {
  const style = TextStyle(
      color: Colors.black87, fontSize: 20, fontWeight: FontWeight.bold);

  Widget text;
  switch (value) {
    case 1:
      text = const Text(
        "Mobiles",
        style: style,
      );
      break;
    case 2:
      text = const Text(
        "",
        style: style,
      );
      break;
    case 3:
      text = const Text(
        "Books",
        style: style,
      );
      break;
    case 4:
      text = const Text(
        "",
        style: style,
      );
      break;
    case 5:
      text = const Text(
        "Fashion",
        style: style,
      );
      break;
    default:
      text = const Text(
        "Others",
        style: style,
      );
  }

  return text;
}

Widget getRightTitle(double value, TitleMeta meta) {
  const style = TextStyle(
      color: Colors.black87, fontSize: 20, fontWeight: FontWeight.bold);

  Widget text;
  switch (value) {
    case 1:
      text = const Text(
        "",
        style: style,
      );
      break;
    case 2:
      text = const Text(
        "Essentials",
        style: style,
      );
      break;
    case 3:
      text = const Text(
        "",
        style: style,
      );
      break;
    case 4:
      text = const Text(
        "Appliances",
        style: style,
      );
      break;
    case 5:
      text = const Text(
        "",
        style: style,
      );
      break;
    default:
      text = const Text(
        "Others",
        style: style,
      );
  }

  return text;
}
