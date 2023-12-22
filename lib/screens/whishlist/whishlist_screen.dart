import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:optimizing_stock_investment_portfolio/helper/context.dart';
import 'package:optimizing_stock_investment_portfolio/helper/spaces.dart';
import 'package:optimizing_stock_investment_portfolio/repository/stocks/models/view_post_stock/view_post_stock_response.dart';
import 'package:optimizing_stock_investment_portfolio/widgets/loading.dart';

import 'whishlist_bloc.dart';
import 'whishlist_state.dart';

class WhishlistScreen extends StatefulWidget {
  const WhishlistScreen({super.key});

  @override
  State<WhishlistScreen> createState() => _WhishlistScreenState();
}

class _WhishlistScreenState extends State<WhishlistScreen> {
  late WhishlistBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = WhishlistBloc()..getData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: BlocBuilder<WhishlistBloc, WhishlistState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Whish List'),
            ),
            body: state.dataList == null
                ? const Loading()
                : (state.dataList ?? []).isEmpty
                    ? _empty(context)
                    : ListView.separated(
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        shrinkWrap: true,
                        padding: EdgeInsets.only(
                          right: 16.w,
                          left: 16.w,
                          top: 16.w,
                          bottom: 72.h,
                        ),
                        physics: const ClampingScrollPhysics(),
                        itemBuilder: (context, index) => _item(
                            context, (state.dataList ?? [])[index], index),
                        itemCount: (state.dataList ?? []).length,
                        separatorBuilder: (context, index) => const Divider(),
                      ),
          );
        },
      ),
    );
  }

  Widget _empty(BuildContext context) {
    return const Empty();
  }

  Widget _item(
    BuildContext context,
    ViewPostStockResponse data,
    int index,
  ) {
    return Column(
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
            InkWell(
              onTap: () {
                bloc.onDelete(index);
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
                      Icons.delete_outline_outlined,
                      size: 20,
                      color: context.appColor.colorWhite,
                    ),
                  )
                ],
              ),
            )
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
      ],
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
