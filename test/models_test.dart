import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:stockee/models/global_quote.dart';
import 'package:stockee/models/stock_daily.dart' as stock_daily;
import 'package:stockee/models/stock_intraday.dart' as stock_intraday;
import 'package:stockee/models/stock_weekly.dart' as stock_weekly;
import 'package:stockee/models/stock_monthly.dart' as stock_monthly;
import 'package:stockee/models/news_sentiment.dart' as news_sentiment;

void main() {
  group('Test convert JSON to GlobalQuote', () {
    Map jsonFromApi1 = {
      "Global Quote": {
        "01. symbol": "IBM",
        "02. open": "148.1300",
        "03. high": "149.1600",
        "04. low": "147.7300",
        "05. price": "148.6700",
        "06. volume": "2899995",
        "07. latest trading day": "2022-12-02",
        "08. previous close": "149.1600",
        "09. change": "-0.4900",
        "10. change percent": "-0.3285%"
      }
    };
    GlobalQuote expectedGlobalQuote = GlobalQuote(
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
    test('JSON to GlobalQuote', () {
      expect(
          globalQuoteFromJson(json.encode(jsonFromApi1)) == expectedGlobalQuote,
          true);
    });
  });

  group('Test convert JSON to StockIntraday', () {
    Map jsonFromApi1 = {
      "Meta Data": {
        "1. Information":
            "Intraday (5min) open, high, low, close prices and volume",
        "2. Symbol": "IBM",
        "3. Last Refreshed": "2022-12-02 19:05:00",
        "4. Interval": "5min",
        "5. Output Size": "Compact",
        "6. Time Zone": "US/Eastern"
      },
      "Time Series (15min)": {
        "2022-12-02 19:05:00": {
          "1. open": "148.5000",
          "2. high": "148.5000",
          "3. low": "148.5000",
          "4. close": "148.5000",
          "5. volume": "150"
        },
        "2022-12-02 16:35:00": {
          "1. open": "148.6018",
          "2. high": "148.6018",
          "3. low": "148.6018",
          "4. close": "148.6018",
          "5. volume": "100"
        },
      }
    };
    stock_intraday.StockIntraday expectedResult = stock_intraday.StockIntraday(
        metaData: stock_intraday.MetaData(
          information:
              "Intraday (5min) open, high, low, close prices and volume",
          symbol: "IBM",
          lastRefreshed: DateTime.parse("2022-12-02 19:05:00"),
          outputSize: "Compact",
          timeZone: "US/Eastern",
          interval: "5min",
        ),
        timeSeries15Min: {
          "2022-12-02 19:05:00": stock_intraday.TimeSeries15Min(
              open: "148.5000",
              high: "148.5000",
              low: "148.5000",
              close: "148.5000",
              volume: "150"),
          "2022-12-02 16:35:00": stock_intraday.TimeSeries15Min(
              open: "148.6018",
              high: "148.6018",
              low: "148.6018",
              close: "148.6018",
              volume: "100"),
        });
    test('JSON to StockIntraday', () {
      expect(
          stock_intraday.stockIntradayFromJson(json.encode(jsonFromApi1)) ==
              expectedResult,
          true);
    });
  });

  group('Test convert JSON to StockDaily', () {
    Map jsonFromApi1 = {
      "Meta Data": {
        "1. Information": "Daily Time Series with Splits and Dividend Events",
        "2. Symbol": "IBM",
        "3. Last Refreshed": "2022-12-02",
        "4. Output Size": "Compact",
        "5. Time Zone": "US/Eastern"
      },
      "Time Series (Daily)": {
        "2022-12-02": {
          "1. open": "148.13",
          "2. high": "149.16",
          "3. low": "147.73",
          "4. close": "148.67",
          "5. adjusted close": "148.67",
          "6. volume": "2899995",
          "7. dividend amount": "0.0000",
          "8. split coefficient": "1.0"
        },
        "2022-12-01": {
          "1. open": "149.98",
          "2. high": "150.01",
          "3. low": "147.34",
          "4. close": "149.16",
          "5. adjusted close": "149.16",
          "6. volume": "4495924",
          "7. dividend amount": "0.0000",
          "8. split coefficient": "1.0"
        },
      }
    };
    stock_daily.StockDaily expectedResult = stock_daily.StockDaily(
        metaData: stock_daily.MetaData(
            information: "Daily Time Series with Splits and Dividend Events",
            symbol: "IBM",
            lastRefreshed: DateTime.parse("2022-12-02"),
            outputSize: "Compact",
            timeZone: "US/Eastern"),
        timeSeriesDaily: {
          "2022-12-02": stock_daily.TimeSeriesDaily(
            adjustedClose: "148.67",
            close: "148.67",
            dividendAmount: "0.0000",
            high: "149.16",
            low: "147.73",
            open: "148.13",
            splitCoefficient: "1.0",
            volume: "2899995",
          ),
          "2022-12-01": stock_daily.TimeSeriesDaily(
            adjustedClose: "149.16",
            close: "149.16",
            dividendAmount: "0.0000",
            high: "150.01",
            low: "147.34",
            open: "149.98",
            splitCoefficient: "1.0",
            volume: "4495924",
          )
        });
    test('JSON to StockDaily', () {
      expect(
          stock_daily.stockDailyFromJson(json.encode(jsonFromApi1)) ==
              expectedResult,
          true);
    });
  });

  group('Test convert JSON to StockWeekly', () {
    Map jsonFromApi1 = {
      "Meta Data": {
        "1. Information": "Weekly Adjusted Prices and Volumes",
        "2. Symbol": "IBM",
        "3. Last Refreshed": "2022-12-02",
        "4. Time Zone": "US/Eastern"
      },
      "Weekly Adjusted Time Series": {
        "2022-12-02": {
          "1. open": "147.9800",
          "2. high": "150.0100",
          "3. low": "145.6700",
          "4. close": "148.6700",
          "5. adjusted close": "148.6700",
          "6. volume": "20066941",
          "7. dividend amount": "0.0000"
        },
        "2022-11-25": {
          "1. open": "147.5500",
          "2. high": "150.4600",
          "3. low": "146.4500",
          "4. close": "148.3700",
          "5. adjusted close": "148.3700",
          "6. volume": "16271883",
          "7. dividend amount": "0.0000"
        },
      }
    };
    stock_weekly.StockWeekly expectedResult = stock_weekly.StockWeekly(
        metaData: stock_weekly.MetaData(
            information: "Weekly Adjusted Prices and Volumes",
            symbol: "IBM",
            lastRefreshed: DateTime.parse("2022-12-02"),
            timeZone: "US/Eastern"),
        weeklyAdjustedTimeSeries: {
          "2022-12-02": stock_weekly.WeeklyAdjustedTimeSery(
              open: "147.9800",
              high: "150.0100",
              low: "145.6700",
              close: "148.6700",
              adjustedClose: "148.6700",
              volume: "20066941",
              dividendAmount: "0.0000"),
          "2022-11-25": stock_weekly.WeeklyAdjustedTimeSery(
              open: "147.5500",
              high: "150.4600",
              low: "146.4500",
              close: "148.3700",
              adjustedClose: "148.3700",
              volume: "16271883",
              dividendAmount: "0.0000"),
        });
    test('JSON to StockWeekly', () {
      expect(
          stock_weekly.stockWeeklyFromJson(json.encode(jsonFromApi1)) ==
              expectedResult,
          true);
    });
  });

  group('Test convert JSON to StockMonthly', () {
    Map jsonFromApi1 = {
      "Meta Data": {
        "1. Information": "Monthly Adjusted Prices and Volumes",
        "2. Symbol": "IBM",
        "3. Last Refreshed": "2022-12-02",
        "4. Time Zone": "US/Eastern"
      },
      "Monthly Adjusted Time Series": {
        "2022-12-02": {
          "1. open": "149.9800",
          "2. high": "150.0100",
          "3. low": "147.3400",
          "4. close": "148.6700",
          "5. adjusted close": "148.6700",
          "6. volume": "7395919",
          "7. dividend amount": "0.0000"
        },
        "2022-11-30": {
          "1. open": "138.2500",
          "2. high": "150.4600",
          "3. low": "133.9700",
          "4. close": "148.9000",
          "5. adjusted close": "148.9000",
          "6. volume": "93620235",
          "7. dividend amount": "1.6500"
        },
      }
    };
    stock_monthly.StockMonthly expectedResult = stock_monthly.StockMonthly(
        metaData: stock_monthly.MetaData(
            information: "Monthly Adjusted Prices and Volumes",
            symbol: "IBM",
            lastRefreshed: DateTime.parse(
              "2022-12-02",
            ),
            timeZone: "US/Eastern"),
        monthlyAdjustedTimeSeries: {
          "2022-12-02": stock_monthly.MonthlyAdjustedTimeSery(
              open: "149.9800",
              high: "150.0100",
              low: "147.3400",
              close: "148.6700",
              adjustedClose: "148.6700",
              volume: "7395919",
              dividendAmount: "0.0000"),
          "2022-11-30": stock_monthly.MonthlyAdjustedTimeSery(
              open: "138.2500",
              high: "150.4600",
              low: "133.9700",
              close: "148.9000",
              adjustedClose: "148.9000",
              volume: "93620235",
              dividendAmount: "1.6500"),
        });
    test('JSON to StockMothly', () {
      expect(
          stock_monthly.stockMonthlyFromJson(json.encode(jsonFromApi1)) ==
              expectedResult,
          true);
    });
  });

  group('Test convert JSON to NewsSentiment', () {
    Map jsonFromApi1 = {
      "items": "50",
      "sentiment_score_definition":
          "x <= -0.35: Bearish; -0.35 < x <= -0.15: Somewhat-Bearish; -0.15 < x < 0.15: Neutral; 0.15 <= x < 0.35: Somewhat_Bullish; x >= 0.35: Bullish",
      "relevance_score_definition":
          "0 < x <= 1, with a higher score indicating higher relevance.",
      "feed": [
        {
          "title":
              "Jim Cramer's top 10 things to watch in the market Monday: Stocks, China, Apple",
          "url":
              "https://www.cnbc.com/2022/12/05/jim-cramers-top-10-things-to-watch-in-the-market-monday-stocks-china-apple.html",
          "time_published": "20221205T142156",
          "authors": ["Jim Cramer"],
          "summary":
              "Morgan Stanley's Mike Wilson says he has seen enough of the rally.",
          "banner_image":
              "https://image.cnbcfm.com/api/v1/image/107160401-1669997168538-nys.jpg?v=1670250403&w=1920&h=1080",
          "source": "CNBC",
          "category_within_source": "Top News",
          "source_domain": "www.cnbc.com",
          "topics": [
            {"topic": "Technology", "relevance_score": "1.0"}
          ],
          "overall_sentiment_score": 0.052548,
          "overall_sentiment_label": "Neutral",
          "ticker_sentiment": [
            {
              "ticker": "AAPL",
              "relevance_score": "0.401331",
              "ticker_sentiment_score": "-0.335566",
              "ticker_sentiment_label": "Somewhat-Bearish"
            }
          ]
        },
      ]
    };
    news_sentiment.NewsSentiment expectedResult = news_sentiment.NewsSentiment(
        items: "50",
        relevanceScoreDefinition:
            "0 < x <= 1, with a higher score indicating higher relevance.",
        sentimentScoreDefinition:
            "x <= -0.35: Bearish; -0.35 < x <= -0.15: Somewhat-Bearish; -0.15 < x < 0.15: Neutral; 0.15 <= x < 0.35: Somewhat_Bullish; x >= 0.35: Bullish",
        feed: [
          news_sentiment.Feed(
              title:
                  "Jim Cramer's top 10 things to watch in the market Monday: Stocks, China, Apple",
              url:
                  "https://www.cnbc.com/2022/12/05/jim-cramers-top-10-things-to-watch-in-the-market-monday-stocks-china-apple.html",
              timePublished: "20221205T142156",
              authors: ["Jim Cramer"],
              summary:
                  "Morgan Stanley's Mike Wilson says he has seen enough of the rally.",
              bannerImage:
                  "https://image.cnbcfm.com/api/v1/image/107160401-1669997168538-nys.jpg?v=1670250403&w=1920&h=1080",
              source: "CNBC",
              categoryWithinSource: "Top News",
              sourceDomain: "www.cnbc.com",
              topics: [
                news_sentiment.Topic(topic: "Technology", relevanceScore: "1.0")
              ],
              overallSentimentScore: 0.052548,
              overallSentimentLabel: "Neutral",
              tickerSentiment: [
                news_sentiment.TickerSentiment(
                    ticker: "AAPL",
                    relevanceScore: "0.401331",
                    tickerSentimentScore: "-0.335566",
                    tickerSentimentLabel: "Somewhat-Bearish")
              ])
        ]);
    test('JSON to StockMothly', () {
      expect(
          news_sentiment.newsSentimentFromJson(json.encode(jsonFromApi1)) ==
              expectedResult,
          true);
    });
  });
}
