import 'package:aarti_app/controller/recent_wallpaper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../main.dart';

class RecentWallpaper extends StatelessWidget {
  const RecentWallpaper({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<RecentWallpaperController>();
    return Container(
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
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child:
                                    item.postImage != null &&
                                        item.postImage!.isNotEmpty
                                    ? Image.network(
                                        item.postImage!,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, _) =>
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
    );
  }
}
