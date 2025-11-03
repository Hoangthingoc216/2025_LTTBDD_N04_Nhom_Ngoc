import 'package:flutter/material.dart';

class FlashcardTopic {
  String? id;
  String title;
  List<Map<String, String>> words;

  FlashcardTopic({this.id, required this.title, required this.words});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'words': words.map((word) {
        final en = word.keys.first;
        final vi = word.values.first;
        return {'en': en, 'vi': vi};
      }).toList(),
    };
  }

  factory FlashcardTopic.fromFirestore(String id, Map<String, dynamic> data) {
    final title = data['title'] ?? '';
    final wordList = data['words'] ?? [];

    final words = (wordList as List).map((item) {
      final en = item['en']?.toString() ?? '';
      final vi = item['vi']?.toString() ?? '';
      return {en: vi};
    }).toList();

    return FlashcardTopic(id: id, title: title, words: words);
  }
}
