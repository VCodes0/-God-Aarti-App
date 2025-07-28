import 'package:aarti_app/views/rate%20us/rate_us_screen.dart';
import 'package:aarti_app/views/share/share_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../components/build image card/build_image_card.dart';
import '../../components/lang 2/lang_scr.dart';
import '../../components/tofu2/tofu2.dart';
import '../../components/tofu3/tofu3.dart';
import '../../main.dart';
import '../../widgets/build drawer item/build_drawer_item.dart';
import '../aarti/aarti_screen.dart';
import '../downloads/downloads_screen.dart';
import '../home/home_screen.dart';
import '../wallpaper/wallpaper_screen.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("God Aarti"),
          backgroundColor: const Color(0xFFF9F0E1),
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        drawer: Drawer(
          backgroundColor: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              SizedBox(height: mq.height * .07),
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
              SizedBox(height: mq.height * .03),
              Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  top: 20.0,
                  bottom: 8.0,
                ),
                child: Text(
                  'Main Feature',
                  style: TextStyle(
                    color: Colors.deepOrange.shade700,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              buildDrawerItem(
                icon: Icons.self_improvement,
                text: 'Aarti',
                onTap: () {
                  Get.back();
                  Get.to(() => AartiScreen());
                },
              ),
              buildDrawerItem(
                icon: Icons.wallpaper,
                text: 'Wallpaper',
                onTap: () {
                  Get.back();
                  Get.to(() => WallpaperScreen());
                },
              ),
              buildDrawerItem(
                icon: Icons.download,
                text: 'Downloads',
                onTap: () {
                  Get.back();
                  Get.to(() => DownloadsScreen());
                },
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  top: 20.0,
                  bottom: 8.0,
                ),
                child: Text(
                  'Settings',
                  style: TextStyle(
                    color: Colors.deepOrange.shade700,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              buildDrawerItem(
                icon: Icons.privacy_tip,
                text: 'Privacy Policy',
                onTap: () {
                  Get.back();
                  Get.to(() => TofuScreen2());
                },
              ),
              buildDrawerItem(
                icon: Icons.description,
                text: 'Terms of Use',
                onTap: () {
                  Get.back();
                  Get.to(() => TofuScreen3());
                },
              ),
              buildDrawerItem(
                icon: Icons.language,
                text: 'Language',
                onTap: () {
                  Get.back();
                  Get.to(() => LangScr());
                },
              ),
            ],
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            color: Colors.red,
            gradient: LinearGradient(
              colors: [Color(0xFFF9F0E1), Color(0xFFFCECDD)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                left: mq.width * 0.08,
                top: mq.height * 0.02,
                child: const Text(
                  'नमस्कार,',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange,
                  ),
                ),
              ),
              Positioned(
                top: mq.height * 0.075,
                left: mq.width * 0.02,
                child: buildImageCard(
                  assetPath: 'assets/start.png',
                  onTap: () {
                    Get.back();
                    Get.to(() => HomeScreen());
                  },
                ),
              ),
              Positioned(
                top: mq.height * 0.10,
                right: mq.width * 0.05,
                child: buildImageCard(
                  assetPath: 'assets/privacy.png',
                  onTap: () {
                    Get.back();
                    Get.to(() => TofuScreen2());
                  },
                ),
              ),
              Positioned(
                top: mq.height * 0.32,
                left: mq.width * 0.02,
                child: buildImageCard(
                  assetPath: 'assets/share.png',
                  onTap: () {
                    Get.back();
                    Get.to(() => ShareScreen());
                  },
                ),
              ),
              Positioned(
                top: mq.height * 0.35,
                right: mq.width * 0.05,
                child: buildImageCard(
                  assetPath: 'assets/rate.png',
                  onTap: () {
                    Get.back();
                    Get.to(() => RateUsScreen());
                  },
                ),
              ),
              Positioned(
                bottom: mq.height * 0.02,
                left: 0,
                right: 0,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(mq.height * 0.03),
                    child: SizedBox(
                      width: double.infinity,
                      height: mq.height * 0.24,
                      child: Image.asset(
                        "assets/bottom.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
