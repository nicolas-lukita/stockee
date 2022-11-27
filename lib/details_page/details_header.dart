import 'package:flutter/material.dart';

class DetailsHeader extends StatelessWidget {
  const DetailsHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'GME',
          style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 16,
              color: Colors.grey,
              letterSpacing: 0.5),
        ),
        const Text(
          'GameStop',
          style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 35,
              color: Colors.black,
              letterSpacing: 0.5),
        ),
        Row(
          children: const <Widget>[
            Text(
              '\$399',
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                  color: Colors.black,
                  letterSpacing: 0.5),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              '+\$40%',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Colors.red,
                  letterSpacing: 0.5),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              '-\$23.8',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Colors.grey,
                  letterSpacing: 0.5),
            )
          ],
        )
      ],
    );
  }
}
