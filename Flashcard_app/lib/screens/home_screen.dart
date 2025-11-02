import 'package:flutter/material.dart';
import 'package:flashcard_app/models/flashcard_model.dart';
import 'package:flashcard_app/screens/flashcard_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});
  final List<FlashcardTopic> topics = [
    FlashcardTopic(
      title: "Animals",
      words: [
        {"Dog": "Con chó"},
        {"Cat": "Con mèo"},
        {"Elephant": "Con voi"},
        {"Bird": "Con chim"},
        {"Fish": "Con cá"},
      ],
    ),

    FlashcardTopic(
      title: "Transportation",
      words: [
        {"Bus": "Xe buýt"},
        {"Car": "Xe hơi"},
      ],
    ),

    FlashcardTopic(
      title: "Fruits",
      words: [
        {"Apple": "Quả táo"},
        {"Banana": "Quả chuối"},
        {"Mango": "Quả xoài"},
        {"Orange": "Quả cam"},
        {"Grape": "Quả nho"},
      ],
    ),
    FlashcardTopic(
      title: "Colors",
      words: [
        {"Red": "Màu đỏ"},
        {"Blue": "Màu xanh dương"},
        {"Green": "Màu xanh lá"},
        {"Yellow": "Màu vàng"},
        {"Purple": "Màu tím"},
      ],
    ),
  ];

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Color> cardColors = [
    Color.fromARGB(255, 235, 245, 236),
    Color.fromARGB(255, 245, 248, 250),
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
              child: GridView.builder(
                itemCount: widget.topics.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 3 / 1.3,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                ),
                itemBuilder: (context, index) {
                  final topic = widget.topics[index];
                  final color = cardColors[index % cardColors.length];

                  return InkWell(
                    onTap: () {},
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
