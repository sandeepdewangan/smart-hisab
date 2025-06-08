import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class TxPieChart extends StatefulWidget {
  final Map<String, double> summary;
  // final double total;
  final double totalExpenses;
  final double totalIncome;
  const TxPieChart({
    super.key,
    required this.summary,
    // required this.total,
    required this.totalExpenses,
    required this.totalIncome,
  });

  @override
  State<TxPieChart> createState() => _TxPieChartState();
}

class _TxPieChartState extends State<TxPieChart> {
  // final dataMap = <String, double>{
  //   "Flutter": 5,
  //   "React": 3,
  //   "Xamarin": 2,
  //   "Ionic": 2,
  // };

  final colorList = <Color>[
    const Color(0xfffdcb6e),
    const Color(0xff0984e3),
    const Color(0xfffd79a8),
    Color(0xFFFF6B6B), // bright red
    Color(0xFFFF9F1C), // orange
    Color(0xFFFFD93D), // yellow
    Color(0xFF6BCB77), // mint green
    Color(0xFF4D96FF), // blue
    Color(0xFF9D4EDD), // purple
    Color(0xFFFDCB6E), // soft yellow
    Color(0xFFFF6363), // coral red
    Color(0xFF32E0C4), // turquoise
    Color(0xFF7D5FFF), // violet
    Color(0xFFFFAB76), // soft orange
    Color(0xFF3EC1D3), // cyan
    Color(0xFFFAF884), // light yellow
    Color(0xFFFF5D9E), // pink
    Color(0xFF2EC4B6), // teal
    Color(0xFF6A4C93), // deep purple
    Color(0xFFB5EAD7), // pale green
    Color(0xFFFFDAC1), // peach
    Color(0xFFF28D35), // tangerine
    Color(0xFF96F550), // bright lime
    Color(0xFF2D82B7), // bright sky blue
    Color(0xFFDA4167), // deep pink
    Color(0xFFF4ACB7), // rose pink
    Color(0xFFBAFFB4), // light green
    Color(0xFF71DFE7), // fresh blue
    Color(0xFFEFC7C2), // blush
    Color(0xFFFFE156), // bright lemon
    Color(0xFF41AEA9), // sea green
    Color(0xFF5FCDD9), // cyan blue
    Color(0xFFFB743E), // sunset orange
    Color(0xFFB388EB), // light purple
    Color(0xFF70C1B3), // minty blue
    Color(0xFFF67280), // watermelon pink
    Color(0xFF355C7D), // blue slate
    Color(0xFFF8B195), // soft salmon
    Color(0xFF45CB85), // spring green
    Color(0xFFE17055), // peach orange
    Color(0xFFFDC5F5), // light fuchsia
    Color(0xFF48E5C2), // neon mint
    Color(0xFF90F1EF), // frosty mint
    Color(0xFFEAC435), // banana yellow
    Color(0xFF345995), // navy blue
    Color(0xFF6FDE6E), // grass green
    Color(0xFFFFB5E8), // light pink
    Color(0xFFA9DEF9), // baby blue
    Color(0xFFFCFFA6), // butter yellow
    Color(0xFF98DDCA), // pastel green
    Color(0xFFFFD6E0), // pastel pink
    Color(0xFFFFB07C), // melon orange
  ];

  int key = 0;

  @override
  Widget build(BuildContext context) {
    final totalExpenses = widget.totalExpenses;
    final totalIncome = widget.totalIncome;
    final Map<String, double> data = widget.summary;

    data["Income"] = totalIncome;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: PieChart(
        key: ValueKey(key),
        animationDuration: const Duration(milliseconds: 800),
        chartLegendSpacing: 32,
        chartRadius: MediaQuery.of(context).size.width / 2,
        initialAngleInDegree: 180,
        ringStrokeWidth: 30,
        dataMap: data,
        chartType: ChartType.ring,
        // baseChartColor: Colors.grey[50]!.withValues(alpha: 0.15),
        // centerWidget: Text(
        //   totalIncome != 0 ? totalIncome.toStringAsFixed(2) : 'add income',
        //   style: TextStyle(fontSize: 24),
        // ),
        centerWidget: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 8,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 5,
              children: [
                Icon(Icons.wallet, size: 28, color: Colors.lightBlueAccent),
                Text(
                  totalIncome.toStringAsFixed(2),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 5,
              children: [
                Icon(Icons.reply, size: 28, color: Colors.redAccent),
                Text(
                  totalExpenses.toStringAsFixed(2),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ],
        ),
        legendOptions: LegendOptions(
          showLegends: true,
          legendPosition: LegendPosition.bottom,
          showLegendsInRow: true,
        ),
        colorList: colorList,
        chartValuesOptions: const ChartValuesOptions(showChartValues: false),
        totalValue: totalIncome + totalExpenses,
      ),
    );
  }
}
