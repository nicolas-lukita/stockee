import 'package:flutter/material.dart';

class SquareInfoCard extends StatelessWidget {
  const SquareInfoCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        width: 150,
        height: 150,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            const CircleAvatar(
              radius: 30,
            ),
            //Fittedbox to avoid overflow
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "Teslasido",
                style: Theme.of(context).textTheme.headline6,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Text(
              "\$999",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const <Widget>[
                Text("\$98"),
                Text(
                  "-\$200",
                  style: TextStyle(fontWeight: FontWeight.w200),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
