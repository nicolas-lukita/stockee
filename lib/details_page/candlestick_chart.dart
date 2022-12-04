import 'package:flutter/material.dart';
import 'package:candlesticks/candlesticks.dart';
import 'package:stockee/models/stock_daily.dart';
import 'package:stockee/models/stock_mothly.dart';
import 'package:stockee/models/stock_weekly.dart';
import 'package:stockee/services/alpha_vantage_api.dart';

import '../models/stock_intraday.dart';

const List<Widget> intervals = <Widget>[
  Text('15min'),
  Text('1d'),
  Text('7d'),
  Text('30d')
];

class CandlestickChart extends StatefulWidget {
  const CandlestickChart({Key? key, required this.symbol}) : super(key: key);
  final String symbol;

  @override
  State<CandlestickChart> createState() => _CandlestickChartState();
}

class _CandlestickChartState extends State<CandlestickChart> {
  final List<bool> _selectedInterval = <bool>[true, false, false, false];
  List<List<Candle>> sessionData = [[], [], [], []];
  int currentIndex = 0;

  Future getCandleData(int intervalIndex) async {
    if (sessionData[intervalIndex].isNotEmpty) {
      //if still have session data, do not send api request
      return;
    } else {
      switch (intervalIndex) {
        case 0: //15 mins
          {
            final response = await AlphaVantageApi().getIntraday(widget.symbol);
            StockIntraday intradayData = stockIntradayFromJson(response);
            intradayData.timeSeries15Min.forEach((key, value) {
              sessionData[intervalIndex].add(Candle(
                  date: DateTime.parse(key),
                  high: double.parse(value.high),
                  low: double.parse(value.low),
                  open: double.parse(value.open),
                  close: double.parse(value.close),
                  volume: double.parse(value.volume)));
            });
          }
          break;
        case 1: //daily
          {
            final response = await AlphaVantageApi().getDaily(widget.symbol);
            StockDaily dailyData = stockDailyFromJson(response);
            dailyData.timeSeriesDaily.forEach((key, value) {
              sessionData[intervalIndex].add(Candle(
                  date: DateTime.parse(key),
                  high: double.parse(value.high),
                  low: double.parse(value.low),
                  open: double.parse(value.open),
                  close: double.parse(value.close),
                  volume: double.parse(value.volume)));
            });
          }
          break;
        case 2: //weekly
          {
            final response = await AlphaVantageApi().getWeekly(widget.symbol);
            StockWeekly weeklyData = stockWeeklyFromJson(response);
            weeklyData.weeklyAdjustedTimeSeries.forEach((key, value) {
              sessionData[intervalIndex].add(Candle(
                  date: DateTime.parse(key),
                  high: double.parse(value.high),
                  low: double.parse(value.low),
                  open: double.parse(value.open),
                  close: double.parse(value.close),
                  volume: double.parse(value.volume)));
            });
          }
          break;
        case 3: //monthly
          {
            final response = await AlphaVantageApi().getMonthly(widget.symbol);
            StockMonthly intradayData = stockMonthlyFromJson(response);
            intradayData.monthlyAdjustedTimeSeries.forEach((key, value) {
              sessionData[intervalIndex].add(Candle(
                  date: DateTime.parse(key),
                  high: double.parse(value.high),
                  low: double.parse(value.low),
                  open: double.parse(value.open),
                  close: double.parse(value.close),
                  volume: double.parse(value.volume)));
            });
          }
          break;
        default:
      }
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getCandleData(0);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).orientation == Orientation.portrait
          ? MediaQuery.of(context).size.height * 0.45
          : MediaQuery.of(context).size.height * 0.6,
      child: Column(children: <Widget>[
        ToggleButtons(
          onPressed: (int index) {
            setState(() {
              // The button that is tapped is set to true, and the others to false.
              for (int i = 0; i < _selectedInterval.length; i++) {
                _selectedInterval[i] = i == index;
              }
              getCandleData(index);
              currentIndex = index;
            });
          },
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          renderBorder: false,
          selectedColor: Colors.white,
          fillColor: Colors.blue[200],
          color: Colors.blue[400],
          constraints: const BoxConstraints(
            minHeight: 30.0,
            minWidth: 60.0,
          ),
          isSelected: _selectedInterval,
          children: intervals,
        ),
        Expanded(child: Candlesticks(candles: sessionData[currentIndex]))
      ]),
      color: Colors.white,
    );
  }
}
