import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizing_stock_investment_portfolio/api/services/forum_posts/models/send_comment_request.dart';
import 'package:optimizing_stock_investment_portfolio/repository/forum_posts/forum_posts_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'comments_popup_state.dart';

class CommentsPopupBloc extends Cubit<CommentsPopupState> {
  final ForumPostsRepository _forumPostsRepository = ForumPostsRepository();
  CommentsPopupBloc() : super(const CommentsPopupState());

  getData(int id) async {
    emit(state.copyWith(isLoading: true));
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt('user_id');
      final userName = prefs.getString('user_name');

      emit(state.copyWith(
        id: id,
        userId: userId,
        userName: userName,
      ));
      await onFetch();
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  onFetch() async {
    try {
      final dataList = await _forumPostsRepository.getComments(id: state.id);

      emit(state.copyWith(
        dataList: dataList.reversed.toList(),
      ));
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
    }
  }

  onSendComment({
    required String comment,
  }) async {
    try {
      await _forumPostsRepository.sendComment(
          request: SendCommentRequest(
        postId: state.id,
        userId: state.userId,
        content: comment,
      ));

      await onFetch();
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
    }
  }
}
