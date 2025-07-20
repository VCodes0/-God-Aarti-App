import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../third/third_onboard.dart';

class OnboardSecond extends StatelessWidget {
  const OnboardSecond({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow.shade100,
      body: Center(
        child: GestureDetector(
          onTap: () => Get.to(() => OnboardThird()),
          child: Image.asset(
            'assets/onboard2.png',
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
      ),
    );
  }
}
