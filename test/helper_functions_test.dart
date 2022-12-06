import 'package:collection/collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stockee/helpers/custom_date_time_formatter.dart';
import 'package:stockee/helpers/helper_functions.dart';
import 'package:stockee/models/global_quote.dart';

void main() {
  group("Test custom datetime formatter", () {
    String stringTimestamp = '20221202T115557';
    test('timestamp string to readable string', () {
      expect(CustomDateTimeFormatter.stringToDateTime(stringTimestamp),
          "2 Dec 2022");
    });
  });

  group('Test getGainLoseStock', () {
    var ibm = GlobalQuote(
        globalQuote: GlobalQuoteClass(
      symbol: "IBM",
      open: "148.1300",
      high: "149.1600",
      low: "147.7300",
      price: "148.6700",
      volume: "2899995",
      latestTradingDay: DateTime.parse("2022-12-02"),
      previousClose: "149.1600",
      change: "-0.4900",
      changePercent: "-0.3285%",
    ));

    var nflx = GlobalQuote(
        globalQuote: GlobalQuoteClass(
      symbol: "NFLX",
      open: "148.1300",
      high: "149.1600",
      low: "147.7300",
      price: "148.6700",
      volume: "2899995",
      latestTradingDay: DateTime.parse("2022-12-02"),
      previousClose: "149.1600",
      change: "0.4900",
      changePercent: "0.3285%",
    ));
    List globalQuoteDataTestList1 = [ibm];
    List expectedResult1 = [ibm, ibm];
    List globalQuoteDataTestList2 = [nflx, ibm];
    List expectedResult2 = [nflx, ibm];

    //compare content of reference type variable
    Function deepEq = const DeepCollectionEquality().equals;

    test('Gain Lose Test with no data', () {
      expect(HelperFunctions.getGainLoseStock([]), []);
    });
    test('Gain Lose Test with only 1 data', () {
      deepEq(HelperFunctions.getGainLoseStock(globalQuoteDataTestList1),
          expectedResult1);
    });
    test('Gain Lose Test with 2 data', () {
      expect(
          deepEq(HelperFunctions.getGainLoseStock(globalQuoteDataTestList2),
              expectedResult2),
          true);
    });
  });
}
