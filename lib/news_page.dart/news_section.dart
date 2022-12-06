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
  late Future<NewsSentiment> newsSentiment;

  Future<NewsSentiment> getNewsSentiment() async {
    final response = await AlphaVantageApi().getNewsSentiment(widget.ticker);
    return newsSentimentFromJson(response);
  }

  @override
  void initState() {
    super.initState();
    newsSentiment = getNewsSentiment();
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
            child: FutureBuilder(
                future: newsSentiment,
                builder: (context, AsyncSnapshot<NewsSentiment> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    itemBuilder: (ctx, index) {
                      return NewsCard(
                        title: snapshot.data!.feed[index].title,
                        source: snapshot.data!.feed[index].source,
                        timePublished: snapshot.data!.feed[index].timePublished,
                        url: snapshot.data!.feed[index].url,
                        image: snapshot.data!.feed[index].bannerImage,
                      );
                    },
                    itemCount: snapshot.data!.feed.length,
                    scrollDirection: Axis.vertical,
                  );
                }),
          ),
        ]);
  }
}
