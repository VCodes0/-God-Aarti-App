import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../main.dart';
import '../language/language_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 4), () => Get.offAll(() => LanguageScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.black,
      body: Stack(
        children: [
          SizedBox(
            width: mq.width,
            height: mq.height,
            child: Image.asset("assets/splash_main.png", fit: BoxFit.cover),
          ),
          Positioned(
            bottom: 0,
            child: SizedBox(
              width: mq.width,
              height: mq.height,
              child: Image.asset("assets/splash_bottom.png", fit: BoxFit.cover),
            ),
          ),
          Positioned(
            top: mq.height * .1,
            left: mq.width * .4,
            child: Center(
              child: SizedBox(
                child: Image.asset("assets/splash_top.png", fit: BoxFit.cover),
              ),
            ),
          ),
          Center(
            child: CircleAvatar(
              radius: mq.height * .08,
              backgroundColor: Colors.deepOrange,
              child: ClipOval(
                child: Image.asset(
                  "assets/applogo.png",
                  fit: BoxFit.cover,
                  width: mq.height * .16,
                  height: mq.height * .16,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: mq.height * .1,
            left: mq.width * .35,
            child: Center(
              child: SizedBox(
                child: Image.asset("assets/gada.png", fit: BoxFit.cover),
              ),
            ),
          ),
          Positioned(
            bottom: mq.height * .38,
            left: mq.width * .34,
            child: Center(
              child: SizedBox(
                child: Text(
                  "Aarti SanGraha",
                  style: TextStyle(
                    color: CupertinoColors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
