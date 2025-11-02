import 'package:flutter/material.dart';

class FlashcardTopic {
  final String title; // Tên chủ đề
  final List<Map<String, String>>
  words; // Danh sách các từ (word + meaning)

  FlashcardTopic({
    required this.title,
    required this.words,
  });
}
