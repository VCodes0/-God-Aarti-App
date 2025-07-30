import 'package:flutter/material.dart';

Widget buildOption(String imagePath, String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      children: [
        Image.asset(imagePath, width: 24, height: 24),
        const SizedBox(width: 10),
        Text(text, style: const TextStyle(fontSize: 16)),
      ],
    ),
  );
}
