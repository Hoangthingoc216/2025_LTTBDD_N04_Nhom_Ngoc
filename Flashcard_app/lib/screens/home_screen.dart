import 'package:flutter/material.dart';
import 'package:flashcard_app/screens/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F3F5),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 244, 221, 229),
        title: Text(
          "Flashcard App",
          style: TextStyle(color: Colors.black),
        ),
      ),
      drawer: Drawer(
        backgroundColor: Color(0xFFF4EDF1),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              color: Color.fromARGB(255, 244, 221, 229),
              padding: EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 15,
              ),
              child: Text(
                "Menu",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
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
    );
  }
}
