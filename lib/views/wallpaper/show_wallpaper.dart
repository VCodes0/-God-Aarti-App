import 'package:aarti_app/views/wallpaper/download_wallpaper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../controller/wallpaper_post_controlle.dart';
import '../../main.dart';
import '../../models/wallpaper_post_model.dart';
import 'package:aarti_app/models/all_god_category_model.dart';

class ShowWallpaper extends StatefulWidget {
  final GodData category;
  final WallPaperPost wallPaperPost;

  const ShowWallpaper({
    super.key,
    required this.wallPaperPost,
    required this.category,
  });

  @override
  State<ShowWallpaper> createState() => _ShowWallpaperState();
}

class _ShowWallpaperState extends State<ShowWallpaper> {
  late WallpaperPostController wpController;

  @override
  void initState() {
    super.initState();
    wpController = context.read<WallpaperPostController>();
    wpController.setCategoryId("${widget.category.id}");
    wpController.seeAllWallPapePost();
  }

  bool isValidUrl(String url) {
    final uri = Uri.tryParse(url);
    return uri != null &&
        uri.hasAbsolutePath &&
        (uri.isScheme("http") || uri.isScheme("https"));
  }

  @override
  Widget build(BuildContext context) {
    final wpController = context.watch<WallpaperPostController>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(widget.category.catName ?? "God Title"),
      ),
      bottomNavigationBar: SizedBox(
        width: mq.width,
        child: Image.asset("assets/bottomimg.png"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: MasonryGridView.builder(
          itemCount: wpController.allWallPaperPost.length,
          gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          itemBuilder: (context, index) {
            final selectedWallpaper = wpController.allWallPaperPost[index];
            String imageUrl = selectedWallpaper.images ?? '';

            if (!isValidUrl(imageUrl)) {
              imageUrl = 'https://example.com/default-image.png';
            }

            return InkWell(
              onTap: () {
                Get.to(
                  () => DownloadWallpaper(
                    category: widget.category,
                    wallPaperPost: selectedWallpaper,
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.broken_image,
                    size: 50,
                    color: Colors.grey,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
