import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:optimizing_stock_investment_portfolio/helper/context.dart';
import 'package:optimizing_stock_investment_portfolio/helper/spaces.dart';
import 'package:optimizing_stock_investment_portfolio/widgets/loading.dart';

import 'detail_stock_bloc.dart';
import 'detail_stock_state.dart';
import 'models/detail_stock_params.dart';

class DetailStockScreen extends StatefulWidget {
  const DetailStockScreen({
    super.key,
    required this.params,
  });

  final DetailStockParams params;

  @override
  State<DetailStockScreen> createState() => _DetailStockScreenState();
}

class _DetailStockScreenState extends State<DetailStockScreen> {
  late DetailStockBloc bloc;

  int numSuggest = 1;

  @override
  void initState() {
    super.initState();
    bloc = DetailStockBloc()
      ..getData(ticker: widget.params.ticker, date: widget.params.date);
  }

  List<Color> gradientColors = [
    Colors.cyan,
    Colors.blue,
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: BlocBuilder<DetailStockBloc, DetailStockState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(widget.params.ticker),
            ),
            body: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          if (numSuggest > 1) {
                            setState(() {
                              numSuggest -= 1;
                            });
                          }
                        },
                        child: Container(
                          height: 28,
                          width: 28,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: context.appColor.colorBlue,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Icon(
                            Icons.remove,
                            size: 20,
                            color: context.appColor.colorWhite,
                          ),
                        ),
                      ),
                      spaceW4,
                      Text(
                        '$numSuggest Month',
                        style: context.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      spaceW4,
                      InkWell(
                        onTap: () {
                          if (numSuggest < 12) {
                            setState(() {
                              numSuggest += 1;
                            });
                          }
                        },
                        child: Container(
                          height: 28,
                          width: 28,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: context.appColor.colorBlue,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Icon(
                            Icons.add,
                            size: 20,
                            color: context.appColor.colorWhite,
                          ),
                        ),
                      ),
                      spaceW12,
                      InkWell(
                        onTap: () {
                          bloc.getData(
                            ticker: widget.params.ticker,
                            date: widget.params.date,
                            option: numSuggest,
                          );
                        },
                        child: Container(
                          height: 28,
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: context.appColor.colorGreen,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(
                            'Change option',
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: context.appColor.colorWhite,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                state.isLoading
                    ? Column(
                        children: [
                          SizedBox(
                            height: 1.sh / 3,
                          ),
                          const Loading(),
                        ],
                      )
                    : state.dataList.isEmpty
                        ? Column(
                            children: [
                              SizedBox(
                                height: 1.sh / 3,
                              ),
                              const Empty(),
                            ],
                          )
                        : Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  AspectRatio(
                                    aspectRatio: 1,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        right: 16.w,
                                        left: 16.w,
                                        top: 20.h,
                                        bottom: 72.h,
                                      ),
                                      child: LineChart(
                                        mainData(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    final date =
        DateTime.parse('${bloc.state.dataList[value.toInt()].dtyyyymmdd}');
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(date.day.toString(), style: style),
          Text(date.month.toString(), style: style),
          Text(date.year.toString().substring(2), style: style),
        ],
      ),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case -10:
        text = '-10';
        break;
      case -5:
        text = '-5';
        break;
      case -0:
        text = '0';
        break;
      case 5:
        text = '5';
        break;
      case 10:
        text = '10';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: const FlGridData(show: false),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 80,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(show: false),
      minX: 0,
      maxX: 20,
      minY: -10,
      maxY: 10,
      lineBarsData: [
        LineChartBarData(
          spots: bloc.state.dataList
              .mapIndexed(
                (index, element) => FlSpot(
                  double.parse(index.toString()),
                  element.dailyProfit ?? 0,
                ),
              )
              .toList(),
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
