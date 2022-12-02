// To parse this JSON data, do
//
//     final stockListing = stockListingFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<StockListing> stockListingFromJson(String str) => List<StockListing>.from(
    json.decode(str).map((x) => StockListing.fromJson(x)));

String stockListingToJson(List<StockListing> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StockListing {
  StockListing({
    required this.symbol,
    required this.name,
    required this.exchange,
    required this.assetType,
    required this.status,
  });

  String symbol;
  String name;
  String exchange;
  String assetType;
  String status;

  factory StockListing.fromJson(Map<String, dynamic> json) => StockListing(
        symbol: json["symbol"],
        name: json["name"],
        exchange: json["exchange"],
        assetType: json["assetType"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "symbol": symbol,
        "name": name,
        "exchange": exchange,
        "assetType": assetType,
        "status": status,
      };
}
