import 'package:flutter/material.dart';

class Language {
  static final ValueNotifier<String> NgonNguHienTai = ValueNotifier<String>(
    'Vietnamese',
  );
  static void DoiNgonNgu(String NgonNguMoi) {
    NgonNguHienTai.value = NgonNguMoi;
  }

  static String dich(String vi, String en) {
    return NgonNguHienTai.value == "Vietnamese" ? vi : en;
  }
}
