import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DownloadsScreen extends StatelessWidget {
  const DownloadsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Downloads"),
            bottom: const TabBar(
              indicatorColor: CupertinoColors.activeOrange,
              labelColor: CupertinoColors.activeOrange,
              tabs: [
                Tab(child: Text("Aarti")),
                Tab(child: Text("Wallpapers")),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              Center(child: Text("Aarti")),
              Center(child: Text("WallPaper")),
            ],
          ),
        ),
      ),
    );
  }
}
