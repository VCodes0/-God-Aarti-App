import 'package:flutter/material.dart';


class TermsOfUseScreen extends StatefulWidget {
  const TermsOfUseScreen({super.key});

  @override
  State<TermsOfUseScreen> createState() => _TermsOfUseScreenState();
}

class _TermsOfUseScreenState extends State<TermsOfUseScreen> {
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
