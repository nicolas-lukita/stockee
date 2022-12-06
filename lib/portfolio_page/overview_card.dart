import 'package:flutter/material.dart';
import 'package:stockee/helpers/custom_text_decorator.dart';

class OverviewCard extends StatelessWidget {
  const OverviewCard({Key? key, required this.username}) : super(key: key);
  final String username;

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          padding: const EdgeInsets.all(15),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FittedBox(
                  fit: BoxFit.scaleDown,
                  child: CustomTextDecorator.stockTitleText(username, 16)),
              const Text("Best performing:"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const <Widget>[
                  Text('[sbl]'),
                  Text('Stock Name '),
                  Text('Price '),
                  Text('change percent')
                ],
              ),
              const Text('Worst performaing:'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const <Widget>[Text('[sbl]'), Text('Stock Name')],
              ),
            ],
          ),
        ),
      );
    });
  }
}
