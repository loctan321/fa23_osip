const baseUrl =
    "https://5321-2402-800-6370-5623-212e-b6d2-a907-d934.ngrok-free.app";

class UsersApi {
  static const login = "/Users/Login";
}

class StocksApi {
  static const viewPostStocks = "/api/Stocks/ViewPost?page=1&pageSize=10";
  static const getStockChart =
      "/api/Stocks/GetStockChart?ticker={ticker}&date={date}";
  static const getQuadraticStockSelect =
      "/api/Stocks/QuadraticForSelectStock?mathWithDailyOrMonth={mathWithDailyOrMonth}";
  static const getStockSuggestList =
      "/api/Stocks/GetListStockName?quantity={quantity}";
}
