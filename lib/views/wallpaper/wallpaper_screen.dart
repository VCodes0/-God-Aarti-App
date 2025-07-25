import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';

import '../../../main.dart';
import '../../controller/all_god_catefory_controller.dart';
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
  }

  @override
  Widget build(BuildContext context) {
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
                  Provider.of<AllGodCateforyController>(
                    context,
                    listen: false,
                  ).filterGodCategories(query);
                },
              ),
              SizedBox(height: mq.height * .02),
              Consumer<AllGodCateforyController>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return SizedBox(
                      height: mq.height * .15,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: provider.godCategories.length,
                        itemBuilder: (context, index) {
                          final category = provider.godCategories[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            child: Column(
                              children: [
                                CircleAvatar(
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
                    );
                  }
                },
              ),

              SizedBox(height: mq.height * .025),
            ],
          ),
        ),
      ),
    );
  }
}
