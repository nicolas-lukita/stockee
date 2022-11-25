import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import './news_card.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key, required this.isFollowed}) : super(key: key);
  final bool isFollowed;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: IconButton(
                onPressed: () {
                  setState(() {});
                },
                icon: Icon(
                  (widget.isFollowed ? Icons.star : Icons.star_border),
                  size: 35,
                ),
                color: Colors.amber,
              ),
            )
          ],
        ),
        body: SlidingUpPanel(
          defaultPanelState: PanelState.CLOSED,
          //if orientation landscape, hide panel so it will not block content (temporary solution)
          minHeight: MediaQuery.of(context).orientation == Orientation.portrait
              ? 80
              : 0,
          backdropEnabled: true,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          //panel is slide up content
          panel: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    "News",
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 25,
                        color: Colors.black,
                        letterSpacing: 0.5),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    itemBuilder: (ctx, index) {
                      return const NewsCard();
                    },
                    itemCount: 6,
                    scrollDirection: Axis.vertical,
                  ),
                ),
              ]),
          //body is content behind sliding up panel
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          'GME',
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 16,
                              color: Colors.grey,
                              letterSpacing: 0.5),
                        ),
                        const Text(
                          'GameStop',
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 35,
                              color: Colors.black,
                              letterSpacing: 0.5),
                        ),
                        Row(
                          children: const <Widget>[
                            Text(
                              '\$399',
                              style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 18,
                                  color: Colors.black,
                                  letterSpacing: 0.5),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              '+\$40%',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.red,
                                  letterSpacing: 0.5),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              '-\$23.8',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.grey,
                                  letterSpacing: 0.5),
                            )
                          ],
                        )
                      ],
                    ),
                    const CircleAvatar(
                      radius: 25,
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  height: 200,
                  width: double.infinity,
                  child: const Text("GRAPH"),
                  color: Colors.blue,
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    "Follow",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 25,
                        letterSpacing: 0.5),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: const Size.fromHeight(
                        55), // fromHeight use double.infinity as width and 40 as the height
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
