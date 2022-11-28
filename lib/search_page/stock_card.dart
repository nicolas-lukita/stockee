import 'dart:math';

import 'package:flutter/material.dart';

class StockCard extends StatelessWidget {
  const StockCard(
      {Key? key,
      required this.symbol,
      required this.name,
      required this.isFollowed})
      : super(key: key);
  final String symbol;
  final String name;
  final bool isFollowed;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: GridTile(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 5,
              ),
              LayoutBuilder(builder: (context, constraints) {
                return CircleAvatar(
                  backgroundColor: Colors.black12,
                  radius: min(
                      constraints.maxHeight / 5.3, constraints.maxWidth / 5.3),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text(
                        symbol,
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                );
              }),
              Center(
                  child: Text(
                name,
                overflow: TextOverflow.ellipsis,
              )),
              Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      primary: isFollowed ? Colors.grey : Colors.black87,
                    ),
                    onPressed: () {},
                    child: isFollowed
                        ? const Text("Unfollow")
                        : const Text("Follow"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
