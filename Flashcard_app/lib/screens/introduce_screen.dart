import 'package:flutter/material.dart';
import 'package:flashcard_app/language.dart';

class IntroduceScreen extends StatefulWidget {
  const IntroduceScreen({super.key});

  @override
  State<IntroduceScreen> createState() => _IntroduceScreenState();
}

class _IntroduceScreenState extends State<IntroduceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Language.dich('Thông tin của nhóm', 'Group information')),
        backgroundColor: Color.fromARGB(255, 250, 233, 239),
        foregroundColor: Colors.black,
      ),
      backgroundColor: Color(0xFFFFF0F6),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          SizedBox(height: 10),

          Center(
            child: CircleAvatar(
              radius: 55,
              backgroundImage: AssetImage('imgs/ngoc.jpg'),
            ),
          ),
          SizedBox(height: 20),

          Center(
            child: Text(
              Language.dich("Hoàng Thị Ngọc", "Hoang Thi Ngoc"),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 8),

          Center(
            child: Text(
              "2025_LTTBDD_N04_Nhom_Ngoc",
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
          SizedBox(height: 20),
          Divider(),
          Center(
            child: Text(
              Language.dich("Thông tin cá nhân", "Personal Information"),
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 16),

          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildInfo(Icons.badge_outlined, "Mã SV: 23010156"),
                SizedBox(height: 8),

                _buildInfo(
                  Icons.class_outlined,
                  "Lớp: Lập Trình Cho Thiết Bị Di Động-1-1-25(N04)",
                ),
                SizedBox(height: 8),

                _buildInfo(Icons.school_outlined, "Trường: Đại học Phenikaa"),
                SizedBox(height: 8),

                _buildInfo(Icons.person_outline, "Giảng viên: Nguyễn Xuân Quế"),
              ],
            ),
          ),
          SizedBox(height: 20),
          Divider(),

          Center(
            child: Text(
              Language.dich("Liên hệ", "Contact"),
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 8),

          Center(
            child: _buildInfo(
              Icons.email_outlined,
              "23010156@st.phenikaa-uni.edu.vn",
            ),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildInfo(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.pinkAccent),
        SizedBox(width: 10),
        Text(text, style: TextStyle(fontSize: 16)),
      ],
    );
  }
}
