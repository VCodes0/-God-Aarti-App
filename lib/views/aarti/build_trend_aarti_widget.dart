import 'package:aarti_app/controller/trending_aartis_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import '../music screen/music_screen.dart';

class BuildTrendingAartiWidget extends StatefulWidget {
  const BuildTrendingAartiWidget({super.key});

  @override
  State<BuildTrendingAartiWidget> createState() => _BuildTrendingAartiWidgetState();
}

class _BuildTrendingAartiWidgetState extends State<BuildTrendingAartiWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: mq.width * .94,
      height: mq.height * .32,
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                "Trending Aarti’s",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: mq.height * .02),
          Expanded(
            child: Consumer<TrendingAartisController>(
              builder: (context, controller, child) {
                if (controller.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (controller.trendingAartis.isEmpty) {
                  return const Center(child: Text("No data found"));
                } else {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemCount: controller.trendingAartis.length,
                    itemBuilder: (context, index) {
                      final item = controller.trendingAartis[index];
                      return Padding(
                        padding: EdgeInsets.only(right: 10.0),
                        child: Column(
                          children: [
                            Container(
                              width: mq.width * .45,
                              height: mq.height * .21,
                              decoration: BoxDecoration(
                                color: Colors.orange.shade200,
                                borderRadius: BorderRadius.circular(15),
                                shape: BoxShape.rectangle,
                              ),
                              child: GestureDetector(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MusicScreen(
                                      item: item,
                                      imageUrl: "${item.mainImage}",
                                      audioUrl: "${item.audio}",
                                    ),
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child:
                                      item.bgImage != null &&
                                          item.bgImage!.isNotEmpty
                                      ? Image.network(
                                          item.bgImage!,
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
                                item.title ?? 'No Title',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
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
