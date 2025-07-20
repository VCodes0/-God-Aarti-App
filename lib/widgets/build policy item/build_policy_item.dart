import 'package:flutter/material.dart';

Widget buildPolicyItem(Size mq, String imagePath, String text) {
  return Padding(
    padding: EdgeInsets.only(bottom: mq.height * 0.025),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Image.asset(
            imagePath,
            width: mq.width * 0.06,
            height: mq.width * 0.06,
            fit: BoxFit.contain,
          ),
        ),
        SizedBox(width: mq.width * 0.03),
        Expanded(
          flex: 9,
          child: Text(
            text,
            style: TextStyle(
              fontSize: mq.width * 0.038,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    ),
  );
}
