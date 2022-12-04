import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key, required this.controller}) : super(key: key);
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: const Color(0x54FFFFFF),
      child: Container(
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
