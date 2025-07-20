import 'package:flutter/material.dart';

Widget buildPermissionTile(
  Size screen, {
  required String iconPath,
  required String title,
  required String subtitle,
  required bool value,
  required Function(bool) onChanged,
}) {
  return Container(
    padding: EdgeInsets.all(screen.width * 0.04),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: Colors.deepOrangeAccent, width: 1),
      color: Colors.white,
    ),
    child: Row(
      children: [
        Expanded(
          flex: 1,
          child: Image.asset(
            iconPath,
            width: screen.width * 0.08,
            height: screen.width * 0.1,
          ),
        ),
        SizedBox(width: screen.width * 0.04),
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: screen.width * 0.042,
                ),
              ),
              SizedBox(height: screen.height * 0.005),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: screen.width * 0.034,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: Colors.orange,
          inactiveThumbColor: Colors.grey,
        ),
      ],
    ),
  );
}
