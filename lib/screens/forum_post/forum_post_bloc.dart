import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizing_stock_investment_portfolio/repository/forum_posts/forum_posts_repository.dart';
import 'package:optimizing_stock_investment_portfolio/repository/forum_posts/models/forum_post/forum_post_response.dart';

import 'forum_post_state.dart';

class ForumPostBloc extends Cubit<ForumPostState> {
  final ForumPostsRepository _forumPostsRepository = ForumPostsRepository();
  ForumPostBloc() : super(const ForumPostState());

  getData() async {
    emit(state.copyWith(isLoading: true));

    var dataList = await _forumPostsRepository.viewForumPosts();
    final myReacts = await _forumPostsRepository.getMyReacts();
    final myReactsId = myReacts.map((e) => e.postId ?? 0).toList();

    // dataList = dataList
    //     .map((e) => myReactsId.contains(e.postId) ? e.copyWith(react: 0) : e)
    //     .toList();
    // dataList = dataList
    //     .map((e) =>
    //         myReactsId.contains(e.postId ?? 0) ? e.copyWith(react: 0) : e)
    //     .toList();

    // final filterEmployeeList = employeeList
    //     .where((itemA) =>
    //         !state.personnelsChange.any((itemB) => itemB.id == itemA.id))
    //     .toList();

    emit(state.copyWith(
      isLoading: false,
      dataList: dataList,
    ));
  }
}
