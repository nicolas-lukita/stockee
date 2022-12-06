import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:stockee/helpers/demo_mode.dart';
import 'api_key.dart';

const String baseUrl = "https://www.alphavantage.co/query?";

class AlphaVantageApi {
  var client = http.Client();

  Future<dynamic> getGlobalQuote(String symbol) async {
    String apiFunction = "function=GLOBAL_QUOTE";

    //demo
    // var url = Uri.parse("$baseUrl$apiFunction&symbol=IBM&apikey=demo");

    var url = DemoMode.isDemoMode
        ? Uri.parse("$baseUrl$apiFunction&symbol=IBM&apikey=demo")
        : Uri.parse(
            "$baseUrl$apiFunction&symbol=$symbol&apikey=$alphavantageKey");

    var response = await client.get(url);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      log("Stock global quote api request error");
    }
  }

  Future<dynamic> getIntraday(String symbol) async {
    String apiFunction = "function=TIME_SERIES_INTRADAY";
    String interval = "15min";

    //demo
    // var url =
    //     Uri.parse("$baseUrl$apiFunction&symbol=IBM&interval=5min&apikey=demo");

    var url = DemoMode.isDemoMode
        ? Uri.parse("$baseUrl$apiFunction&symbol=IBM&interval=5min&apikey=demo")
        : Uri.parse(
            "$baseUrl$apiFunction&symbol=$symbol&interval=$interval&apikey=$alphavantageKey");

    var response = await client.get(url);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      log("Stock intraday api request error");
    }
  }

  Future<dynamic> getDaily(String symbol) async {
    String apiFunction = "function=TIME_SERIES_DAILY_ADJUSTED";

    //demo
    // var url = Uri.parse("$baseUrl$apiFunction&symbol=IBM&apikey=demo");

    var url = DemoMode.isDemoMode
        ? Uri.parse("$baseUrl$apiFunction&symbol=IBM&apikey=demo")
        : Uri.parse(
            "$baseUrl$apiFunction&symbol=$symbol&apikey=$alphavantageKey");

    var response = await client.get(url);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      log("Stock daily api request error");
    }
  }

  Future<dynamic> getWeekly(String symbol) async {
    String apiFunction = "function=TIME_SERIES_WEEKLY_ADJUSTED";

    //demo
    // var url = Uri.parse("$baseUrl$apiFunction&symbol=IBM&apikey=demo");

    var url = DemoMode.isDemoMode
        ? Uri.parse("$baseUrl$apiFunction&symbol=IBM&apikey=demo")
        : Uri.parse(
            "$baseUrl$apiFunction&symbol=$symbol&apikey=$alphavantageKey");

    var response = await client.get(url);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      log("Stock weekly api request error");
    }
  }

  Future<dynamic> getMonthly(String symbol) async {
    String apiFunction = "function=TIME_SERIES_MONTHLY_ADJUSTED";

    //demo
    // var url = Uri.parse("$baseUrl$apiFunction&symbol=IBM&apikey=demo");

    var url = DemoMode.isDemoMode
        ? Uri.parse("$baseUrl$apiFunction&symbol=IBM&apikey=demo")
        : Uri.parse(
            "$baseUrl$apiFunction&symbol=$symbol&apikey=$alphavantageKey");

    var response = await client.get(url);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      log("Stock weekly api request error");
    }
  }

  Future<dynamic> getNewsSentiment(String symbol) async {
    String apiFunction = "function=NEWS_SENTIMENT";

    //demo
    // var url = Uri.parse(
    //     "$baseUrl$apiFunction&tickers=AAPL&topics=technology&apikey=demo");

    var url = DemoMode.isDemoMode
        ? Uri.parse(
            "$baseUrl$apiFunction&tickers=AAPL&topics=technology&apikey=demo")
        : Uri.parse(
            "$baseUrl$apiFunction&tickers=$symbol&apikey=$alphavantageKey");

    var response = await client.get(url);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      log("News Sentiment api request error");
    }
  }
}
