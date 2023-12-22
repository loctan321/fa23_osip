import 'package:flutter/foundation.dart';
import 'package:optimizing_stock_investment_portfolio/api/services/forum_posts/forum_posts_service.dart';
import 'package:optimizing_stock_investment_portfolio/api/services/forum_posts/models/react_request.dart';
import 'package:optimizing_stock_investment_portfolio/api/services/forum_posts/models/send_comment_request.dart';

import 'models/comment_response/comment_response.dart';
import 'models/forum_post/forum_post_response.dart';
import 'models/my_react_response/my_react_response.dart';

class ForumPostsRepository {
  final _service = ForumPostsService();

  Future<List<ForumPostResponse>> viewForumPosts() async {
    try {
      final response = await _service.viewForumPosts();
      if (response.statusCode == 200) {
        final result = ForumPostResponse.fromJsonArray(response.data);
        return result;
      } else {
        return [];
      }
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
      return [];
    }
  }

  Future<List<CommentResponse>> getComments({required int id}) async {
    try {
      final response = await _service.getComments(id.toString());
      if (response.statusCode == 200) {
        final result = CommentResponse.fromJsonArray(response.data);
        return result;
      } else {
        return [];
      }
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
      return [];
    }
  }

  Future<void> sendComment({
    required SendCommentRequest request,
  }) async {
    try {
      await _service.sendComment(request);
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
    }
  }

  Future<List<MyReactResponse>> getMyReacts() async {
    try {
      final response = await _service.getMyReacts();
      if (response.statusCode == 200) {
        final result = MyReactResponse.fromJsonArray(response.data);
        return result;
      } else {
        return [];
      }
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
      return [];
    }
  }

  Future<void> sendReact({
    required ReactRequest request,
    required bool isLike,
  }) async {
    try {
      await _service.sendReact(request, isLike);
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
    }
  }

  Future<void> unReact({required int id, required int postId}) async {
    try {
      await _service.unReact(id: id.toString(), postId: postId.toString());
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
    }
  }
}
