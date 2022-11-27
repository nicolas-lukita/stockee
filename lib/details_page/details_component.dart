import 'package:flutter/material.dart';
import 'package:stockee/details_page/details_header.dart';
import './candlestick_chart.dart';

class DetailsComponent extends StatelessWidget {
  const DetailsComponent({Key? key}) : super(key: key);

  Widget FollowButton() {
    return ElevatedButton(
      onPressed: () {},
      child: const Text(
        "Follow",
        style: TextStyle(
            fontWeight: FontWeight.w500, fontSize: 25, letterSpacing: 0.5),
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        minimumSize: const Size.fromHeight(
            40), // fromHeight use double.infinity as width and manual the height
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (ctx, orientation) {
        return orientation == Orientation.portrait
            ? Column(
                children: <Widget>[
                  DetailsHeader(),
                  const SizedBox(
                    height: 30,
                  ),
                  const CandlestickChart(),
                  const SizedBox(
                    height: 15,
                  ),
                  FollowButton(),
                ],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: <Widget>[
                        const DetailsHeader(),
                        const SizedBox(
                          height: 30,
                        ),
                        FollowButton(),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Expanded(flex: 3, child: CandlestickChart()),
                ],
              );
      },
    );
  }
}
