import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../cache_helper/app_cache_helper.dart';

class SessionManager extends ChangeNotifier {
  Timer? _sessionTimer;
  bool _sessionActive = false;
  DateTime? _sessionStartTime;
  final int _sessionDurationMinutes = 30;
  final String _sessionActiveKey = 'sessionActive';
  final String _sessionStartKey = 'sessionStart';

  bool get sessionActive => _sessionActive;

  SessionManager();

  Future<void> loadSession() async {
    final prefs = await SharedPreferences.getInstance();
    _sessionActive = prefs.getBool(_sessionActiveKey) ?? false;
    final sessionStartMillis = prefs.getInt(_sessionStartKey);

    if (_sessionActive && sessionStartMillis != null) {
      _sessionStartTime =
          DateTime.fromMillisecondsSinceEpoch(sessionStartMillis);
      _startSessionTimer();
    }
    notifyListeners();
  }

  Future<void> startSession() async {
    _sessionActive = true;
    _sessionStartTime = DateTime.now();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_sessionActiveKey, true);
    await prefs.setInt(
        _sessionStartKey, _sessionStartTime!.millisecondsSinceEpoch);
    _startSessionTimer();
    notifyListeners();
  }

  Future<void> endSession() async {
    _sessionActive = false;
    _sessionStartTime = null;
    _sessionTimer?.cancel();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_sessionActiveKey, false);
    await prefs.remove(_sessionStartKey);
    final appCacheHelper = AppCacheHelper();
    appCacheHelper.clearData('empCode');
    appCacheHelper.clearData('branchID');
    appCacheHelper.clearData('branchName');
    notifyListeners();
  }

  void _startSessionTimer() {
    _sessionTimer?.cancel();
    final sessionDuration = Duration(minutes: _sessionDurationMinutes);
    _sessionTimer = Timer(sessionDuration, () {
      endSession();
    });
  }

  void resetTimer() {
    if (_sessionActive) {
      _startSessionTimer();
    }
  }

  @override
  void dispose() {
    _sessionTimer?.cancel();
    super.dispose();
  }
}
