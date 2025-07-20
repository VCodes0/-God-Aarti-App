import 'package:flutter/material.dart';

Widget buildDrawerItem({
  required IconData icon,
  required String text,
  required GestureTapCallback onTap,
}) {
  return ListTile(
    leading: Icon(icon, color: Colors.deepOrange),
    title: Text(
      text,
      style: const TextStyle(color: Colors.black87, fontSize: 15),
    ),
    onTap: onTap,
    visualDensity: VisualDensity.compact,
  );
}
