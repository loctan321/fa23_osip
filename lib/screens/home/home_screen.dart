import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:optimizing_stock_investment_portfolio/helper/commons.dart';
import 'package:optimizing_stock_investment_portfolio/helper/context.dart';
import 'package:optimizing_stock_investment_portfolio/helper/spaces.dart';
import 'package:optimizing_stock_investment_portfolio/repository/stocks/models/view_post_stock/view_post_stock_response.dart';
import 'package:optimizing_stock_investment_portfolio/resources/routes.dart';
import 'package:optimizing_stock_investment_portfolio/widgets/filter/filter_stock_header.dart';
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

  final PagingController<int, ViewPostStockResponse> _pagingController =
      PagingController(firstPageKey: 1, invisibleItemsThreshold: 3);

  @override
  void initState() {
    super.initState();
    bloc = HomeBloc()..getData();
    _pagingController.addPageRequestListener((pageKey) {
      if (pageKey != 1) {
        bloc.onFetch(page: pageKey);
      }
    });
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: MultiBlocListener(
        listeners: [
          BlocListener<HomeBloc, HomeState>(
            listenWhen: (previous, current) =>
                previous.stockDataList != current.stockDataList,
            listener: (context, state) {
              if (state.currentPage == 1) {
                _pagingController.refresh();
              }
              if (state.canLoadMore) {
                _pagingController.appendPage(
                  state.stockDataList ?? [],
                  state.currentPage + 1,
                );
              } else {
                _pagingController.appendLastPage(state.stockDataList ?? []);
              }
            },
          ),
          BlocListener<HomeBloc, HomeState>(
            listenWhen: (previous, current) =>
                previous.nameSearch != current.nameSearch ||
                previous.dateSearch != current.dateSearch ||
                previous.sortColumn != current.sortColumn ||
                previous.sortDirection != current.sortDirection,
            listener: (context, state) {
              bloc.onFetch(page: 1);
              _pagingController.refresh();
            },
          ),
        ],
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: AppSearchBar(
                  hintText: 'Search...',
                  onChanged: (keyword) {
                    bloc.onChangeNameSearch(keyword);
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
                                  onUnCheckAllList: () =>
                                      bloc.onUnCheckAllList(),
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
                                      padding: EdgeInsets.all(
                                          length < 10 ? 6.r : 4.r),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: context.appColor.colorRed,
                                      ),
                                      child: Text(
                                        length < 10 ? '//' : '9+',
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
              body: state.stockDataList == null
                  ? const Loading()
                  : Column(
                      children: [
                        FilterStockHeader(
                          date: state.dateSearch,
                          sortColumn: state.sortColumn,
                          sortDirection: state.sortDirection,
                          onChangeDate: (value) {
                            bloc.onChangeDateSearch(value);
                          },
                          onChangeSortColumn: (value) {
                            bloc.onChangeSortColumn(value);
                          },
                          onChangeSortDirection: () {
                            bloc.onChangeSortDirection();
                          },
                        ),
                        Expanded(
                          child: PagedListView.separated(
                            keyboardDismissBehavior:
                                ScrollViewKeyboardDismissBehavior.onDrag,
                            pagingController: _pagingController,
                            shrinkWrap: true,
                            padding: EdgeInsets.only(
                              right: 16.w,
                              left: 16.w,
                              top: 16.w,
                              bottom: 72.h,
                            ),
                            physics: const ClampingScrollPhysics(),
                            builderDelegate: PagedChildBuilderDelegate<
                                ViewPostStockResponse>(
                              noItemsFoundIndicatorBuilder: _empty,
                              itemBuilder: (context, item, index) {
                                return _item(context, item);
                              },
                            ),
                            separatorBuilder: (context, index) =>
                                const Divider(),
                          ),
                        ),
                      ],
                    ),
            );
          },
        ),
      ),
    );
  }

  Widget _empty(BuildContext context) {
    return const Empty();
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
