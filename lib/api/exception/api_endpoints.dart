const baseUrl =
    "https://e38d-2402-800-6371-5b6f-18f2-26a5-5226-38d6.ngrok-free.app/";

class UsersApi {
  static const login = "/Users/Login";
  static const register = "/Users/Register?otp={otp}";
  static const sendOTP = "/api/Email/SendOtp?toEmail={email}";
  static const checkOTP = "/api/Otp/CheckOtp?otp={otp}";
  static const getUser = "/Users/GetById";
  static const changePassword = "/Users/ChangePassword";
}

class StocksApi {
  static const viewPostStocks =
      "/api/Stocks/viewstock?page={page}&pageSize=10&sortColumn={sortColumn}&sortDirection={sortDirection}";
  static const getStockChart =
      "/api/Stocks/GetStockChart?ticker={ticker}&date={date}&option={option}";
  static const getQuadraticStockSelect =
      "/api/Stocks/QuadraticForSelectStock?mathWithDailyOrMonth={mathWithDailyOrMonth}";
  static const getStockSuggestList =
      "/api/Stocks/GetListStockName?quantity={quantity}";
}

class ForumPostsApi {
  static const forumPosts = "/api/ForumPosts";
  static const viewForumPosts = "/api/ForumPosts/GetForumPostsAccept";
  static const getComments = "/api/Comments/post/{id}";
  static const sendComment = "/api/Comments";
  static const getMyReacts = "/api/Reacts/getMyId";
  static const reactLike = "/api/Reacts/Like";
  static const reactDislike = "/api/Reacts/Dislike";
  static const unReact = "/api/Reacts/{id}?postId={postId}";
}
