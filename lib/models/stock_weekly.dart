// To parse this JSON data, do
//
//     final stockWeekly = stockWeeklyFromJson(jsonString);

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

StockWeekly stockWeeklyFromJson(String str) =>
    StockWeekly.fromJson(json.decode(str));

String stockWeeklyToJson(StockWeekly data) => json.encode(data.toJson());

class StockWeekly extends Equatable {
  StockWeekly({
    required this.metaData,
    required this.weeklyAdjustedTimeSeries,
  });

  MetaData metaData;
  Map<String, WeeklyAdjustedTimeSery> weeklyAdjustedTimeSeries;

  factory StockWeekly.fromJson(Map<String, dynamic> json) => StockWeekly(
        metaData: MetaData.fromJson(json["Meta Data"]),
        weeklyAdjustedTimeSeries: Map.from(json["Weekly Adjusted Time Series"])
            .map((k, v) => MapEntry<String, WeeklyAdjustedTimeSery>(
                k, WeeklyAdjustedTimeSery.fromJson(v))),
      );

  Map<String, dynamic> toJson() => {
        "Meta Data": metaData.toJson(),
        "Weekly Adjusted Time Series": Map.from(weeklyAdjustedTimeSeries)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
      };

  @override
  // TODO: implement props
  List<Object?> get props => [metaData, weeklyAdjustedTimeSeries];
}

class MetaData extends Equatable {
  MetaData({
    required this.information,
    required this.symbol,
    required this.lastRefreshed,
    required this.timeZone,
  });

  String information;
  String symbol;
  DateTime lastRefreshed;
  String timeZone;

  factory MetaData.fromJson(Map<String, dynamic> json) => MetaData(
        information: json["1. Information"],
        symbol: json["2. Symbol"],
        lastRefreshed: DateTime.parse(json["3. Last Refreshed"]),
        timeZone: json["4. Time Zone"],
      );

  Map<String, dynamic> toJson() => {
        "1. Information": information,
        "2. Symbol": symbol,
        "3. Last Refreshed":
            "${lastRefreshed.year.toString().padLeft(4, '0')}-${lastRefreshed.month.toString().padLeft(2, '0')}-${lastRefreshed.day.toString().padLeft(2, '0')}",
        "4. Time Zone": timeZone,
      };

  @override
  // TODO: implement props
  List<Object?> get props => [information, symbol, lastRefreshed, timeZone];
}

class WeeklyAdjustedTimeSery extends Equatable {
  WeeklyAdjustedTimeSery({
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.adjustedClose,
    required this.volume,
    required this.dividendAmount,
  });

  String open;
  String high;
  String low;
  String close;
  String adjustedClose;
  String volume;
  String dividendAmount;

  factory WeeklyAdjustedTimeSery.fromJson(Map<String, dynamic> json) =>
      WeeklyAdjustedTimeSery(
        open: json["1. open"],
        high: json["2. high"],
        low: json["3. low"],
        close: json["4. close"],
        adjustedClose: json["5. adjusted close"],
        volume: json["6. volume"],
        dividendAmount: json["7. dividend amount"],
      );

  Map<String, dynamic> toJson() => {
        "1. open": open,
        "2. high": high,
        "3. low": low,
        "4. close": close,
        "5. adjusted close": adjustedClose,
        "6. volume": volume,
        "7. dividend amount": dividendAmount,
      };

  @override
  // TODO: implement props
  List<Object?> get props =>
      [open, high, low, close, adjustedClose, volume, dividendAmount];
}
