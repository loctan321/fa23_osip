import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:optimizing_stock_investment_portfolio/helper/context.dart';
import 'package:optimizing_stock_investment_portfolio/helper/date_time.dart';
import 'package:optimizing_stock_investment_portfolio/helper/spaces.dart';

Widget _wrapper(BuildContext context, {required Widget child}) => Container(
      decoration:  BoxDecoration(
        color: context.appColor.colorWhite,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      width: double.infinity,
      child: child,
    );

class TitleBottomSheetAutoHeightWrapper extends StatelessWidget {
  const TitleBottomSheetAutoHeightWrapper({
    super.key,
    required this.child,
    this.title,
    this.subTitle,
    this.subTitleWidget,
    this.onCloseTapped,
    this.minChildSize = 0.4,
    this.initialChildSize = 0.8,
    this.maxChildSize = 0.95,
    this.isHiddenTitleBar = false,
    this.closeBtn,
    this.minimum = const EdgeInsets.only(bottom: 16),
    this.titlePadding,
  });

  final VoidCallback? onCloseTapped;
  final String? title;
  final String? subTitle;
  final Widget? subTitleWidget;
  final Widget child;
  final double minChildSize;
  final double initialChildSize;
  final double maxChildSize;
  final bool isHiddenTitleBar;
  final Widget? closeBtn;
  final EdgeInsets? minimum;
  final double? titlePadding;
  @override
  Widget build(BuildContext context) {
    return _wrapper(
      context,
      child: SafeArea(
        minimum: minimum ?? const EdgeInsets.only(bottom: 16),
        child: Flex(
          mainAxisSize: MainAxisSize.min,
          direction: Axis.vertical,
          children: [
            Visibility(
              visible: !isHiddenTitleBar,
              child: RPadding(
                padding: EdgeInsets.symmetric(
                  horizontal: titlePadding ?? 24,
                  vertical: 16,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title ?? '',
                            style: context.textTheme.titleMedium,
                          ),
                          spaceH4,
                          subTitle != null
                              ? Text(
                                  subTitle ?? '',
                                  style: context.textTheme.labelMedium,
                                )
                              : const SizedBox(),
                          if (subTitleWidget != null) subTitleWidget!
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (onCloseTapped == null) {
                          Navigator.pop(context);
                        } else {
                          onCloseTapped!();
                        }
                      },
                      child: Container(
                        child: closeBtn ??
                            Container(
                              alignment: Alignment.centerRight,
                              width: 40,
                              height: 40,
                              child: const Icon(Icons.close),
                            ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Flexible(child: child),
          ],
        ),
      ),
    );
  }
}

Future<T?> showAppModalBottomSheetV3<T>({
  required BuildContext context,
  required Widget child,
  bool isScrollControlled = true,
  bool isDismissible = true,
  bool enableDrag = true,
  BoxConstraints? boxConstraints,
}) {
  return showModalBottomSheet<T?>(
    isDismissible: isDismissible,
    enableDrag: enableDrag,
    constraints: boxConstraints ??
        BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height -
              MediaQuery.of(context).viewPadding.top,
        ),
    backgroundColor: Colors.transparent,
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: child,
      );
    },
  );
}

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
