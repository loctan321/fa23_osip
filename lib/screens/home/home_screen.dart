import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:optimizing_stock_investment_portfolio/helper/commons.dart';
import 'package:optimizing_stock_investment_portfolio/helper/context.dart';
import 'package:optimizing_stock_investment_portfolio/helper/spaces.dart';
import 'package:optimizing_stock_investment_portfolio/repository/stocks/models/view_post_stock/view_post_stock_response.dart';
import 'package:optimizing_stock_investment_portfolio/resources/routes.dart';
import 'package:optimizing_stock_investment_portfolio/widgets/loading.dart';
import 'package:optimizing_stock_investment_portfolio/widgets/search_bar.dart';

import 'detail/models/detail_stock_params.dart';
import 'home_bloc.dart';
import 'home_state.dart';
import 'quadratic/models/quadratic_stock_select_params.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = HomeBloc()..getData('');
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(

      create: (context) => bloc,
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: AppSearchBar(
                hintText: 'Search...',
                onChanged: (keyword) {
                  bloc.getData(keyword);
                },
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: 4.w),
                  child: Stack(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          routeService.pushNamed(Routes.quadraticStockSelect,
                              arguments: QuadraticStockSelectParams(
                                onSelectChanged: (p0) {},
                                onUnCheck: (ticker) =>
                                    bloc.onAddList(ticker, false),
                                onUnCheckAllList: () => bloc.onUnCheckAllList(),
                                listStockSelect: state.addList,
                              ));
                        },
                      ),
                      BlocSelector<HomeBloc, HomeState, int>(
                        selector: (state) {
                          return state.addList.length;
                        },
                        builder: (context, length) {
                          return Positioned(
                            right: 4.w,
                            child: length == 0
                                ? space0
                                : Container(
                                    padding:
                                        EdgeInsets.all(length < 10 ? 6.r : 4.r),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: context.appColor.colorRed,
                                    ),
                                    child: Text(
                                      length < 10 ? '$length' : '9+',
                                      style: context.textTheme.labelMedium
                                          ?.copyWith(
                                        color: context.appColor.colorWhite,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
            body:
              
             state.isLoading
                ? const Loading()
                : state.stockDataList.isEmpty
                    ? const Empty()
                    : ListView.separated(
                        padding: EdgeInsets.only(
                            right: 16.w, left: 16.w, top: 16.w, bottom: 72.h),
                        physics: const ClampingScrollPhysics(),
                        itemBuilder: (context, index) => _item(
                          context,
                          state.stockDataList[index],
                        ),
                        separatorBuilder: (context, index) => const Divider(),
                        itemCount: state.stockDataList.length,
                      ),
          );
        },
      ),
    );
  }

  Widget _item(BuildContext context, ViewPostStockResponse data) {
    return InkWell(
      onTap: () async {
        routeService.pushNamed(Routes.detailStock,
            arguments: DetailStockParams(
              ticker: data.ticker ?? '',
              date: data.dtyyyymmdd ?? '',
              onReload: () {
                //
              },
            ));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  data.ticker ?? '',
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              spaceW4,
              Text(
                data.dtyyyymmdd ?? '',
                style: context.textTheme.bodyMedium,
              ),
            ],
          ),
          spaceH2,
          _itemValue(
            context,
            title: 'Daily profit',
            value: data.dailyProfit.toString(),
          ),
          spaceH2,
          _itemValue(
            context,
            title: 'Standard deviation',
            value: data.standardDeviation.toString(),
          ),
          spaceH2,
          _itemValue(
            context,
            title: 'Close',
            value: data.close.toString(),
          ),
          spaceH2,
          _itemValue(
            context,
            title: 'Volume',
            value: data.volume.toString(),
          ),
          spaceH8,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _itemButton(
                context,
                title: 'Draw daily profit',
                backgroundColor: context.appColor.colorOrange,
                onTap: () {
                  //
                },
              ),
              spaceW12,
              _itemButton(
                context,
                title: 'Add favorite',
                backgroundColor: context.appColor.colorBlue,
                onTap: () {
                  //
                },
              ),
              InkWell(
                onTap: () {
                  bloc.onAddList(data.ticker, !data.isCheck);
                },
                child: Row(
                  children: [
                    spaceW12,
                    Container(
                      height: 28,
                      width: 28,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: data.isCheck
                            ? context.appColor.colorBlue
                            : context.appColor.colorGrey,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Icon(
                        Icons.search,
                        size: 20,
                        color: context.appColor.colorWhite,
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _itemValue(
    BuildContext context, {
    required String title,
    required String value,
  }) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        text: '$title: ',
        style: context.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w400,
        ),
        children: [
          TextSpan(
            text: value,
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }

  Widget _itemButton(
    BuildContext context, {
    required String title,
    required Function() onTap,
    required Color backgroundColor,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 28,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Text(
          title,
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.appColor.colorWhite,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
