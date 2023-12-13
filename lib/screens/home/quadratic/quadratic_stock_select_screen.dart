import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:optimizing_stock_investment_portfolio/helper/commons.dart';
import 'package:optimizing_stock_investment_portfolio/helper/context.dart';
import 'package:optimizing_stock_investment_portfolio/helper/spaces.dart';
import 'package:optimizing_stock_investment_portfolio/resources/routes.dart';
import 'package:optimizing_stock_investment_portfolio/widgets/button/bottom_bar_button.dart';
import 'package:optimizing_stock_investment_portfolio/widgets/button/solid_button.dart';
import 'package:optimizing_stock_investment_portfolio/widgets/loading.dart';

import 'detail_quadratic/models/detail_quadratic_params.dart';
import 'models/quadratic_stock_select_params.dart';
import 'quadratic_stock_select_bloc.dart';
import 'quadratic_stock_select_state.dart';

class QuadraticStockSelectScreen extends StatefulWidget {
  const QuadraticStockSelectScreen({
    super.key,
    required this.params,
  });

  final QuadraticStockSelectParams params;

  @override
  State<QuadraticStockSelectScreen> createState() =>
      _QuadraticStockSelectScreenState();
}

class _QuadraticStockSelectScreenState
    extends State<QuadraticStockSelectScreen> {
  late QuadraticStockSelectBloc bloc;

  int numSuggest = 0;

  @override
  void initState() {
    super.initState();
    bloc = QuadraticStockSelectBloc()..getData(widget.params.listStockSelect);
  }

  List<Color> gradientColors = [
    Colors.cyan,
    Colors.blue,
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: BlocListener<QuadraticStockSelectBloc, QuadraticStockSelectState>(
        listenWhen: (previous, current) =>
            previous.dataList != current.dataList && current.dataList != null,
        listener: (context, state) {
          routeService.pushNamed(Routes.detailQuadratic,
              arguments: DetailQuadraticParams(
                dataList: state.dataList,
              ));
        },
        child: BlocBuilder<QuadraticStockSelectBloc, QuadraticStockSelectState>(
          builder: (context, state) {
            return Scaffold(
                appBar: AppBar(
                  title: const Text('Stock Investment Portofolio'),
                ),
                bottomNavigationBar: state.isLoading
                    ? null
                    : BottomBarButton(
                        button1: SizedBox(
                          child: AppSolidButton.medium(
                            'Clear All',
                            color: Colors.red,
                            onPressed: state.listStockSelect.isEmpty
                                ? null
                                : () {
                                    widget.params.onUnCheckAllList.call();
                                    bloc.onUnCheckAllList();
                                    setState(() {
                                      numSuggest = 0;
                                    });
                                  },
                          ),
                        ),
                        button2: SizedBox(
                          child: AppSolidButton.medium(
                            color: context.appColor.colorGreen,
                            'Start',
                            onPressed: state.listStockSelect.isEmpty
                                ? null
                                : () {
                                    bloc.onSubmit();
                                  },
                          ),
                        ),
                      ),
                body: state.isLoading
                    ? const Loading()
                    : Column(
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
                                    if (numSuggest > 0) {
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
                                  numSuggest.toString(),
                                  style:
                                      context.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                spaceW4,
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      numSuggest += 1;
                                    });
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
                                    if (numSuggest > 0) {
                                      bloc.getStockSuggestList(numSuggest);
                                      setState(() {
                                        numSuggest = 0;
                                      });
                                    }
                                  },
                                  child: Container(
                                    height: 28,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12.w, vertical: 4.h),
                                    decoration: BoxDecoration(
                                      color: numSuggest > 0
                                          ? context.appColor.colorGreen
                                          : context.appColor.colorGrey,
                                      borderRadius: BorderRadius.circular(4.r),
                                    ),
                                    child: Text(
                                      'Suggest',
                                      style: context.textTheme.bodyMedium
                                          ?.copyWith(
                                        color: context.appColor.colorWhite,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          state.listStockSelect.isEmpty
                              ? const Empty()
                              : ListView.separated(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.only(
                                    right: 16.w,
                                    left: 16.w,
                                    top: 16.w,
                                    bottom: 72.h,
                                  ),
                                  physics: const ClampingScrollPhysics(),
                                  itemBuilder: (context, index) => _item(
                                    context,
                                    state.listStockSelect[index],
                                  ),
                                  separatorBuilder: (context, index) =>
                                      const Divider(),
                                  itemCount: state.listStockSelect.length,
                                ),
                        ],
                      ));
          },
        ),
      ),
    );
  }

  Widget _item(BuildContext context, String data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          data,
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        InkWell(
          onTap: () {
            widget.params.onUnCheck.call(data);
            bloc.onUnCheck(data);
          },
          child: Row(
            children: [
              spaceW12,
              Container(
                height: 28,
                width: 28,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: context.appColor.colorRed,
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Icon(
                  Icons.close,
                  size: 20,
                  color: context.appColor.colorWhite,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
