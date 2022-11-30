import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stockee/helpers/converters/stock_data_convert.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  late StockData? doto;

  Future readJson() async {
    final String response =
        await rootBundle.loadString('lib/dummy_data/intraday_sample.json');
    // Map<String, dynamic> data = await json.decode(response);
    doto = stockDataFromJson(response);
    setState(() {});
  }

  @override
  void initState() {
    print('hello');
    readJson();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            "TEST PAGE",
            style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 35,
                color: Colors.black,
                letterSpacing: 0.5),
          ),
        ),
        body: Column(children: [
          ElevatedButton(
            child: const Text('Load Data'),
            onPressed: readJson,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: doto!.timeSeries5Min.keys.length,
                itemBuilder: (ctx, index) {
                  String keyz = doto!.timeSeries5Min.keys.elementAt(index);
                  return Card(
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        leading: Text(doto!.timeSeries5Min[keyz]!.the1Open),
                        title: Text(doto!.timeSeries5Min[keyz]!.the2High),
                        subtitle: Text(doto!.timeSeries5Min[keyz]!.the3Low),
                        trailing: Text(doto!.timeSeries5Min[keyz]!.the4Close),
                      ));
                }),
          )
        ]));
  }
}
