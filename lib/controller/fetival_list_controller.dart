import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/festival_model.dart';

class FestivalListController extends ChangeNotifier {
  final dio = Dio();
  String url = "https://appy.trycatchtech.com/v3/all_god/all_god_festival_list";

  List<Data> _originalFestivalData = [];
  List<Data> _getFestivalData = [];
  List<Data> get getFestivalData => _getFestivalData;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> getFestivalAartiData() async {
    _isLoading = true;
    try {
      final response = await dio.get(url);

      if (response.statusCode == 200 && response.data != null) {
        final Map<String, dynamic> decoded = response.data is String
            ? jsonDecode(response.data)
            : response.data;

        if (decoded['data'] != null && decoded['data'] is List) {
          _originalFestivalData = Data.getFestival(decoded['data']);
          _getFestivalData = List.from(_originalFestivalData);

          SharedPreferences sh = await SharedPreferences.getInstance();
          sh.setString('festivalData', jsonEncode(decoded['data']));
        }
      }
    } catch (e) {
      log('Error fetching festival data: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void searchFestival(String query) {
    if (query.isEmpty) {
      _getFestivalData = List.from(_originalFestivalData);
    } else {
      _getFestivalData = _originalFestivalData
          .where(
            (item) =>
                (item.name ?? '').toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    }
    notifyListeners();
  }
}
