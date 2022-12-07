import 'package:flutter/material.dart';
import 'package:stockee/models/news_sentiment.dart';
import 'package:stockee/services/alpha_vantage_api.dart';
import './news_card.dart';

class NewsSection extends StatefulWidget {
  const NewsSection({Key? key, required this.ticker}) : super(key: key);
  final String ticker;

  @override
  State<NewsSection> createState() => _NewsSectionState();
}

class _NewsSectionState extends State<NewsSection> {
  List newsSentimentFeed = [];
  bool isLoadingNews = false;

  getNewsSentiment() async {
    setState(() {
      isLoadingNews = true;
    });
    final response = await AlphaVantageApi().getNewsSentiment(widget.ticker);
    var newsSentiment = newsSentimentFromJson(response);
    setState(() {
      newsSentimentFeed = newsSentiment.feed;
      isLoadingNews = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getNewsSentiment();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              widget.ticker,
              style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 25,
                  letterSpacing: 0.5),
            ),
          ),
          Expanded(
              child: isLoadingNews == 0
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      itemBuilder: (ctx, index) {
                        print(newsSentimentFeed.toString());
                        return NewsCard(
                          title: newsSentimentFeed[index].title,
                          source: newsSentimentFeed[index].source,
                          timePublished: newsSentimentFeed[index].timePublished,
                          url: newsSentimentFeed[index].url,
                          image: newsSentimentFeed[index].bannerImage,
                        );
                      },
                      itemCount: newsSentimentFeed.length,
                      scrollDirection: Axis.vertical,
                    )),
        ]);
  }
}
