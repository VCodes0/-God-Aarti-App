import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../controller/festival_aarti_list_controller.dart';
import '../../main.dart';
import '../../models/festival_model.dart';
import '../music screen/festival_music.dart';

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
        title: Text(widget.data.name ?? 'Festival Artis'),
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
                                  child: Material(
                                    // <-- This is the fix!
                                    color: Colors.white,
                                    child: Container(
                                      padding: const EdgeInsets.all(20),
                                      width: 300,
                                      child: SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Get.to(
                                                  () => MusicScreen3(
                                                    data: Data(),
                                                    imageUrl:
                                                        item.mainImage ?? '',
                                                    audioUrl: item.audio ?? '',
                                                  ),
                                                );
                                              },
                                              child: _buildOption(
                                                "assets/play_aarti.png",
                                                "Play Aarti",
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {},
                                              child: _buildOption(
                                                "assets/download.png",
                                                "Download",
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {},
                                              child: _buildOption(
                                                "assets/ringtone.png",
                                                "Set as ringtone",
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {},
                                              child: _buildOption(
                                                "assets/add_quee.png",
                                                "Add to queue",
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () => shareAarti(
                                                item.title ?? 'Untitled Aarti',
                                              ),
                                              child: _buildOption(
                                                "assets/share2.png",
                                                "Share",
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {},
                                              child: _buildOption(
                                                "assets/delete.png",
                                                "Delete",
                                              ),
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

  Widget _buildOption(String imagePath, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: InkWell(
        child: Row(
          children: [
            Image.asset(imagePath, width: 24, height: 24),
            const SizedBox(width: 10),
            Text(text, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
