import 'package:aarti_app/controller/festival_aarti_list_controller.dart';
import 'package:aarti_app/views/music%20screen/festival_music.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../main.dart';
import '../../models/festival_model.dart';
import '../../widgets/build options/build_options.dart';

class ShowFestivalAartis extends StatefulWidget {
  final Data data;
  const ShowFestivalAartis({super.key, required this.data});

  @override
  State<ShowFestivalAartis> createState() => _ShowFestivalAartisState();
}

class _ShowFestivalAartisState extends State<ShowFestivalAartis> {
  @override
  void initState() {
    super.initState();
    final festivalController = context.read<FestivalAartiListController>();
    festivalController.setCategoryId("${widget.data.id}");
    festivalController.getFestivalAartiList();
  }

  Future<void> shareAarti(String title) async {
    // ignore: deprecated_member_use
    await Share.share('Listen to this Aarti: $title', subject: 'Share Aarti');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(widget.data.name ?? 'Festival Aartis'),
      ),
      bottomNavigationBar: SizedBox(
        width: mq.width,
        child: Image.asset("assets/bottomimg.png"),
      ),
      body: Consumer<FestivalAartiListController>(
        builder: (context, controller, _) {
          final aartiList = controller.festivalAartiList;

          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (aartiList.isEmpty) {
            return const Center(child: Text("No Aarti found."));
          }

          return Padding(
            padding: const EdgeInsets.all(8),
            child: ListView.builder(
              itemCount: aartiList.length,
              itemBuilder: (context, index) {
                final item = aartiList[index];
                return InkWell(
                  onTap: () {
                    Get.to(
                      () => MusicScreen3(
                        data: Data(),
                        imageUrl: item.mainImage ?? '',
                        audioUrl: item.audio ?? '',
                      ),
                    );
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(item.withoutBgImage ?? ''),
                    ),
                    title: Text(item.title ?? 'Untitled Aarti'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            shareAarti(item.title ?? 'Untitled Aarti');
                          },
                          icon: const Icon(Icons.share),
                        ),
                        IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => Center(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    padding: const EdgeInsets.all(20),
                                    width: 300,
                                    color: Colors.white,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        buildOption(
                                          "assets/play.png",
                                          "Play next",
                                        ),
                                        buildOption(
                                          "assets/download.png",
                                          "Download",
                                        ),
                                        buildOption(
                                          "assets/ringtone.png",
                                          "Set as ringtone",
                                        ),
                                        buildOption(
                                          "assets/queue.png",
                                          "Add to queue",
                                        ),
                                        buildOption(
                                          "assets/share.png",
                                          "Share",
                                        ),
                                        buildOption(
                                          "assets/delete.png",
                                          "Delete",
                                        ),
                                        const SizedBox(height: 10),
                                        IconButton(
                                          icon: const Icon(Icons.close),
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.more_vert),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
