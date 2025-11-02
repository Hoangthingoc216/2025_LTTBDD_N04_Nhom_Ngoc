import 'package:flutter/material.dart';

class FlashcardTopic {
  String? id;
  String title;
  List<Map<String, String>> words;

  FlashcardTopic({this.id, required this.title, required this.words});

  Map<String, dynamic> toMap() {
    return {'title': title, 'words': words};
  }

  factory FlashcardTopic.fromFirestore(String id, Map<String, dynamic> data) {
    return FlashcardTopic(
      id: id,
      title: data['title'] ?? '',
      words: List<Map<String, String>>.from(data['words'] ?? []),
    );
  }
}
