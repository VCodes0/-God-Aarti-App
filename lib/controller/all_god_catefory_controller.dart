import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/all_god_category_model.dart';

class AllGodCateforyController extends ChangeNotifier {
  final dio = Dio();
  final String url =
      "https://appy.trycatchtech.com/v3/all_god/all_god_wallpaper_category_list";

  List<GodData> _originalGodCategories = [];
  List<GodData> _godCategories = [];
  List<GodData> get godCategories => _godCategories;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchGodCategories() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await dio.get(url);

      if (response.statusCode == 200 && response.data != null) {
        final Map<String, dynamic> decoded = response.data is String
            ? jsonDecode(response.data)
            : response.data;

        if (decoded['data'] != null && decoded['data'] is List) {
          _originalGodCategories = GodData.getGodData(decoded['data']);
          _godCategories = List.from(_originalGodCategories);

          SharedPreferences sh = await SharedPreferences.getInstance();
          sh.setString('godCategories', jsonEncode(decoded['data']));
        }
      }
    } catch (e) {
      log('Error fetching god categories: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void filterGodCategories(String query) {
    if (query.isEmpty) {
      _godCategories = List.from(_originalGodCategories);
    } else {
      _godCategories = _originalGodCategories
          .where(
            (item) => (item.catName ?? '').toLowerCase().contains(
              query.toLowerCase(),
            ),
          )
          .toList();
    }
    notifyListeners();
  }
}
