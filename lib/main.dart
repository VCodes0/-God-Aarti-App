import 'package:shared_preferences/shared_preferences.dart';
import 'controller/festival_aarti_list_controller.dart';
import 'controller/all_god_catefory_controller.dart';
import 'controller/trending_aartis_controller.dart';
import 'controller/recently_played_controller.dart';
import 'controller/wallpaper_post_controlle.dart';
import 'controller/fetival_list_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'views/language/language_screen.dart';
import 'views/get started/get_started.dart';
import 'views/splash/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

late Size mq;
int? initScreen;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen = prefs.getInt('initScreen');
  await prefs.setInt('initScreen', 1);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FestivalAartiListController()),
        ChangeNotifierProvider(create: (_) => RecentlyPlayedController()),
        ChangeNotifierProvider(create: (_) => AllGodCateforyController()),
        ChangeNotifierProvider(create: (_) => TrendingAartisController()),
        ChangeNotifierProvider(create: (_) => WallpaperPostController()),
        ChangeNotifierProvider(create: (_) => FestivalListController()),
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
      title: 'Aarti App',
      theme: ThemeData(
        scaffoldBackgroundColor: CupertinoColors.white,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: Colors.transparent,
        ),
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
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
