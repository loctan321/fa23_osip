import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/stock.dart';

List<StockData> stockDataList = [];

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  StockData? stockData1;
  @override
  void initState() {
    super.initState();
    _fetchStockData();
  }

  Future<void> _fetchStockData() async {
    final response =
        await http.get(Uri.parse('https://10.0.2.2:7053/api/Stocks/'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      stockDataList.clear(); // Clear existing data
      for (final data in jsonData) {
        stockDataList.add(StockData.fromJson(data));
      }
      setState(() {}); // Refresh UI
    } else {
      throw Exception('Failed to fetch stock data');
    }
  }

  //https://10.0.2.2:7053/api/Stocks/

  @override
  Widget build(BuildContext context) {
    //   if (stockData1 == null) {
    //   return const CircularProgressIndicator();
    // }
    return Scaffold(
      appBar: AppBar(
        title: Text('Stock Overview'),
      ),
      body: stockDataList.isEmpty
          ? const CircularProgressIndicator()
          : ListView.builder(
              itemCount: stockDataList.length,
              itemBuilder: (context, index) {
                final stockData = stockDataList[index];
                return ListTile(
                  title: Text(stockData.ticker!),
                  subtitle: Text('Open: ${stockData.open?.toStringAsFixed(2)}'),
                  trailing: Text(
                      'Daily Profit: ${stockData.dailyProfit?.toStringAsFixed(2)}'),
                  // onTap: () {
                  //   // Navigate to a detailed stock data page
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => StockDetailsScreen(stockData: stockData),
                  //     ),
                  //   );
                  // },
                );
              },
            ),
    );
  }
}
