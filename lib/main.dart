import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'views/splash/splash_screen.dart';

late Size mq;
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: CupertinoColors.white,
        appBarTheme: AppBarTheme(
          centerTitle: true,
          backgroundColor: CupertinoColors.transparent,
        ),
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      title: 'Aarti App',
      home: const SplashScreen(),
    );
  }
}
