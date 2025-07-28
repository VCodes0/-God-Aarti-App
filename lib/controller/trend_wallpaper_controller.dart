import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/recent_and_trending_wallpaperr_model.dart';

class TrendWallpaperController extends ChangeNotifier {
  List<RecAndTrendWallpaper> _trendWallPaper = [];
  List<RecAndTrendWallpaper> get trendWallPaper => _trendWallPaper;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final Dio dio = Dio();
  final String url =
      "https://appy.trycatchtech.com/v3/all_god/trending_wallpaper?category_id=1,2";

  Future<void> giveTrendWallpaper() async {
    _isLoading = true;
    try {
      final response = await dio.get(url);

      if (response.statusCode == 200 && response.data != null) {
        List<dynamic> decodeData = jsonDecode(response.data);
        _trendWallPaper = RecAndTrendWallpaper.getRecWallpaper(decodeData);
        _trendWallPaper = List.from(_trendWallPaper);

        SharedPreferences sh = await SharedPreferences.getInstance();
        sh.setString('recentWallPAper', response.data);
      }
    } catch (e) {
      log('Error fetching recently played data: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
