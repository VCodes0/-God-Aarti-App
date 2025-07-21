import 'package:aarti_app/controller/recently_played_controller.dart';
import 'package:aarti_app/views/music%20screen/music_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../../main.dart';
import '../../widgets/cearch bar/costom_seach_bar.dart';

class AartiScreen extends StatefulWidget {
  const AartiScreen({super.key});

  @override
  State<AartiScreen> createState() => _AartiState();
}

class _AartiState extends State<AartiScreen> {
  @override
  void initState() {
    super.initState();
    context.read<RecentlyPlayedController>().getRecentlyPlayedData();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Aarti"),
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(CupertinoIcons.back),
          ),
        ),
        body: SafeArea(
          child: SizedBox(
            height: mq.height,
            width: mq.width,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  SearchBarWidget(
                    onChanged: (query) {
                      context.read<RecentlyPlayedController>().searchAarti(
                        query,
                      );
                    },
                  ),
                  Container(
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
                              final controller = context
                                  .watch<RecentlyPlayedController>();
                              if (controller.isLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (controller.recentlyPlayed.isEmpty) {
                                return const Center(
                                  child: Text("No data found"),
                                );
                              } else {
                                return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: controller.recentlyPlayed.length,
                                  itemBuilder: (context, index) {
                                    final item =
                                        controller.recentlyPlayed[index];
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                        right: 10.0,
                                      ),
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
                                                bottomRight: Radius.circular(
                                                  25,
                                                ),
                                              ),
                                              shape: BoxShape.rectangle,
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child:
                                                  item.withoutBgImage != null &&
                                                      item
                                                          .withoutBgImage!
                                                          .isNotEmpty
                                                  ? Image.network(
                                                      item.withoutBgImage!,
                                                      fit: BoxFit.cover,
                                                      errorBuilder:
                                                          (
                                                            context,
                                                            error,
                                                            stackTrace,
                                                          ) => const Icon(
                                                            Icons.broken_image,
                                                            size: 50,
                                                            color: Colors.grey,
                                                          ),
                                                    )
                                                  : const Center(
                                                      child: Icon(
                                                        Icons
                                                            .image_not_supported,
                                                        size: 40,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          SizedBox(
                                            width: 100,
                                            child: Text(
                                              item.title?.toUpperCase() ??
                                                  'No Title',
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
                  ),
                  Container(
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
                          child: Consumer<RecentlyPlayedController>(
                            builder: (context, controller, child) {
                              if (controller.isLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (controller.recentlyPlayed.isEmpty) {
                                return const Center(
                                  child: Text("No data found"),
                                );
                              } else {
                                return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: controller.recentlyPlayed.length,
                                  itemBuilder: (context, index) {
                                    final item =
                                        controller.recentlyPlayed[index];
                                    return Padding(
                                      padding: EdgeInsets.only(right: 10.0),
                                      child: Column(
                                        children: [
                                          Container(
                                            width: mq.width * .45,
                                            height: mq.height * .21,
                                            decoration: BoxDecoration(
                                              color: Colors.orange.shade200,
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              shape: BoxShape.rectangle,
                                            ),
                                            child: GestureDetector(
                                              onTap: () => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      MusicScreen(
                                                        id: "${item.id}",
                                                      ),
                                                ),
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                child:
                                                    item.bgImage != null &&
                                                        item.bgImage!.isNotEmpty
                                                    ? Image.network(
                                                        item.bgImage!,
                                                        fit: BoxFit.cover,
                                                        errorBuilder:
                                                            (
                                                              context,
                                                              error,
                                                              stackTrace,
                                                            ) => const Icon(
                                                              Icons
                                                                  .broken_image,
                                                              size: 50,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                      )
                                                    : const Center(
                                                        child: Icon(
                                                          Icons
                                                              .image_not_supported,
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
