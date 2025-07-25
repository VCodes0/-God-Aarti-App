import 'package:aarti_app/controller/festival_aarti_list_controller.dart';
import 'package:aarti_app/controller/recently_played_controller.dart';
import 'package:aarti_app/views/music%20screen/festival_music.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../controller/fetival_list_controller.dart';
import '../../models/festival_model.dart';

class ShowFestivalAartis extends StatefulWidget {
  final Data data;
  const ShowFestivalAartis({super.key, required this.data});

  @override
  State<ShowFestivalAartis> createState() => _ShowFestivalAartisState();
}

class _ShowFestivalAartisState extends State<ShowFestivalAartis> {
  late FestivalAartiListController _data;
  @override
  void initState() {
    super.initState();
    _data = FestivalAartiListController();
    _data.setCategoryId("${widget.data.id}");
    context.read<FestivalListController>().getFestivalAartiData();
  }

  Future<void> shareAarti(String title) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    // ignore: deprecated_member_use
    final result = await Share.share(
      'Listen to this Aarti: $title',
      subject: 'Share Aarti',
    );

    if (result.status == ShareResultStatus.success) {
      scaffoldMessenger.showSnackBar(
        const SnackBar(content: Text("Aarti shared successfully")),
      );
    } else if (result.status == ShareResultStatus.dismissed) {
      scaffoldMessenger.showSnackBar(
        const SnackBar(content: Text("Aarti sharing cancelled")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FestivalAartiListController>.value(
      value: _data,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("${widget.data.name}"),
        ),
        body: Consumer<RecentlyPlayedController>(
          builder: (context, provider, _) {
            final recentlyPlayed = provider.recentlyPlayed;

            if (recentlyPlayed.isEmpty) {
              return const Center(child: Text("No aarti found."));
            }

            return Padding(
              padding: const EdgeInsets.all(8),
              child: ListView.builder(
                itemCount: recentlyPlayed.length,
                itemBuilder: (context, index) {
                  final item = recentlyPlayed[index];
                  return InkWell(
                    onTap: () {
                      Get.to(
                        () => MusicScreen3(
                          data: Data(),
                          imageUrl: "${item.mainImage}",
                          audioUrl: "${item.audio}",
                        ),
                      );
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          item.withoutBgImage ?? '',
                        ),
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
                            onPressed: () {},
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
      ),
    );
  }
}
