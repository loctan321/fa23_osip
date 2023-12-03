
class StockData {
  String? ticker;
  String? dtyyyymmdd;
  double? open;
  double? high;
  double? low;
  double? close;
  int? volume;
  double? dailyProfit;
  double? standardDeviation;
  List<ListChart>? listChart;

  StockData(
      {this.ticker,
      this.dtyyyymmdd,
      this.open,
      this.high,
      this.low,
      this.close,
      this.volume,
      this.dailyProfit,
      this.standardDeviation,
      this.listChart});

  
  StockData.fromJson(Map<String, dynamic> json) {
    ticker = json['ticker'];
    dtyyyymmdd = json['dtyyyymmdd'];
    open = json['open'];
    high = json['high'];
    low = json['low'];
    close = json['close'];
    volume = json['volume'];
    dailyProfit = json['dailyProfit'];
    standardDeviation = json['standardDeviation'];
    if (json['listChart'] != null) {
      listChart = <ListChart>[];
      json['listChart'].forEach((v) {
        listChart!.add(new ListChart.fromJson(v));
      });
    }
  }

  get isEmpty => null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ticker'] = this.ticker;
    data['dtyyyymmdd'] = this.dtyyyymmdd;
    data['open'] = this.open;
    data['high'] = this.high;
    data['low'] = this.low;
    data['close'] = this.close;
    data['volume'] = this.volume;
    data['dailyProfit'] = this.dailyProfit;
    data['standardDeviation'] = this.standardDeviation;
    if (this.listChart != null) {
      data['listChart'] = this.listChart!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListChart {
  String? dtyyyymmdd;
  double? dailyProfit;

  ListChart({this.dtyyyymmdd, this.dailyProfit});

  ListChart.fromJson(Map<String, dynamic> json) {
    dtyyyymmdd = json['dtyyyymmdd'];
    dailyProfit = json['dailyProfit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dtyyyymmdd'] = this.dtyyyymmdd;
    data['dailyProfit'] = this.dailyProfit;
    return data;
  }
}