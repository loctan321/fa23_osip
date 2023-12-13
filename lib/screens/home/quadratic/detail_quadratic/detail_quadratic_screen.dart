import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:optimizing_stock_investment_portfolio/helper/context.dart';
import 'package:optimizing_stock_investment_portfolio/repository/stocks/models/quadratic_stock_select/quadratic_stock_select_response.dart';

import 'models/detail_quadratic_params.dart';

class DetailQuadraticScreen extends StatefulWidget {
  const DetailQuadraticScreen({
    super.key,
    required this.params,
  });

  final DetailQuadraticParams params;

  @override
  State<DetailQuadraticScreen> createState() => _DetailQuadraticScreenState();
}

class _DetailQuadraticScreenState extends State<DetailQuadraticScreen> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Detail'),
        ),
        body: Column(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 0,
                  centerSpaceRadius: 0,
                  sections: getSections(
                    context,
                    list: widget.params.dataList ?? [],
                  ),
                ),
              ),
            ),
            GridView.count(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
              ),
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              shrinkWrap: true,
              childAspectRatio: 4,
              crossAxisSpacing: 12, // khoang cach ngang 2 gia tri
              mainAxisSpacing: 0, // khoang cach doc 2 gia tri
              children: (widget.params.dataList ?? [])
                  .mapIndexed((index, e) => _indicator(context,
                      color: colorList[index],
                      text:
                          '${e.nameStock} - ${((e.xValue ?? 0) * 100).toStringAsFixed(2)}%'))
                  .toList(),
            )
          ],
        ));
  }

  List<PieChartSectionData> getSections(
    BuildContext context, {
    required List<QuadraticStockSelectResponse> list,
  }) {
    return list
        .asMap()
        .map<int, PieChartSectionData>((index, data) {
          final isTouched = index == touchedIndex;
          final fontSize = isTouched ? 20.0 : 16.0;
          final radius = isTouched ? 110.0 : 100.0;
          const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

          final value = PieChartSectionData(
            color: colorList[index],
            value: double.parse(((data.xValue ?? 0) * 100).toStringAsFixed(2)),
            title: isTouched
                ? '${((data.xValue ?? 0) * 100).toStringAsFixed(2)}%'
                : '',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: context.appColor.colorWhite,
              shadows: shadows,
            ),
            badgeWidget: Text(
              '${((data.xValue ?? 0) * 100).toStringAsFixed(2)}%',
              style: context.textTheme.bodyMedium,
            ),
            badgePositionPercentageOffset: 1.24,
          );
          return MapEntry(index, value);
        })
        .values
        .toList();
  }

  Widget _indicator(
    BuildContext context, {
    required Color color,
    required String text,
  }) {
    return Row(
      children: <Widget>[
        Container(
          width: 16.r,
          height: 16.r,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: color,
          ),
        ),
        SizedBox(
          width: 4.w,
        ),
        Expanded(
          child: Text(
            text,
            style: context.textTheme.bodySmall,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }

  List<Color> colorList = const [
    Color(0xFF67b7dc),
    Color(0xFF6794dc),
    Color(0xFF6771dc),
    Color(0xFF8067dc),
    Color(0xFFa267dc),
    Color(0xFFc667dc),
    Color(0xFFdc67ce),
    Color(0xFFdc67ab),
    Color(0xFFdc6788),
    Color(0xFFdc6967),
    Color(0xFFdc8c67),
    Color(0xFFdcaf68),
    Color(0xFFdcd267),
    Color(0xFFc3dc67),
    Color(0xFFa1dc67),
    Color(0xFF7ddc67),
    Color(0xFF67dc75),
    Color(0xFF67dc98),
    Color(0xFF67dcbb),
    Color(0xFF67dadb),
    Color(0xFF80f3f5),
    Color(0xFF81d0f5),
    //
    Color(0xFF67b7dc),
    Color(0xFF6794dc),
    Color(0xFF6771dc),
    Color(0xFF8067dc),
    Color(0xFFa267dc),
    Color(0xFFc667dc),
    Color(0xFFdc67ce),
    Color(0xFFdc67ab),
    Color(0xFFdc6788),
    Color(0xFFdc6967),
    Color(0xFFdc8c67),
    Color(0xFFdcaf68),
    Color(0xFFdcd267),
    Color(0xFFc3dc67),
    Color(0xFFa1dc67),
    Color(0xFF7ddc67),
    Color(0xFF67dc75),
    Color(0xFF67dc98),
    Color(0xFF67dcbb),
    Color(0xFF67dadb),
    Color(0xFF80f3f5),
    Color(0xFF81d0f5),
  ];
}
