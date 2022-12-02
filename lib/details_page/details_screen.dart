import 'dart:io';
import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:stockee/models/stock_info.dart';
import '../models/global_quote.dart';
import '../news_page.dart/news_section.dart';
import 'collapsed_panel_section.dart';
import 'details_section.dart';
import 'package:screenshot/screenshot.dart';

class DetailsScreen extends StatefulWidget {
  static const routeName = '/details-screen';
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  Future saveAndShare(Uint8List bytes) async {
    //1. set up directory to store image file
    final directory = await getApplicationDocumentsDirectory();
    //2. create file in path
    final image = File('${directory.path}/stockScreenshot.png');
    //3. put the image byte in file
    image.writeAsBytesSync(bytes);
    //4. share the screenshot image
    await Share.shareFiles([image.path], text: 'Captured from Stockee');
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final String uid = args['uid'];
    final String stockName = args['stockName'];
    final GlobalQuote globalQuoteData = args['globalQuoteData'];

    ScreenshotController _screenshotController = ScreenshotController();

    return Screenshot(
      controller: _screenshotController,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: IconButton(
                onPressed: () async {
                  final image = await _screenshotController
                      .capture(delay: const Duration(milliseconds: 100))
                      .then((value) async {
                    saveAndShare(value!);
                  });
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
          panel: NewsSection(
            ticker: globalQuoteData.globalQuote.symbol,
          ),
          collapsed: const CollapsedPanelSection(),
          //main content behind sliding up panel
          body: Padding(
            padding: EdgeInsets.all(15),
            child: ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height),
                child: DetailsSection(
                  stockName: stockName,
                  globalQuoteData: globalQuoteData,
                )),
          ),
        ),
      ),
    );
  }
}
