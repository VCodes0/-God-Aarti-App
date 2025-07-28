import 'package:aarti_app/controller/fetival_list_controller.dart';
import 'package:aarti_app/controller/recently_played_controller.dart';
import 'package:aarti_app/controller/trending_aartis_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../main.dart';
import '../../widgets/cearch bar/costom_seach_bar.dart';
import 'build_festival_aarti.dart';
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
    context.read<TrendingAartisController>().getTrndingAartisData();
    context.read<FestivalListController>().getFestivalAartiData();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SearchBarWidget(
                    onChanged: (query) {
                      context.read<RecentlyPlayedController>().searchAarti(
                        query,
                      );
                      context
                          .read<TrendingAartisController>()
                          .searchTrndingAarti(query);
                      context.read<FestivalListController>().searchFestival(
                        query,
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  const BuildRecentAartiWidget(),
                  const BuildTrendingAartiWidget(),
                  const BuildFestivalAarti(),
                  SizedBox(height: mq.height * .04),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
