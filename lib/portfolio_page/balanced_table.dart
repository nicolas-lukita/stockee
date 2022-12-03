import 'package:flutter/material.dart';

class BalancedTable extends StatelessWidget {
  const BalancedTable(
      {Key? key, required this.listKey, required this.listValue})
      : super(key: key);
  final List<String> listKey;
  final List listValue;

  @override
  Widget build(BuildContext context) {
    return listKey.length != listValue.length
        ? const Center(child: Text("Key and value length didn't match!"))
        : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 100,
                width: 60,
                child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: listKey.length,
                    itemBuilder: (context, index) {
                      return Text(listKey[index] + ": ",
                          textAlign: TextAlign.end,
                          style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                              letterSpacing: 0.5));
                    }),
              ),
              const SizedBox(
                width: 5,
              ),
              Container(
                height: 100,
                width: 80,
                child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: listKey.length,
                    itemBuilder: (context, index) {
                      return Text(
                          listKey[index] == "Volume"
                              ? listValue[index]
                              : "\$" + listValue[index],
                          style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black54,
                              letterSpacing: 0.5));
                    }),
              )
            ],
          );
  }
}
