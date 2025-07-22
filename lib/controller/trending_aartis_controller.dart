import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/recently_played_model.dart';

class TrendingAartisController extends ChangeNotifier {
  List<RecentlyPlayedModel> _originalData = [];
  List<RecentlyPlayedModel> _trendingAartis = [];
  List<RecentlyPlayedModel> get trendingAartis => _trendingAartis;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final Dio dio = Dio();
  final String url =
      "https://appy.trycatchtech.com/v3/all_god/trending_aarti?category_id=1,2";

  Future<void> getTrndingAartisData() async {
    _isLoading = true;
    try {
      final response = await dio.get(url);

      if (response.statusCode == 200 && response.data != null) {
        List<dynamic> decodeData = jsonDecode(response.data);
        _originalData = RecentlyPlayedModel.sendRecentlyPlayedModel(decodeData);
        _trendingAartis = List.from(_originalData);

        SharedPreferences sh = await SharedPreferences.getInstance();
        sh.setString('trendingAartis', response.data);
      }
    } catch (e) {
      log('Error fetching trending Aartis data: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void searchTrndingAarti(String query) {
    if (query.isEmpty) {
      _trendingAartis = List.from(_originalData);
    } else {
      _trendingAartis = _originalData
          .where(
            (item) =>
                (item.title ?? '').toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    }
    notifyListeners();
  }
}
