// To parse this JSON data, do
//
//     final stockDaily = stockDailyFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

StockDaily stockDailyFromJson(String str) =>
    StockDaily.fromJson(json.decode(str));

String stockDailyToJson(StockDaily data) => json.encode(data.toJson());

class StockDaily {
  StockDaily({
    required this.metaData,
    required this.timeSeriesDaily,
  });

  MetaData metaData;
  Map<String, TimeSeriesDaily> timeSeriesDaily;

  factory StockDaily.fromJson(Map<String, dynamic> json) => StockDaily(
        metaData: MetaData.fromJson(json["Meta Data"]),
        timeSeriesDaily: Map.from(json["Time Series (Daily)"]).map((k, v) =>
            MapEntry<String, TimeSeriesDaily>(k, TimeSeriesDaily.fromJson(v))),
      );

  Map<String, dynamic> toJson() => {
        "Meta Data": metaData.toJson(),
        "Time Series (Daily)": Map.from(timeSeriesDaily)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
      };
}

class MetaData {
  MetaData({
    required this.information,
    required this.symbol,
    required this.lastRefreshed,
    required this.outputSize,
    required this.timeZone,
  });

  String information;
  String symbol;
  DateTime lastRefreshed;
  String outputSize;
  String timeZone;

  factory MetaData.fromJson(Map<String, dynamic> json) => MetaData(
        information: json["1. Information"],
        symbol: json["2. Symbol"],
        lastRefreshed: DateTime.parse(json["3. Last Refreshed"]),
        outputSize: json["4. Output Size"],
        timeZone: json["5. Time Zone"],
      );

  Map<String, dynamic> toJson() => {
        "1. Information": information,
        "2. Symbol": symbol,
        "3. Last Refreshed":
            "${lastRefreshed.year.toString().padLeft(4, '0')}-${lastRefreshed.month.toString().padLeft(2, '0')}-${lastRefreshed.day.toString().padLeft(2, '0')}",
        "4. Output Size": outputSize,
        "5. Time Zone": timeZone,
      };
}

class TimeSeriesDaily {
  TimeSeriesDaily({
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.adjustedClose,
    required this.volume,
    required this.dividendAmount,
    required this.splitCoefficient,
  });

  String open;
  String high;
  String low;
  String close;
  String adjustedClose;
  String volume;
  String dividendAmount;
  String splitCoefficient;

  factory TimeSeriesDaily.fromJson(Map<String, dynamic> json) =>
      TimeSeriesDaily(
        open: json["1. open"],
        high: json["2. high"],
        low: json["3. low"],
        close: json["4. close"],
        adjustedClose: json["5. adjusted close"],
        volume: json["6. volume"],
        dividendAmount: json["7. dividend amount"],
        splitCoefficient: json["8. split coefficient"],
      );

  Map<String, dynamic> toJson() => {
        "1. open": open,
        "2. high": high,
        "3. low": low,
        "4. close": close,
        "5. adjusted close": adjustedClose,
        "6. volume": volume,
        "7. dividend amount": dividendAmount,
        "8. split coefficient": splitCoefficient,
      };
}
