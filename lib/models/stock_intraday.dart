// To parse this JSON data, do
//
//     final stockIntraday = stockIntradayFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

StockIntraday stockIntradayFromJson(String str) =>
    StockIntraday.fromJson(json.decode(str));

String stockIntradayToJson(StockIntraday data) => json.encode(data.toJson());

class StockIntraday {
  StockIntraday({
    required this.metaData,
    required this.timeSeries15Min,
  });

  MetaData metaData;
  Map<String, TimeSeries15Min> timeSeries15Min;

  factory StockIntraday.fromJson(Map<String, dynamic> json) => StockIntraday(
        metaData: MetaData.fromJson(json["Meta Data"]),
        timeSeries15Min: Map.from(json["Time Series (5min)"]).map((k, v) =>
            MapEntry<String, TimeSeries15Min>(k, TimeSeries15Min.fromJson(v))),
      );

  Map<String, dynamic> toJson() => {
        "Meta Data": metaData.toJson(),
        "Time Series (5min)": Map.from(timeSeries15Min)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
      };
}

class MetaData {
  MetaData({
    required this.information,
    required this.symbol,
    required this.lastRefreshed,
    required this.interval,
    required this.outputSize,
    required this.timeZone,
  });

  String information;
  String symbol;
  DateTime lastRefreshed;
  String interval;
  String outputSize;
  String timeZone;

  factory MetaData.fromJson(Map<String, dynamic> json) => MetaData(
        information: json["1. Information"],
        symbol: json["2. Symbol"],
        lastRefreshed: DateTime.parse(json["3. Last Refreshed"]),
        interval: json["4. Interval"],
        outputSize: json["5. Output Size"],
        timeZone: json["6. Time Zone"],
      );

  Map<String, dynamic> toJson() => {
        "1. Information": information,
        "2. Symbol": symbol,
        "3. Last Refreshed": lastRefreshed.toIso8601String(),
        "4. Interval": interval,
        "5. Output Size": outputSize,
        "6. Time Zone": timeZone,
      };
}

class TimeSeries15Min {
  TimeSeries15Min({
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.volume,
  });

  String open;
  String high;
  String low;
  String close;
  String volume;

  factory TimeSeries15Min.fromJson(Map<String, dynamic> json) =>
      TimeSeries15Min(
        open: json["1. open"],
        high: json["2. high"],
        low: json["3. low"],
        close: json["4. close"],
        volume: json["5. volume"],
      );

  Map<String, dynamic> toJson() => {
        "1. open": open,
        "2. high": high,
        "3. low": low,
        "4. close": close,
        "5. volume": volume,
      };
}
