import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:optimizing_stock_investment_portfolio/helper/context.dart';
import 'package:optimizing_stock_investment_portfolio/helper/date_time.dart';

Future<void> showDialogDatePicker({
  required BuildContext context,
  DateTime? min,
  DateTime? max,
  DateTime? selected,
  String? title,
  required void Function(DateTime datetime) callback,
}) async {
  context.hideKeyboard();
  final minDate = min?.toDay;
  final now = DateTime.now();
  var date = selected != null
      ? DateTime(selected.year, selected.month, selected.day)
      : (min != null
          ? (minDate ?? DateTime(now.year, now.month, now.day))
          : DateTime(now.year, now.month, now.day));
  final maxDate = max != null ? DateTime(max.year, max.month, max.day) : null;
  await showCupertinoModalPopup<void>(
    context: context,
    builder: (c) {
      return ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          width: MediaQuery.of(context).size.width,
          height: 320,
          child: CupertinoApp(
            supportedLocales: const [Locale('en', 'US')],
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            home: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(c);
                        },
                        child: Text(
                          'Close',
                          style: TextStyle(
                            color: context.appColor.colorRed,
                          ),
                        ),
                      ),
                      Text(
                        'Choose time',
                        style: context.textTheme.bodyMedium,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(c).pop();
                          callback(date);
                        },
                        child: Text(
                          'Done',
                          style: TextStyle(
                            color: context.appColor.colorBlue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: CupertinoTheme(
                    data: const CupertinoThemeData(
                      textTheme: CupertinoTextThemeData(
                        dateTimePickerTextStyle:
                            TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                    child: CupertinoDatePicker(
                      initialDateTime: date,
                      minimumDate: minDate,
                      maximumDate: maxDate,
                      mode: CupertinoDatePickerMode.date,
                      use24hFormat: true,
                      // This is called when the user changes the date.
                      onDateTimeChanged: (DateTime newDate) {
                        date = newDate;
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
