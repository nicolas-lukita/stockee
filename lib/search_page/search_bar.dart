import 'package:flutter/material.dart';
import 'package:stockee/helpers/app_colors.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key, required this.controller}) : super(key: key);
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.lightCream,
      child: SizedBox(
        width: double.infinity,
        child: TextField(
          controller: controller,
          onChanged: (_) {},
          decoration: const InputDecoration(
            hintText: 'Search..',
            border: InputBorder.none,
            focusedBorder: OutlineInputBorder(
                gapPadding: 10,
                borderSide: BorderSide(
                  color: Colors.black,
                )),
            enabledBorder: OutlineInputBorder(
              gapPadding: 10,
              borderSide: BorderSide(
                color: Colors.black,
              ),
            ),
            prefixIcon: Icon(
              Icons.search,
              size: 24,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
