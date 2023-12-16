const baseUrl =
<<<<<<< HEAD
    "https://ac6a-2402-800-6370-54b0-8df7-2bc2-a54f-18b8.ngrok-free.app/";
=======
    "https://f1b3-2402-800-6370-54b0-b05f-1612-9855-ffd2.ngrok-free.app/";
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
