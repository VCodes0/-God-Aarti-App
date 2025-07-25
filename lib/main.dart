import 'package:aarti_app/controller/recently_played_controller.dart';
import 'package:aarti_app/controller/trending_aartis_controller.dart';
import 'package:aarti_app/views/get%20started/get_started.dart';
import 'package:aarti_app/views/language/language_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'controller/festival_aarti_list_controller.dart';
import 'controller/fetival_list_controller.dart';
import 'views/splash/splash_screen.dart';

late Size mq;
int? initScreen;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sh = await SharedPreferences.getInstance();
  initScreen = sh.getInt('initScreen');
  await sh.setInt('initScreen', 1);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RecentlyPlayedController()),
        ChangeNotifierProvider(create: (_) => TrendingAartisController()),
        ChangeNotifierProvider(create: (_) => FestivalListController()),
        ChangeNotifierProvider(create: (_) => FestivalAartiListController()),
      ],
      child: const MyApp(),
    ),
  );
}

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
      initialRoute: initScreen == 0 || initScreen == null
          ? 'LanguageScreen'
          : 'GetStartedScreen',
      routes: {
        'LanguageScreen': (context) => const LanguageScreen(),
        'GetStartedScreen': (context) => const GetStartedScreen(),
      },
      home: const SplashScreen(),
    );
  }
}
