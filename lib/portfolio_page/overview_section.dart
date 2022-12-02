import 'package:flutter/material.dart';

class OverviewSection extends StatelessWidget {
  const OverviewSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Text("Portfolio"),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: SizedBox(
            width: double.infinity,
            child: Row(
              children: <Widget>[
                const SizedBox(
                  width: 15,
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'OVERVIEW DATA',
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
