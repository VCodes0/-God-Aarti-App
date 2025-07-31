import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:saver_gallery/saver_gallery.dart';

import '../../main.dart';
import '../../models/all_god_category_model.dart';
import '../../models/wallpaper_post_model.dart';
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
          category.catName ?? '',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.black,
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
                  onTap: () async {
                    final hasPermission = await checkAndRequestPermissions(
                      skipIfExists: false,
                    );

                    if (!hasPermission) {
                      Get.snackbar(
                        'Permission Denied',
                        'Storage permission is required to save image.',
                      );
                      return;
                    }

                    try {
                      final response = await Dio().get(
                        imageUrl,
                        options: Options(responseType: ResponseType.bytes),
                      );

                      String imageName =
                          '${category.catName ?? 'God'}_${DateTime.now().millisecondsSinceEpoch}.jpg';

                      final result = await SaverGallery.saveImage(
                        Uint8List.fromList(response.data),
                        quality: 80,
                        androidRelativePath:
                            "Pictures/GodWallpapers/${category.catName ?? 'God'}",
                        skipIfExists: false,
                        fileName: imageName,
                      );

                      if (result.isSuccess == true) {
                        Get.snackbar(
                          'Success',
                          'Image saved successfully to gallery.',
                          backgroundColor: CupertinoColors.activeGreen,
                          colorText: CupertinoColors.white,
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      } else {
                        Get.snackbar('Error', 'Failed to save image.');
                      }
                    } catch (e) {
                      Get.snackbar(
                        'Error',
                        'Something went wrong while saving the image.',
                      );
                      debugPrint('Save Error: $e');
                    }
                  },
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

Future<bool> checkAndRequestPermissions({required bool skipIfExists}) async {
  if (!Platform.isAndroid && !Platform.isIOS) {
    return false;
  }

  if (Platform.isAndroid) {
    final deviceInfo = await DeviceInfoPlugin().androidInfo;
    final sdkInt = deviceInfo.version.sdkInt;

    if (skipIfExists) {
      return sdkInt >= 33
          ? await Permission.photos.request().isGranted
          : await Permission.storage.request().isGranted;
    } else {
      return sdkInt >= 29 ? true : await Permission.storage.request().isGranted;
    }
  } else if (Platform.isIOS) {
    return skipIfExists
        ? await Permission.photos.request().isGranted
        : await Permission.photosAddOnly.request().isGranted;
  }

  return false;
}
