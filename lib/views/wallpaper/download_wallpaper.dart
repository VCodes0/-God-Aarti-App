import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:aarti_app/models/all_god_category_model.dart';
import 'package:aarti_app/models/wallpaper_post_model.dart';

import '../../main.dart';
import '../../widgets/bottom_action_widget/bottom_action_widget.dart';

class DownloadWallpaper extends StatelessWidget {
  final GodData category;
  final WallPaperPost wallPaperPost;

  const DownloadWallpaper({
    super.key,
    required this.category,
    required this.wallPaperPost,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl = wallPaperPost.images ?? '';

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "${category.catName}",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          SizedBox(
            width: mq.width,
            height: mq.height,
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) =>
                  const Icon(Icons.broken_image, size: 50, color: Colors.white),
            ),
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BottomActionButton(
                  icon: Icons.download,
                  label: 'Save',
                  onTap: () {},
                ),
                BottomActionButton(
                  icon: Icons.wallpaper,
                  label: 'Apply',
                  onTap: () {},
                ),
                BottomActionButton(
                  icon: Icons.favorite,
                  label: 'Favorite',
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
