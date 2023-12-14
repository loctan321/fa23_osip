<<<<<<< HEAD
const baseUrl =
    "https://cfa1-118-69-233-166.ngrok-free.app/";
=======
const baseUrl = "https://cfa1-118-69-233-166.ngrok-free.app/";
>>>>>>> locfuho

class UsersApi {
  static const login = "/Users/Login";
  static const register = "/Users/Register";
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
