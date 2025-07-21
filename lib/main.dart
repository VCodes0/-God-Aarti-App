import 'package:aarti_app/controller/recently_played_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'views/splash/splash_screen.dart';

late Size mq;
void main() => runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => RecentlyPlayedController()),
    ],
    child: const MyApp(),
  ),
);

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
