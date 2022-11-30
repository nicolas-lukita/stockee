class StockInfo {
  StockInfo({
    required this.symbol,
    required this.name,
    required this.open,
    required this.high,
    required this.low,
    required this.price,
    required this.volume,
    required this.previousClose,
    required this.change,
    required this.changePercent,
    required this.latestTradingDay,
  });
  String symbol;
  String name;
  String open;
  String high;
  String low;
  String price;
  String volume;
  String previousClose;
  String change;
  String changePercent;
  DateTime latestTradingDay;
}
