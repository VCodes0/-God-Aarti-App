import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/recently_played_model.dart';

class RecentlyPlayedController extends ChangeNotifier {
  List<RecentlyPlayedModel> _originalData = [];
  List<RecentlyPlayedModel> _recentlyPlayed = [];
  List<RecentlyPlayedModel> get recentlyPlayed => _recentlyPlayed;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final Dio dio = Dio();
  final String url =
      "https://appy.trycatchtech.com/v3/all_god/trending_aarti?category_id=1,3";

  Future<void> getRecentlyPlayedData() async {
    _isLoading = true;
    try {
      final response = await dio.get(url);

      if (response.statusCode == 200 && response.data != null) {
        List<dynamic> decodeData = jsonDecode(response.data);
        _originalData = RecentlyPlayedModel.sendRecentlyPlayedModel(decodeData);
        _recentlyPlayed = List.from(_originalData);

        SharedPreferences sh = await SharedPreferences.getInstance();
        sh.setString('recentlyPlayed', response.data);
      } else {
        log('Failed response: ${response.statusCode}');
      }
    } catch (e) {
      log('Error fetching recently played data: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void searchAarti(String query) {
    if (query.isEmpty) {
      _recentlyPlayed = List.from(_originalData);
    } else {
      _recentlyPlayed = _originalData
          .where(
            (item) =>
                (item.title ?? '').toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    }
    notifyListeners();
  }
}
