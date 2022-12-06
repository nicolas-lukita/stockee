import 'dart:math';
import 'package:flutter/material.dart';
import 'package:stockee/helpers/custom_text_decorator.dart';
import '../helpers/custom_buttons.dart';

class StockCard extends StatelessWidget {
  const StockCard(
      {Key? key,
      required this.symbol,
      required this.name,
      required this.uid,
      required this.isFollowed})
      : super(key: key);
  final String symbol;
  final String name;
  final String uid;
  final bool isFollowed;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: GridTile(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              LayoutBuilder(builder: (context, constraints) {
                return CustomTextDecorator.stockLogo(
                    symbol,
                    min(constraints.maxHeight / 5.3,
                        constraints.maxWidth / 5.3));
              }),
              const SizedBox(
                height: 10,
              ),
              Center(
                  child: Text(
                name,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )),
              Padding(
                padding: const EdgeInsets.all(5),
                child: SizedBox(
                    width: double.infinity,
                    child: CustomButtons.followButton(
                        uid, symbol, name, isFollowed, 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
