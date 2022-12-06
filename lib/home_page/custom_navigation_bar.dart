import 'package:flutter/material.dart';
import 'package:stockee/helpers/app_colors.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.brown,
      child: TabBar(
        labelColor: Colors.white,
        indicatorColor: AppColors.teal,
        tabs: const [
          Tab(icon: Icon(Icons.home)),
          Tab(icon: Icon(Icons.account_box)),
        ],
      ),
    );
  }
}
