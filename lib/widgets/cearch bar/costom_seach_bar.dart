import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  final Function(String)? onChanged;

  const SearchBarWidget({super.key, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.orange.shade200),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: TextField(
        onChanged: onChanged,
        decoration: const InputDecoration(
          icon: Icon(CupertinoIcons.search, color: Colors.orange),
          hintText: 'Search aarti, wallpapers',
          border: InputBorder.none,
        ),
      ),
    );
  }
}
