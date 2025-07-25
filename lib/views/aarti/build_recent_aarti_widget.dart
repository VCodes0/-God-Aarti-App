import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/recently_played_controller.dart';
import '../../main.dart';
import '../music screen/music_screen2.dart';

class BuildRecentAartiWidget extends StatefulWidget {
  const BuildRecentAartiWidget({super.key});

  @override
  State<BuildRecentAartiWidget> createState() => _BuildRecentAartiWidgetState();
}

class _BuildRecentAartiWidgetState extends State<BuildRecentAartiWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: mq.width * .94,
      height: mq.height * .32,
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Recently Played",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: mq.height * .02),
          Expanded(
            child: Builder(
              builder: (context) {
                final controller = context.watch<RecentlyPlayedController>();
                if (controller.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (controller.recentlyPlayed.isEmpty) {
                  return const Center(child: Text("No data found"));
                } else {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemCount: controller.recentlyPlayed.length,
                    itemBuilder: (context, index) {
                      final item = controller.recentlyPlayed[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Column(
                          children: [
                            Container(
                              width: mq.width * .4,
                              height: mq.height * .21,
                              decoration: BoxDecoration(
                                color: Colors.orange.shade200,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(70),
                                  topRight: Radius.circular(70),
                                  bottomLeft: Radius.circular(25),
                                  bottomRight: Radius.circular(25),
                                ),
                                shape: BoxShape.rectangle,
                              ),
                              child: GestureDetector(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MusicScreen2(
                                      item: item,
                                      imageUrl: '${item.withoutBgImage}',
                                      audioUrl: '${item.audio}',
                                    ),
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child:
                                      item.withoutBgImage != null &&
                                          item.withoutBgImage!.isNotEmpty
                                      ? Image.network(
                                          item.withoutBgImage!,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) =>
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
                            const SizedBox(height: 5),
                            SizedBox(
                              width: 100,
                              child: Text(
                                item.title?.toUpperCase() ?? 'No Title',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  letterSpacing: 1,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
