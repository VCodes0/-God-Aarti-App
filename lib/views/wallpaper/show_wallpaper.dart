import 'package:aarti_app/models/all_god_category_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/wallpaper_post_controlle.dart';
import '../../models/wallpaper_post_model.dart';

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

  @override
  Widget build(BuildContext context) {
    final wpController = context.watch<WallpaperPostController>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("${widget.category.catName}"),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: wpController.allWallPaperPost.length,
        itemBuilder: (context, index) {
          final imageUrl = wpController.allWallPaperPost[index].images;
          return ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              "$imageUrl",
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(child: CircularProgressIndicator());
              },
              errorBuilder: (context, error, stackTrace) {
                return const Center(child: Icon(Icons.error));
              },
            ),
          );
        },
      ),
    );
  }
}
