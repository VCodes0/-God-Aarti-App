import 'package:flutter/material.dart';

class CustomNxtButton extends StatelessWidget {
  final String text;
  const CustomNxtButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFA726), Color(0xFFFF7043)],
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      alignment: Alignment.center,
      child: Text(text, style: TextStyle(fontSize: 21, color: Colors.white)),
    );
  }
}
