// To parse this JSON data, do
//
//     final globalQuote = globalQuoteFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GlobalQuote globalQuoteFromJson(String str) =>
    GlobalQuote.fromJson(json.decode(str));

String globalQuoteToJson(GlobalQuote data) => json.encode(data.toJson());

class GlobalQuote {
  GlobalQuote({
    required this.globalQuote,
  });

  GlobalQuoteClass globalQuote;

  factory GlobalQuote.fromJson(Map<String, dynamic> json) => GlobalQuote(
        globalQuote: GlobalQuoteClass.fromJson(json["Global Quote"]),
      );

  Map<String, dynamic> toJson() => {
        "Global Quote": globalQuote.toJson(),
      };
}

class GlobalQuoteClass {
  GlobalQuoteClass({
    required this.symbol,
    required this.open,
    required this.high,
    required this.low,
    required this.price,
    required this.volume,
    required this.latestTradingDay,
    required this.previousClose,
    required this.change,
    required this.changePercent,
  });

  String symbol;
  String open;
  String high;
  String low;
  String price;
  String volume;
  DateTime latestTradingDay;
  String previousClose;
  String change;
  String changePercent;

  factory GlobalQuoteClass.fromJson(Map<String, dynamic> json) =>
      GlobalQuoteClass(
        symbol: json["01. symbol"],
        open: json["02. open"],
        high: json["03. high"],
        low: json["04. low"],
        price: json["05. price"],
        volume: json["06. volume"],
        latestTradingDay: DateTime.parse(json["07. latest trading day"]),
        previousClose: json["08. previous close"],
        change: json["09. change"],
        changePercent: json["10. change percent"],
      );

  Map<String, dynamic> toJson() => {
        "01. symbol": Symbol,
        "02. open": open,
        "03. high": high,
        "04. low": low,
        "05. price": price,
        "06. volume": volume,
        "07. latest trading day":
            "${latestTradingDay.year.toString().padLeft(4, '0')}-${latestTradingDay.month.toString().padLeft(2, '0')}-${latestTradingDay.day.toString().padLeft(2, '0')}",
        "08. previous close": previousClose,
        "09. change": change,
        "10. change percent": changePercent,
      };
}
