import 'package:flutter/material.dart';

Widget buildImageCard({
  required String assetPath,
  required VoidCallback onTap,
  double size = 182,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Image.asset(
      assetPath,
      width: size,
      height: size,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) =>
      const Icon(Icons.broken_image, size: 60),
    ),
  );
}
