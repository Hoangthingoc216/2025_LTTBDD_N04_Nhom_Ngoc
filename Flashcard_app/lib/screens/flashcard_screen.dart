import 'package:flashcard_app/language.dart';
import 'package:flutter/material.dart';
import 'package:flashcard_app/models/flashcard_model.dart';
import 'package:flashcard_app/services/firestore_service.dart';

class FlashcardScreen extends StatefulWidget {
  const FlashcardScreen({super.key});

  @override
  State<FlashcardScreen> createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen> {
  final TextEditingController _titleController = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9F3F5),
      appBar: AppBar(
        title: Text(
          Language.dich('Tạo chủ đề Flashcard', 'Create Flashcard Topic'),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: Language.dich('Tên chủ đề', 'Topic Title'),
                prefixIcon: Icon(Icons.title),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: flashcards.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.only(bottom: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: TextField(
                              controller: flashcards[index]['en'],
                              decoration: InputDecoration(
                                labelText: 'English',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 12),

                          Expanded(
                            child: TextField(
                              controller: flashcards[index]['vi'],
                              decoration: InputDecoration(
                                labelText: 'Vietnamese',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),

                          IconButton(
                            onPressed: () {
                              setState(() {
                                flashcards.removeAt(index);
                              });
                            },
                            icon: Icon(Icons.delete, color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  flashcards.add({
                    'en': TextEditingController(),
                    'vi': TextEditingController(),
                  });
                });
              },
              label: Text(Language.dich("Thêm thẻ mới", "Add a card")),
              icon: Icon(Icons.add),
            ),
            SizedBox(height: 16),

            ElevatedButton(
              onPressed: () async {
                final topic = _titleController.text.trim();
                if (topic.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        Language.dich(
                          'Vui lòng nhập tiêu đề',
                          'Please enter a title',
                        ),
                      ),
                    ),
                  );
                  return;
                }
                final flashcardData = flashcards.map((card) {
                  return {
                    'en': card['en']!.text.trim(),
                    'vi': card['vi']!.text.trim(),
                  };
                }).toList();
                final flashcardTopic = FlashcardTopic(
                  id: '',
                  title: topic,
                  words: flashcardData,
                );
                await FirestoreService().addFlashcardTopic(flashcardTopic);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Đã lưu chủ đề flashcard!')),
                );
                Navigator.pop(context);
              },
              child: Text(Language.dich('Tạo', 'Create')),
            ),
          ],
        ),
      ),
    );
  }
}
