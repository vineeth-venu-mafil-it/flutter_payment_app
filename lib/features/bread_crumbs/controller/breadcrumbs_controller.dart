import 'package:flutter/material.dart';

class BreadCrumbsProvider with ChangeNotifier {
  final List<Map<String, String>> _breadcrumbs = [];

  List<Map<String, String>> get breadcrumbs => _breadcrumbs;

  void addBreadcrumb(Map<String, String> data) {
    _breadcrumbs.add(data);

    notifyListeners();
  }

  void clearBreadcrumbs() {
    _breadcrumbs.clear();
    notifyListeners();
  }

  void removeBreadcrumb(int index) {
    if (index >= 0 && index < _breadcrumbs.length) {
      _breadcrumbs.removeAt(index);
      notifyListeners();
    }
  }
}
