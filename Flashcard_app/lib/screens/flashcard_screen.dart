import 'package:flutter/material.dart';

class FlashcardScreen extends StatefulWidget {
  const FlashcardScreen({super.key});

  @override
  State<FlashcardScreen> createState() =>
      _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen> {
  final TextEditingController _titleController =
      TextEditingController();
  List<Map<String, TextEditingController>> flashcards = [];
  @override
  void initState() {
    super.initState();
    flashcards.add({
      'en': TextEditingController(),
      'vi': TextEditingController(),
    });
    flashcards.add({
      'en': TextEditingController(),
      'vi': TextEditingController(),
    });
  }

  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
