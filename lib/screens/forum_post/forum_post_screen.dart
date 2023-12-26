import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:optimizing_stock_investment_portfolio/helper/context.dart';
import 'package:optimizing_stock_investment_portfolio/helper/spaces.dart';
import 'package:optimizing_stock_investment_portfolio/repository/forum_posts/models/forum_post/forum_post_response.dart';
import 'package:optimizing_stock_investment_portfolio/widgets/loading.dart';

import 'forum_post_bloc.dart';
import 'forum_post_state.dart';
import 'widgets/comments/comments_popup.dart';
import 'widgets/create_post_popup.dart';

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
      child: BlocListener<ForumPostBloc, ForumPostState>(
        listenWhen: (previous, current) =>
            previous.isCreatePost != current.isCreatePost &&
            current.isCreatePost,
        listener: (context, state) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text(
                    'Post created successfully, please wait for approval')),
          );
        },
        child: BlocBuilder<ForumPostBloc, ForumPostState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Forum'),
              ),
              floatingActionButton: state.dataList == null
                  ? null
                  : FloatingActionButton(
                      onPressed: () async {
                        final result = await CreatePostPopup.show(
                          context,
                        );
                        if (result != null) {
                          bloc.onCreatePost(
                            title: result.entries.first.key,
                            content: result.entries.first.value,
                          );
                        }
                      },
                      backgroundColor: context.appColor.colorBlue,
                      child: const Icon(
                        Icons.add,
                      ),
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
                          separatorBuilder: (context, index) => Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 12.h,
                            ),
                            child: const Divider(),
                          ),
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
              // data.postDate != null
              //     ? data.postDate!.format(pattern: yyyy_mm_dd_HH_mm)
              //     : '',
              data.activationDateAgo ?? '',
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
            InkWell(
              onTap: () {
                bloc.onReactLike(
                  id: data.postId ?? 0,
                  react: data.react,
                  index: index,
                );
              },
              child: Icon(
                data.react == 1
                    ? CupertinoIcons.hand_thumbsup_fill
                    : CupertinoIcons.hand_thumbsup,
                size: 20,
              ),
            ),
            spaceW4,
            Text(
              data.likeCount != null ? data.likeCount!.toString() : '0',
              style: context.textTheme.bodyMedium,
            ),
            spaceW16,
            InkWell(
              onTap: () {
                bloc.onReactDisLike(
                  id: data.postId ?? 0,
                  react: data.react,
                  index: index,
                );
              },
              child: Icon(
                data.react == 2
                    ? CupertinoIcons.hand_thumbsdown_fill
                    : CupertinoIcons.hand_thumbsdown,
                size: 20,
              ),
            ),
            spaceW4,
            Text(
              data.dislikeCount != null ? data.dislikeCount!.toString() : '0',
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
}
