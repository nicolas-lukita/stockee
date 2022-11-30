import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:stockee/models/stock_info.dart';
import './collapsed_panel_component.dart';
import './news_component.dart';
import './details_component.dart';

class DetailsScreen extends StatefulWidget {
  static const routeName = '/details-screen';
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final String uid = args['uid'];
    final StockInfo stock = args['stock'];
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
        //slide up content
        panel: const NewsComponent(),
        collapsed: const CollapsedPanelComponent(),
        //main content behind sliding up panel
        body: Padding(
          padding: EdgeInsets.all(15),
          child: ConstrainedBox(
              constraints:
                  BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
              child: DetailsComponent(
                stock: stock,
              )),
        ),
      ),
    );
  }
}
