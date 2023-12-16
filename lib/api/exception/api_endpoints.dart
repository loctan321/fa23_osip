const baseUrl =
    "https://41b6-2402-800-6370-54b0-1d5d-a03b-baec-503d.ngrok-free.app/";

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
