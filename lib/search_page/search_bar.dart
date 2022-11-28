import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      color: const Color(0x54FFFFFF),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: TextField(
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
