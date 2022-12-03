import 'package:flutter/material.dart';

class CustomTextDecorator {
  static Widget stockPriceText(String text) {
    return Text(
      "\$" + text,
      style: const TextStyle(fontWeight: FontWeight.w500),
    );
  }

  static Widget stockChangeText(String text) {
    return Text(
      double.parse(text) > 0
          ? "+\$" + text
          : "-\$" + text.replaceAll(RegExp('-'), ''),
      style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
          color: double.parse(text) > 0 ? Colors.green : Colors.red,
          letterSpacing: 0.5),
    );
  }

  static Widget stockChangePercentText(String text) {
    return Text(
      text,
      style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
          color: text.contains('-') ? Colors.red : Colors.green,
          backgroundColor: text.contains('-')
              ? Colors.red.withOpacity(0.2)
              : Colors.green.withOpacity(0.2),
          letterSpacing: 0.5),
    );
  }

  static Widget stockTitleText(String text, double fontSize) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
      style: TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: fontSize,
          color: Colors.black,
          letterSpacing: 0.5),
    );
  }

  static Widget stockSymbolText(String text) {
    return Text(
      text,
      style: const TextStyle(
          fontWeight: FontWeight.w800, color: Colors.grey, letterSpacing: 0.5),
    );
  }

  static Widget stockLogo(String symbol, double radius) {
    return CircleAvatar(
      backgroundColor: Colors.black12,
      radius: radius,
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
  }
}
