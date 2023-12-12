const baseUrl =
    "https://a9ec-2402-800-6370-5623-693a-c6d9-2b1f-d8a5.ngrok-free.app/";

class UsersApi {
  static const login = "/Users/Login";
  static const register ="/Users/Register";
}

class StocksApi {
  static const viewPostStocks = "/api/Stocks/ViewPost";
  static const getStockChart =
      "/api/Stocks/GetStockChart?ticker={ticker}&date={date}";
  static const getQuadraticStockSelect =
      "/api/Stocks/QuadraticForSelectStock?mathWithDailyOrMonth={mathWithDailyOrMonth}";
}
