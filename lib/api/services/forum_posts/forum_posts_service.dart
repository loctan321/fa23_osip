import 'package:dio/dio.dart';
import 'package:optimizing_stock_investment_portfolio/api/exception/api_endpoints.dart';
import 'package:optimizing_stock_investment_portfolio/base/base_service.dart';

import 'models/post_request.dart';
import 'models/react_request.dart';
import 'models/send_comment_request.dart';

class ForumPostsService extends BaseService {
  Future<Response> viewForumPosts() async {
    final response = await get(ForumPostsApi.viewForumPosts);
    return response;
  }

  Future<Response> getComments(String id) async {
    final response =
        await get(ForumPostsApi.getComments.replaceAll(RegExp('{id}'), id));
    return response;
  }

  Future<Response> sendComment(SendCommentRequest request) async {
    final response =
        await post(ForumPostsApi.sendComment, data: request.toJson());
    return response;
  }

  Future<Response> getMyReacts() async {
    final response = await get(ForumPostsApi.getMyReacts);
    return response;
  }

  Future<Response> sendReact(ReactRequest request, bool isLike) async {
    final response = await post(
      isLike ? ForumPostsApi.reactLike : ForumPostsApi.reactDislike,
      data: request.toJson(),
    );
    return response;
  }

  Future<Response> unReact({
    required String id,
    required String postId,
  }) async {
    final response = await delete(
      ForumPostsApi.unReact
          .replaceAll(RegExp('{id}'), id)
          .replaceAll(RegExp('{postId}'), postId),
    );
    return response;
  }

  Future<Response> createPost({
    required PostRequest request,
  }) async {
    final response = await post(
      ForumPostsApi.forumPosts,
      data: request.toJson(),
    );
    return response;
  }
}
