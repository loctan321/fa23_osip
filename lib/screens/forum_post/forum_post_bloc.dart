import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizing_stock_investment_portfolio/api/services/forum_posts/models/post_request.dart';
import 'package:optimizing_stock_investment_portfolio/api/services/forum_posts/models/react_request.dart';
import 'package:optimizing_stock_investment_portfolio/repository/forum_posts/forum_posts_repository.dart';
import 'package:optimizing_stock_investment_portfolio/repository/forum_posts/models/forum_post/forum_post_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'forum_post_state.dart';

class ForumPostBloc extends Cubit<ForumPostState> {
  final ForumPostsRepository _forumPostsRepository = ForumPostsRepository();
  ForumPostBloc() : super(const ForumPostState());

  getData() async {
    emit(state.copyWith(isLoading: true));

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('user_id');

    var dataList = await _forumPostsRepository.viewForumPosts();
    final myReacts = await _forumPostsRepository.getMyReacts();

    for (var itemA in dataList) {
      for (var itemB in myReacts) {
        if (itemA.postId == itemB.postId) {
          itemA.react = itemB.status == 'Like' ? 1 : 2;
        }
      }
    }

    emit(state.copyWith(
      isLoading: false,
      dataList: dataList,
      userId: userId,
    ));
  }

  onReactLike({
    required int id,
    required int react,
    required int index,
  }) async {
    await _forumPostsRepository.sendReact(
      isLike: true,
      request: ReactRequest(
        postId: id,
        reactDate: DateTime.now(),
      ),
    );

    var dataList = state.dataList;

    dataList?[index] = dataList[index].copyWith(
      react: (react == 0 || react == 2) ? 1 : 0,
      likeCount: (react == 0 || react == 2)
          ? (dataList[index].likeCount ?? 0) + 1
          : (dataList[index].likeCount ?? 0) - 1,
      dislikeCount: react == 2
          ? (dataList[index].dislikeCount ?? 0) - 1
          : (dataList[index].dislikeCount ?? 0),
    );

    emit(state.copyWith(
      dataList: dataList,
    ));
  }

  onReactDisLike({
    required int id,
    required int react,
    required int index,
  }) async {
    await _forumPostsRepository.sendReact(
      isLike: false,
      request: ReactRequest(
        postId: id,
        reactDate: DateTime.now(),
      ),
    );

    var dataList = state.dataList;

    dataList?[index] = dataList[index].copyWith(
        react: (react == 0 || react == 1) ? 2 : 0,
        likeCount: react == 1
            ? (dataList[index].likeCount ?? 0) - 1
            : (dataList[index].likeCount ?? 0),
        dislikeCount: (react == 0 || react == 1)
            ? (dataList[index].dislikeCount ?? 0) + 1
            : (dataList[index].dislikeCount ?? 0) - 1);

    emit(state.copyWith(
      dataList: dataList,
    ));
  }

  onCreatePost({
    required String title,
    required String content,
  }) async {
    emit(state.copyWith(isCreatePost: false));
    try {
      await _forumPostsRepository.createPost(
        request: PostRequest(
          postId: 0,
          userId: state.userId,
          title: title,
          content: content,
          postDate: DateTime.now(),
        ),
      );

      emit(state.copyWith(isCreatePost: true));
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
    } finally {
      emit(state.copyWith(isCreatePost: false));
    }
  }
}
