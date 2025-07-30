import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/trend_wallpaper_controller.dart';
import '../../main.dart';

class TrendWallPaper extends StatelessWidget {
  const TrendWallPaper({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<TrendWallpaperController>();
    return Container(
      width: mq.width * .94,
      height: mq.height * .32,
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Text("Popular", style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: mq.height * .02),
          Expanded(
            child: controller.isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: controller.trendWallPaper.length,
                    itemBuilder: (context, i) {
                      final item = controller.trendWallPaper[i];
                      return Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Column(
                          children: [
                            InkWell(
                              child: Container(
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
