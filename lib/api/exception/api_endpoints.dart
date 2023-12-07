const baseUrl =
    "https://9aaa-2402-800-6370-5623-99f8-d764-e91f-23db.ngrok-free.app/";

class UsersApi {
  static const login = "/Users/Login";
}

class StocksApi {
  static const viewPostStocks = "/api/Stocks/ViewPost";
  static const getStockChart =
      "/api/Stocks/GetStockChart?ticker={ticker}&date={date}";
  static const getQuadraticStockSelect =
      "/api/Stocks/QuadraticForSelectStock?mathWithDailyOrMonth={mathWithDailyOrMonth}";
}
