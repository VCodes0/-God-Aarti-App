import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../main.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
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
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.chevron_left, color: Colors.grey),
                  onPressed: () {},
                ),
              ),
              SizedBox(height: mq.height * .05),
              Center(
                child: CircleAvatar(
                  radius: mq.height * .08,
                  backgroundColor: Colors.deepOrange,
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl:
                      'https://assets.ganeshaspeaks.com/wp-content/uploads/2018/03/hanuman-jayanti-2018-600.webp',
                      fit: BoxFit.cover,
                      width: mq.height * .16, // diameter
                      height: mq.height * .16,
                      placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                      const Icon(Icons.error),
                    ),
                  ),
                ),
              ),
              SizedBox(height: mq.height * .05),
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
                  Get.to(() => AartiScreen());
                },
              ),
              buildDrawerItem(
                icon: Icons.wallpaper,
                text: 'Wallpaper',
                onTap: () {
                  Get.to(() => WallpaperScreen());
                },
              ),
              buildDrawerItem(
                icon: Icons.download,
                text: 'Downloads',
                onTap: () {
                  Get.to(() => DownloadsScreen());
                },
              ),
              buildDrawerItem(
                icon: Icons.favorite,
                text: 'Favorites',
                onTap: () {
                  Navigator.pop(context);
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
                  Get.to(() => TofuScreen2());
                },
              ),
              buildDrawerItem(
                icon: Icons.description,
                text: 'Terms of Use',
                onTap: () {
                  Get.to(() => TofuScreen3());
                },
              ),
              buildDrawerItem(
                icon: Icons.language,
                text: 'Language',
                onTap: () {
                  Get.to(() => LangScr());
                },
              ),
            ],
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
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

              // Get Started Card
              Positioned(
                top: mq.height * 0.12,
                left: mq.width * 0.08,
                child: SizedBox(
                  width: mq.width * 0.35,
                  height: mq.height * 0.18,
                  child: SelectionCard(
                    onTap: () => Get.to(() => HomeScreen()),
                    cardIcon: Icons.waving_hand,
                    cardTitle: "Get Started",
                  ),
                ),
              ),

              // Privacy Card
              Positioned(
                top: mq.height * 0.12,
                right: mq.width * 0.08,
                child: SizedBox(
                  width: mq.width * 0.35,
                  height: mq.height * 0.18,
                  child: SelectionCard(
                    onTap: () => Get.to(() => ShareScreen()),
                    cardIcon: Icons.privacy_tip,
                    cardTitle: "Privacy",
                  ),
                ),
              ),

              // Share Card
              Positioned(
                top: mq.height * 0.32,
                left: mq.width * 0.08,
                child: SizedBox(
                  width: mq.width * 0.35,
                  height: mq.height * 0.18,
                  child: SelectionCard(
                    onTap: () => Get.to(() => ShareScreen()),
                    cardIcon: Icons.share,
                    cardTitle: "Share",
                  ),
                ),
              ),

              // Rate Us Card
              Positioned(
                top: mq.height * 0.32,
                right: mq.width * 0.08,
                child: SizedBox(
                  width: mq.width * 0.35,
                  height: mq.height * 0.18,
                  child: SelectionCard(
                    onTap: () => Get.to(() => RateUsScreen()),
                    cardIcon: Icons.star,
                    cardTitle: "Rate Us",
                  ),
                ),
              ),

              // Bottom Image
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
                      child: Image.network(
                        "https://placehold.co/600x400/F9F0E1/000000?text=Bottom+Image",
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[300],
                            child: const Center(
                              child: Text('Bottom Image Placeholder'),
                            ),
                          );
                        },
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
