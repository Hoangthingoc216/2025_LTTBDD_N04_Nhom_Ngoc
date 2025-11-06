import 'package:flashcard_app/language.dart';
import 'package:flashcard_app/screens/introduce_screen.dart';
import 'package:flashcard_app/screens/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flashcard_app/models/flashcard_model.dart';
import 'package:flashcard_app/screens/flashcard_screen.dart';
import 'package:flashcard_app/services/firestore_service.dart';
import 'package:flashcard_app/screens/study_screen.dart';
import 'package:flashcard_app/services/auth_service.dart';
import 'package:flashcard_app/screens/login_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});
  final List<FlashcardTopic> topics = [];

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirestoreService firestoreService = FirestoreService();
  final List<Color> cardColors = [
    Color.fromARGB(255, 235, 245, 236),
    Color.fromARGB(255, 235, 246, 253),
    Color.fromARGB(255, 242, 241, 237),
    Color.fromARGB(255, 247, 246, 249),
  ];

  void DangXuat(BuildContext context) async {
    await AuthService().signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9F3F5),
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
              title: Text(Language.dich("Trang chủ", "Home")),
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
              title: Text(Language.dich("Học tập", "Study")),
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
              title: Text(Language.dich("Cài đặt", "Settings")),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingScreen()),
                );
              },
            ),
            ListTile(
              dense: true,
              leading: Icon(Icons.person),
              title: Text(
                Language.dich("Thông tin cá nhân", "Personal Information"),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => IntroduceScreen()),
                );
              },
            ),
            ListTile(
              dense: true,
              leading: Icon(Icons.logout),
              title: Text(Language.dich("Đăng xuất", "Logout")),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
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
              Language.dich("Chủ đề của bạn nè!", "My topics"),
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
