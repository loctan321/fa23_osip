// import 'package:flutter/material.dart';
// import 'package:optimizing_stock_investment_portfolio/model/stock.dart';
// import 'package:charts_flutter/flutter.dart';

// class StockDetailScreen extends StatefulWidget {

//    final StockData? stockData;

//   const StockDetailScreen({Key? key, required this.stockData}) : super(key: key);

//   @override
//   State<StockDetailScreen> createState() => _StockDetailState();
// }

// class _StockDetailState extends State<StockDetailScreen> {
  
//   @override
//   Widget build(BuildContext context) {
//    @override
//   Widget build(BuildContext context) {
//     if (stockData == null) {
//       return Center(child: CircularProgressIndicator());
//     }

//     final listChart = stockData!.listChart;
//     final dates = listChart.map((data) => data['dtyyyymmdd']).toList();
//     final dailyProfits = listChart.map((data) => data['dailyProfit']).toList();

//     return Scaffold(
//       appBar: AppBar(
//         title: stockData.tickerSymbol,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               SizedBox(height: 16.0),
//               Text('Historical Price'),
//               SizedBox(height: 16.0),
//               Expanded(
//                 child: LineChart(
//                   data: LineChartData(
//                     lineSets: [
//                       LineChartDataSet(
//                         color: Colors.blue,
//                         label: 'Daily Profit',
//                         lineWidth: 2.0,
//                         points: dates.asMap().entries.map((entry) {
//                           final index = entry.key;
//                           final date = entry.value;
//                           final dailyProfit = dailyProfits[index];
//                           return LineChartPoint(x: index.toDouble(), y: dailyProfit);
//                         }).toList(),
//                       ),
//                     ],
//                     axes: [
//                       Axis(
//                         title: Text('Date'),
//                         values: dates,
//                       ),
//                       Axis(
//                         title: Text('Daily Profit (%)'),
//                         positions: dailyProfits,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
  
// }