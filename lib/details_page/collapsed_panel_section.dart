import 'package:flutter/material.dart';

class CollapsedPanelSection extends StatelessWidget {
  const CollapsedPanelSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        color: Colors.black38,
      ),
      child: const Center(
        child: Text(
          "News down here!",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
