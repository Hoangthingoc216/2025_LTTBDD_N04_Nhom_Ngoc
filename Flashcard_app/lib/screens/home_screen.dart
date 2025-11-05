import 'package:flutter/material.dart';
import 'package:flashcard_app/models/flashcard_model.dart';
import 'package:flashcard_app/screens/flashcard_screen.dart';
import 'package:flashcard_app/services/firestore_service.dart';
import 'package:flashcard_app/screens/study_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});
  final List<FlashcardTopic> topics = [
    FlashcardTopic(
      title: "Fruits",
      words: [
        {"en": "Grape", "vi": "QUả nho"},
        {"en": "Apple", "vi": "Quả táo"},
        {"en": "Coconut", "vi": "Quả dừa"},
      ],
    ),
    FlashcardTopic(
      title: "Transportation",
      words: [
        {"en": "Bus", "vi": "Xe buýt"},
        {"en": "Car", "vi": "Xe hơi"},
      ],
    ),
  ];

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirestoreService firestoreService = FirestoreService();
  final List<Color> cardColors = [
    Color.fromARGB(255, 235, 245, 236),
    Color.fromARGB(255, 66, 134, 180),
    Color.fromARGB(255, 242, 241, 237),
    Color.fromARGB(255, 247, 246, 249),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F3F5),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 250, 233, 239),
        title: Text("Flashcard App", style: TextStyle(color: Colors.black)),
      ),
      drawer: Drawer(
        backgroundColor: Color(0xFFF4EDF1),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              color: Color.fromARGB(255, 244, 221, 229),
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 15),
              child: Text(
                "Menu",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              dense: true,
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              dense: true,
              leading: Icon(Icons.auto_stories),
              title: Text("Flashcards"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FlashcardScreen()),
                );
              },
            ),

            ListTile(
              dense: true,
              leading: Icon(Icons.book),
              title: Text("Study"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StudyScreen(topic: widget.topics[0]),
                  ),
                );
              },
            ),
            ListTile(
              dense: true,
              leading: Icon(Icons.settings),
              title: Text("Settings"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              dense: true,
              leading: const Icon(Icons.person),
              title: const Text("Information"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              dense: true,
              leading: Icon(Icons.logout),
              title: Text("Logout"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),

      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Chủ đề của bạn nè!",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            SizedBox(height: 16),

            Expanded(
              child: StreamBuilder<List<FlashcardTopic>>(
                stream: FirestoreService().getFlashcardTopics(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasData == false || snapshot.data!.isEmpty) {
                    return Center(child: Text("Không có chủ đề nào."));
                  }
                  final topics = snapshot.data!;

                  return GridView.builder(
                    itemCount: topics.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 3 / 1.3,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                    ),

                    itemBuilder: (context, index) {
                      final topic = topics[index];
                      final color = cardColors[index % cardColors.length];

                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StudyScreen(topic: topic),
                            ),
                          );
                        },
                        hoverColor: Color.fromARGB(255, 192, 65, 107),
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  topic.title,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                SizedBox(height: 4),

                                Text(
                                  "${topic.words.length} từ",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
