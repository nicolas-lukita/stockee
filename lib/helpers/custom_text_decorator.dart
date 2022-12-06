import 'package:flutter/material.dart';
import 'package:stockee/helpers/app_colors.dart';

class CustomTextDecorator {
  static Widget stockPriceText(String text) {
    return Text(
      "\$$text",
      style: const TextStyle(fontWeight: FontWeight.w500),
      overflow: TextOverflow.ellipsis,
    );
  }

  static Widget stockChangeText(String text) {
    return Text(
      double.parse(text) == 0
          ? "\$$text"
          : double.parse(text) > 0
              ? "+\$$text"
              : "-\$${text.replaceAll(RegExp('-'), '')}",
      style: TextStyle(
          fontWeight: FontWeight.w600,
          // fontSize: 14,
          color: double.parse(text) == 0
              ? Colors.grey
              : double.parse(text) > 0
                  ? Colors.green
                  : Colors.red,
          letterSpacing: 0.5),
      overflow: TextOverflow.ellipsis,
    );
  }

  static Widget stockChangePercentText(String text) {
    return Text(
      text,
      style: TextStyle(
          fontWeight: FontWeight.w600,
          //fontSize: 14,
          color: double.parse(text.replaceAll(RegExp('%'), '')) == 0
              ? Colors.grey
              : text.contains('-')
                  ? Colors.red
                  : Colors.green,
          backgroundColor: double.parse(text.replaceAll(RegExp('%'), '')) == 0
              ? Colors.grey.withOpacity(0.1)
              : text.contains('-')
                  ? Colors.red.withOpacity(0.2)
                  : Colors.green.withOpacity(0.2),
          letterSpacing: 0.5),
      overflow: TextOverflow.ellipsis,
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
      overflow: TextOverflow.ellipsis,
    );
  }

  static Widget stockLogo(String symbol, double radius) {
    return CircleAvatar(
      backgroundColor: AppColors.darkCream,
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

  static Widget sectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
    );
  }
}
