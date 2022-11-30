import 'package:flutter/material.dart';

class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen(
      {Key? key, required this.uid, required this.userWatchlist})
      : super(key: key);
  final String uid;
  final List userWatchlist;

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (ctx, orientation) {
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
                            style: const TextStyle(fontWeight: FontWeight.w500),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  userWatchlist[index],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: Colors.grey,
                                      letterSpacing: 0.5),
                                ),
                                Text(
                                  'stockName',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black,
                                      letterSpacing: 0.5),
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      '\$' + 'price',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w800,
                                          color: Colors.black,
                                          letterSpacing: 0.5),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'hangePercent',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.red,
                                          letterSpacing: 0.5),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      '.change',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey,
                                          letterSpacing: 0.5),
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
