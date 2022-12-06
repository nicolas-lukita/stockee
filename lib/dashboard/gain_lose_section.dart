import 'package:flutter/material.dart';
import 'package:stockee/helpers/custom_text_decorator.dart';
import '../helpers/helper_functions.dart';
import './square_info_card.dart';

class GainLoseSection extends StatefulWidget {
  const GainLoseSection({
    Key? key,
    required this.orientation,
    required this.watchlist,
    required this.globalQuoteDataList,
  }) : super(key: key);
  final Orientation orientation;
  final List watchlist;
  final List globalQuoteDataList;

  @override
  State<GainLoseSection> createState() => _GainLoseSectionState();
}

class _GainLoseSectionState extends State<GainLoseSection> {
  bool isLoading = true;
  List gainLoseData = [];

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: CustomTextDecorator.sectionTitle("Gainers and Losers")),
          const SizedBox(
            height: 10,
          ),
          Expanded(
              child: widget.watchlist.isEmpty
                  ? const Center(
                      child: Text("Follow some stocks!"),
                    )
                  : GridView.builder(
                      //not scrollable for portrait orientation
                      physics: widget.orientation == Orientation.portrait
                          ? const NeverScrollableScrollPhysics()
                          : null,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        //display in a row when portrait, column when landscape
                        crossAxisCount:
                            widget.orientation == Orientation.portrait ? 2 : 1,
                        childAspectRatio: 1 / 1,
                      ),
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(15),
                      itemBuilder: (context, index) {
                        gainLoseData = HelperFunctions.getGainLoseStock(
                            widget.globalQuoteDataList);
                        return SquareInfoCard(
                            globalQuoteData: gainLoseData[index]);
                      },
                      itemCount: 2,
                    )),
        ]);
  }
}
