import 'package:flutter/material.dart';
import 'package:latihan_dio/model/batik_model.dart';
import 'package:latihan_dio/services/batik_service.dart';

class BatikProvider extends ChangeNotifier {
  final BatikService _batikService = BatikService();
  List<BatikResponse> _batikList = [];
  List<BatikResponse> get batikList => _batikList;

  final List<BatikResponse> _bookmarkList = [];
  List<BatikResponse> get bookmarkList => _bookmarkList;

  bool isLoading = false;

  Future<void> fetchBatikList(String title) async {
    try {
      isLoading = true;
      notifyListeners();
      final List<BatikResponse> result = await _batikService.getBatik(title);
      _batikList = result;
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  void addToBookmark(BatikResponse batik) {
    _bookmarkList.add(batik);
    notifyListeners();
  }

  void removeFromBookmark(BatikResponse batik) {
    _bookmarkList.remove(batik);
    notifyListeners();
  }
}
