import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stockee/details_page/stock_data_convert.dart';
import 'package:candlesticks/candlesticks.dart';

class CandlestickChart extends StatefulWidget {
  const CandlestickChart({Key? key}) : super(key: key);

  @override
  State<CandlestickChart> createState() => _CandlestickChartState();
}

class _CandlestickChartState extends State<CandlestickChart> {
  List<Candle> candles = [];
  late StockData? stockData;

  Future readJson() async {
    final String response =
        await rootBundle.loadString('lib/dummy_data/intraday_sample.json');
    stockData = stockDataFromJson(response);
    stockData?.timeSeries5Min.forEach((key, value) {
      candles.add(Candle(
          date: DateTime.parse(key),
          high: double.parse(value.the2High),
          low: double.parse(value.the3Low),
          open: double.parse(value.the1Open),
          close: double.parse(value.the4Close),
          volume: double.parse(value.the5Volume)));
    });
    setState(() {});
  }

  @override
  void initState() {
    readJson();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).orientation == Orientation.portrait
          ? MediaQuery.of(context).size.height * 0.45
          : MediaQuery.of(context).size.height * 0.6,
      child: Candlesticks(candles: candles),
      color: Colors.white,
    );
  }
}
