import 'dart:developer';

import 'package:http/http.dart' as http;
import 'api_key.dart';

const String baseUrl = "https://www.alphavantage.co/query?";

class AlphaVantageApi {
  var client = http.Client();

  Future<dynamic> getGlobalQuote(String symbol) async {
    String apiFunction = "function=GLOBAL_QUOTE";

    var url = Uri.parse("$baseUrl$apiFunction&symbol=IBM&apikey=demo");

    // var url = Uri.parse(
    //     "$baseUrl$apiFunction&symbol=$symbol&apikey=$alphavantageKey");

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

    var url =
        Uri.parse("$baseUrl$apiFunction&symbol=IBM&interval=15min&apikey=demo");

    // var url = Uri.parse(
    //     "$baseUrl$apiFunction&symbol=$symbol&interval=$interval&apikey=$alphavantageKey");

    var response = await client.get(url);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      log("Stock intraday api request error");
    }
  }

  Future<dynamic> getDaily(String symbol) async {
    String apiFunction = "function=TIME_SERIES_DAILY_ADJUSTED";

    var url = Uri.parse("$baseUrl$apiFunction&symbol=IBM&apikey=demo");

    // var url = Uri.parse(
    //     "$baseUrl$apiFunction&symbol=$symbol&apikey=$alphavantageKey");

    var response = await client.get(url);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      log("Stock daily api request error");
    }
  }

  Future<dynamic> getWeekly(String symbol) async {
    String apiFunction = "function=TIME_SERIES_WEEKLY_ADJUSTED";

    var url = Uri.parse("$baseUrl$apiFunction&symbol=IBM&apikey=demo");

    // var url = Uri.parse(
    //     "$baseUrl$apiFunction&symbol=$symbol&apikey=$alphavantageKey");

    var response = await client.get(url);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      log("Stock weekly api request error");
    }
  }

  Future<dynamic> getNewsSentiment(String symbol) async {
    String apiFunction = "function=NEWS_SENTIMENT";

    var url = Uri.parse(
        "$baseUrl$apiFunction&tickers=AAPL&topics=technology&apikey=demo");

    // var url = Uri.parse(
    //     "$baseUrl$apiFunction&tickers=$symbol&apikey=$alphavantageKey");

    var response = await client.get(url);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      log("Stock weekly api request error");
    }
  }
}
