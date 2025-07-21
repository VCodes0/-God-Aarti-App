import 'package:aarti_app/controller/recently_played_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../../main.dart';
import '../../widgets/cearch bar/costom_seach_bar.dart';
import 'build_recent_aarti_widget.dart';
import 'build_trend_aarti_widget.dart';

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
                  BuildRecentAartiWidget(),
                  BuildTrendingAartiWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
