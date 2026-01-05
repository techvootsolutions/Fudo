import 'package:flutter/material.dart';


abstract class BaseNotifier extends ChangeNotifier {
  bool isDisposed = false;

  @override
  void notifyListeners() {
    if (!isDisposed) {
      super.notifyListeners();
    }
  }

  void onDispose();

  @override
  void dispose() {
    isDisposed = true;
    onDispose();
    super.dispose();
  }
}
