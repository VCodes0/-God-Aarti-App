import 'package:flutter/material.dart';

import '../../components/tofu/tofu_screen.dart';

class TermsOfUseScreen extends StatelessWidget {
  const TermsOfUseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF5F1),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Terms of Use",
          style: TextStyle(color: Colors.red.shade900),
        ),
      ),
      body: TofuScreen(),
    );
  }
}
