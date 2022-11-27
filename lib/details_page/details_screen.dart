import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import './collapsed_panel_component.dart';
import './news_component.dart';
import './details_component.dart';

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
      backgroundColor: Colors.white,
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
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(
              onPressed: () {
                setState(() {});
              },
              icon: const Icon(
                Icons.share,
                size: 25,
              ),
            ),
          )
        ],
      ),
      body: SlidingUpPanel(
        defaultPanelState: PanelState.CLOSED,
        //if orientation landscape, hide panel so it will not block content (temporary solution)
        minHeight: 30,
        backdropEnabled: true,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        //panel is slide up content
        panel: const NewsComponent(),
        collapsed: const CollapsedPanelComponent(),
        //body is content behind sliding up panel
        body: Padding(
          padding: EdgeInsets.all(15),
          child: ConstrainedBox(
              constraints:
                  BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
              child: DetailsComponent()),
        ),
      ),
    );
  }
}
