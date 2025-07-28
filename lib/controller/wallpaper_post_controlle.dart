import 'dart:convert';
import 'dart:developer';

import 'package:aarti_app/models/wallpaper_post_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WallpaperPostController extends ChangeNotifier {
  List<WallPaperPost> _allWallPaperPost = [];
  List<WallPaperPost> get allWallPaperPost => _allWallPaperPost;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final dio = Dio();
  late String _id;
  String get url =>
      "https://appy.trycatchtech.com/v3/all_god/all_god_wallpaper_post_list?category_id=$_id";

  void setCategoryId(String id) {
    _id = id;
  }

  Future<void> seeAllWallPapePost() async {
    _isLoading = true;
    try {
      final response = await dio.get(url);

      if (response.statusCode == 200 && response.data != null) {
        List<dynamic> decodeData = jsonDecode(response.data);
        _allWallPaperPost = WallPaperPost.getSingleWallPaper(decodeData);
        notifyListeners();
        SharedPreferences sh = await SharedPreferences.getInstance();
        sh.setString('allWallPaperPost', response.data);
      }
    } catch (e) {
      log('Error fetching allWallPaperPost data: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
