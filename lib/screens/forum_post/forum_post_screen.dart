import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:optimizing_stock_investment_portfolio/helper/context.dart';
import 'package:optimizing_stock_investment_portfolio/helper/date_time.dart';
import 'package:optimizing_stock_investment_portfolio/helper/spaces.dart';
import 'package:optimizing_stock_investment_portfolio/repository/forum_posts/models/forum_post/forum_post_response.dart';
import 'package:optimizing_stock_investment_portfolio/widgets/loading.dart';

import 'forum_post_bloc.dart';
import 'forum_post_state.dart';
import 'widgets/comments/comments_popup.dart';

class ForumPostScreen extends StatefulWidget {
  const ForumPostScreen({super.key});

  @override
  State<ForumPostScreen> createState() => _ForumPostScreenState();
}

class _ForumPostScreenState extends State<ForumPostScreen> {
  late ForumPostBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = ForumPostBloc()..getData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: BlocBuilder<ForumPostBloc, ForumPostState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Forum'),
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
    ForumPostResponse data,
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
                data.fullName ?? 'N/A',
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            spaceW4,
            Text(
              data.postDate != null
                  ? data.postDate!.format(pattern: yyyy_mm_dd_HH_mm)
                  : '',
              style: context.textTheme.bodyMedium,
            ),
          ],
        ),
        if (data.title != null) ...[
          spaceH8,
          Text(
            data.title ?? '',
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
        if (data.content != null) ...[
          spaceH8,
          Text(
            data.content ?? '',
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
        spaceH12,
        Row(
          children: [
            const Icon(
              CupertinoIcons.hand_thumbsup,
              size: 20,
            ),
            spaceW4,
            Text(
              data.likeCount != null ? data.likeCount!.toString() : '0',
              style: context.textTheme.bodyMedium,
            ),
            spaceW16,
            const Icon(
              CupertinoIcons.hand_thumbsdown,
              size: 20,
            ),
            spaceW4,
            Text(
              data.likeCount != null ? data.dislikeCount!.toString() : '0',
              style: context.textTheme.bodyMedium,
            ),
            spaceW16,
            InkWell(
              onTap: () {
                if (data.postId != null) {
                  CommentsPopup.show(
                    context,
                    id: data.postId!,
                    onReload: () {
                      //
                    },
                  );
                }
              },
              child: const Icon(
                Icons.comment_outlined,
                size: 20,
              ),
            ),
          ],
        )
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
