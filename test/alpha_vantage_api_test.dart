import 'package:flutter_test/flutter_test.dart';
import 'package:stockee/services/alpha_vantage_api.dart';

void main() {
  group('Test Alpha Vantage Api', () {
    //TEST CONSUMES REQUEST, PLEASE CHANGE TO USING DEMO API KEY FIRST
    test('get global quote data from api', () {
      expect(AlphaVantageApi().getGlobalQuote("IBM"), isA<Future<dynamic>>());
    });
    test('get intraday data from api', () {
      expect(AlphaVantageApi().getIntraday("IBM"), isA<Future<dynamic>>());
    });
    test('get daily stock data from api', () {
      expect(AlphaVantageApi().getDaily("IBM"), isA<Future<dynamic>>());
    });
    test('get weekly stock data from api', () {
      expect(AlphaVantageApi().getWeekly("IBM"), isA<Future<dynamic>>());
    });
    test('get monthly stock data from api', () {
      expect(AlphaVantageApi().getMonthly("IBM"), isA<Future<dynamic>>());
    });
    test('get news sentiment data from api', () {
      expect(AlphaVantageApi().getNewsSentiment("IBM"), isA<Future<dynamic>>());
    });
  });
}
