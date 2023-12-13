const baseUrl =
    "https://6697-2402-800-6370-54b0-91bd-ac0f-f56c-b270.ngrok-free.app/";

class UsersApi {
  static const login = "/Users/Login";
  static const register ="/Users/Register";
}

class StocksApi {
 static const viewPostStocks = "/api/Stocks/ViewPost?page=1&pageSize=10&sortColumn=StockName&sortDirection=true";
  static const getStockChart =
      "/api/Stocks/GetStockChart?ticker={ticker}&date={date}";
  static const getQuadraticStockSelect =
      "/api/Stocks/QuadraticForSelectStock?mathWithDailyOrMonth={mathWithDailyOrMonth}";
  static const getStockSuggestList =
      "/api/Stocks/GetListStockName?quantity={quantity}";
}
