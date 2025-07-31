import 'package:aarti_app/controller/recent_wallpaper.dart';
import 'package:aarti_app/controller/trend_wallpaper_controller.dart';
import 'package:aarti_app/views/wallpaper/show_wallpaper.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../main.dart';
import '../../controller/all_god_catefory_controller.dart';
import '../../models/wallpaper_post_model.dart';
import '../../widgets/cearch bar/costom_seach_bar.dart';

class WallpaperScreen extends StatefulWidget {
  const WallpaperScreen({super.key});

  @override
  State<WallpaperScreen> createState() => _WallpaperScreenState();
}

class _WallpaperScreenState extends State<WallpaperScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AllGodCateforyController>().fetchGodCategories();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RecentWallpaperController>().giveRecentWallPaper();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TrendWallpaperController>().giveTrendWallpaper();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AllGodCateforyController>();
    final controller = context.watch<RecentWallpaperController>();
    final controller2 = context.watch<TrendWallpaperController>();

    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        appBar: AppBar(title: const Text("Wallpaper")),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: mq.height * .02),
              SearchBarWidget(
                onChanged: (query) {
                  context.read<AllGodCateforyController>().filterGodCategories(
                    query,
                  );
                },
              ),
              SizedBox(height: mq.height * .02),
              if (provider.isLoading)
                const Center(child: CircularProgressIndicator())
              else
                SizedBox(
                  height: mq.height * .15,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: provider.godCategories.length,
                    itemBuilder: (context, index) {
                      final category = provider.godCategories[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () => Get.to(
                                ShowWallpaper(
                                  wallPaperPost: WallPaperPost(),
                                  category: category,
                                ),
                              ),
                              child: CircleAvatar(
                                radius: 45,
                                backgroundImage: category.catImage != null
                                    ? CachedNetworkImageProvider(
                                        category.catImage!,
                                      )
                                    : null,
                                child: category.catImage == null
                                    ? const Icon(Icons.image_not_supported)
                                    : null,
                              ),
                            ),
                            const SizedBox(height: 4),
                            SizedBox(
                              width: 80,
                              child: Text(
                                category.catName ?? '',
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 12),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              SizedBox(height: mq.height * .025),
              Container(
                width: mq.width * .94,
                height: mq.height * .32,
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text(
                          "Recently Used ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: mq.height * .02),
                    Expanded(
                      child: controller.isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : ListView.builder(
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              itemCount: controller.recentWallPaper.length,
                              itemBuilder: (context, i) {
                                final item = controller.recentWallPaper[i];
                                return Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: mq.width * .47,
                                        height: mq.height * .26,
                                        decoration: BoxDecoration(
                                          color: Colors.orange.shade200,
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
                                          child:
                                              item.postImage != null &&
                                                  item.postImage!.isNotEmpty
                                              ? Image.network(
                                                  item.postImage!,
                                                  fit: BoxFit.cover,
                                                  errorBuilder:
                                                      (context, error, _) =>
                                                          const Icon(
                                                            Icons.broken_image,
                                                            size: 50,
                                                            color: Colors.grey,
                                                          ),
                                                )
                                              : const Center(
                                                  child: Icon(
                                                    Icons.image_not_supported,
                                                    size: 40,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: mq.height * .025),
              Container(
                width: mq.width * .94,
                height: mq.height * .32,
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text(
                          "Popular",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: mq.height * .02),
                    Expanded(
                      child: controller2.isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : ListView.builder(
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              itemCount: controller2.trendWallPaper.length,
                              itemBuilder: (context, i) {
                                final item = controller2.trendWallPaper[i];
                                return Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: mq.width * .47,
                                        height: mq.height * .26,
                                        decoration: BoxDecoration(
                                          color: Colors.orange.shade200,
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
                                          child:
                                              item.postImage != null &&
                                                  item.postImage!.isNotEmpty
                                              ? Image.network(
                                                  item.postImage!,
                                                  fit: BoxFit.cover,
                                                  errorBuilder:
                                                      (context, error, _) =>
                                                          const Icon(
                                                            Icons.broken_image,
                                                            size: 50,
                                                            color: Colors.grey,
                                                          ),
                                                )
                                              : const Center(
                                                  child: Icon(
                                                    Icons.image_not_supported,
                                                    size: 40,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: mq.height * .075),
            ],
          ),
        ),
      ),
    );
  }
}
