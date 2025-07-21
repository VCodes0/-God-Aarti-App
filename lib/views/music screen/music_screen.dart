import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/recently_played_controller.dart';

class MusicScreen extends StatefulWidget {
  final String id;
  const MusicScreen({super.key, required this.id});

  @override
  State<MusicScreen> createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> {
  late RecentlyPlayedController _rplayProvider;
  @override
  void initState() {
    super.initState();
    _rplayProvider = RecentlyPlayedController();
    context.read<RecentlyPlayedController>().getRecentlyPlayedData();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RecentlyPlayedController>.value(
      value: _rplayProvider,
      child: Scaffold(appBar: AppBar(title: Text(""))),
    );
  }
}
