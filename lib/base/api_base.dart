import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:optimizing_stock_investment_portfolio/constains/constain.dart';


class ApiBase {
  Future <dynamic>postLogin (String url , dynamic body ) async {
    final response = await http.post(Uri.parse(apiUrl + url ), body: body);
    var reponseJson =_returnReponse(response);
    // print(reponseJson);
    return reponseJson;

  }

  _returnReponse(http.Response response){
    switch (response.statusCode){
      case  200:
        var reponseJson = jsonDecode(response.body.toString());
        return reponseJson;

      case 400:
      var reponseError = jsonDecode(response.body.toString());
        return reponseError;

      default:
        return Exception('default Error ${response.statusCode.toString()}');
    }
  }

}


