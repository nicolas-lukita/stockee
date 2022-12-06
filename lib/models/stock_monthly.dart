// To parse this JSON data, do
//
//     final stockMonthly = stockMonthlyFromJson(jsonString);

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

StockMonthly stockMonthlyFromJson(String str) =>
    StockMonthly.fromJson(json.decode(str));

String stockMonthlyToJson(StockMonthly data) => json.encode(data.toJson());

class StockMonthly extends Equatable {
  StockMonthly({
    required this.metaData,
    required this.monthlyAdjustedTimeSeries,
  });

  MetaData metaData;
  Map<String, MonthlyAdjustedTimeSery> monthlyAdjustedTimeSeries;

  factory StockMonthly.fromJson(Map<String, dynamic> json) => StockMonthly(
        metaData: MetaData.fromJson(json["Meta Data"]),
        monthlyAdjustedTimeSeries:
            Map.from(json["Monthly Adjusted Time Series"]).map((k, v) =>
                MapEntry<String, MonthlyAdjustedTimeSery>(
                    k, MonthlyAdjustedTimeSery.fromJson(v))),
      );

  Map<String, dynamic> toJson() => {
        "Meta Data": metaData.toJson(),
        "Monthly Adjusted Time Series": Map.from(monthlyAdjustedTimeSeries)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
      };

  @override
  // TODO: implement props
  List<Object?> get props => [metaData, monthlyAdjustedTimeSeries];
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

class MonthlyAdjustedTimeSery extends Equatable {
  MonthlyAdjustedTimeSery({
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

  factory MonthlyAdjustedTimeSery.fromJson(Map<String, dynamic> json) =>
      MonthlyAdjustedTimeSery(
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
