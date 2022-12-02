import 'package:flutter/material.dart';

class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen(
      {Key? key,
      required this.uid,
      required this.userWatchlist,
      required this.globalQuoteDataList})
      : super(key: key);
  final String uid;
  final List userWatchlist;
  final List globalQuoteDataList;

  @override
  Widget build(BuildContext context) {
    return globalQuoteDataList.length != userWatchlist.length
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : OrientationBuilder(builder: (ctx, orientation) {
            return orientation == Orientation.portrait
                ? Column(
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Text("Portfolio"),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          child: Row(
                            children: <Widget>[
                              const SizedBox(
                                width: 15,
                              ),
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  'OVERVIEW DATA',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Expanded(
                          child: ListView.builder(
                        padding: EdgeInsets.all(10),
                        itemCount: userWatchlist.length,
                        itemBuilder: (context, index) {
                          return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: SizedBox(
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        userWatchlist[index]['symbol'],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w800,
                                            color: Colors.grey,
                                            letterSpacing: 0.5),
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  userWatchlist[index]['name'],
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      fontSize: 18,
                                                      color: Colors.black,
                                                      letterSpacing: 0.5),
                                                ),
                                                Text(
                                                  '\$' +
                                                      globalQuoteDataList[index]
                                                          .globalQuote
                                                          .price,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      color: Colors.black,
                                                      letterSpacing: 0.5),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  globalQuoteDataList[index]
                                                      .globalQuote
                                                      .changePercent,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.red,
                                                      letterSpacing: 0.5),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  globalQuoteDataList[index]
                                                      .globalQuote
                                                      .change,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.grey,
                                                      letterSpacing: 0.5),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  "Open: " +
                                                      globalQuoteDataList[index]
                                                          .globalQuote
                                                          .open,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      color: Colors.grey,
                                                      letterSpacing: 0.5),
                                                ),
                                                Text(
                                                  'High: ' +
                                                      globalQuoteDataList[index]
                                                          .globalQuote
                                                          .high,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      color: Colors.black,
                                                      letterSpacing: 0.5),
                                                ),
                                                Text(
                                                  'Low: ' +
                                                      globalQuoteDataList[index]
                                                          .globalQuote
                                                          .low,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      color: Colors.black,
                                                      letterSpacing: 0.5),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  'Close ' +
                                                      globalQuoteDataList[index]
                                                          .globalQuote
                                                          .previousClose,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.red,
                                                      letterSpacing: 0.5),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  'Volume: ' +
                                                      globalQuoteDataList[index]
                                                          .globalQuote
                                                          .volume,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.grey,
                                                      letterSpacing: 0.5),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      Center(child: Text('BIG CHART'))
                                    ],
                                  ),
                                ),
                              ));
                        },
                      ))
                    ],
                  )
                : Row(
                    children: <Widget>[
                      Expanded(child: Text('tasfd')),
                      Expanded(child: Text('asdfa'))
                    ],
                  );
          });
  }
}
