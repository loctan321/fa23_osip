import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:optimizing_stock_investment_portfolio/repository/forum_posts/models/forum_post/forum_post_response.dart';

part 'forum_post_state.g.dart';

@CopyWith()
class ForumPostState {
  final bool isLoading;
  final List<ForumPostResponse>? dataList;

  const ForumPostState({
    this.isLoading = false,
    this.dataList,
  });
}
