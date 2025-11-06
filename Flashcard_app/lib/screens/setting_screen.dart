import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashcard_app/language.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  String NgonNgu = "Vietnamese";
  final FirebaseAuth HTXacThuc = FirebaseAuth.instance;
  final TextEditingController QLyMatKhau = TextEditingController();

  void DoiMatKhau(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Đổi mật khẩu"),
        content: TextField(
          controller: QLyMatKhau,
          decoration: InputDecoration(labelText: "Mật khẩu mới"),
        ),

        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Hủy"),
          ),

          ElevatedButton(
            onPressed: () async {
              final newPassword = QLyMatKhau.text.trim();
              if (newPassword.isEmpty) return;
              try {
                await HTXacThuc.currentUser?.updatePassword(newPassword);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Đổi mật khẩu thành công!")),
                );
              } catch (e) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text("Lỗi: $e")));
              }
            },
            child: Text("Xác nhận"),
          ),
        ],
      ),
    );
  }

  void DoiNgonNgu(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(Language.dich("Chọn ngôn ngữ", "Choose language")),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile(
              title: Text(Language.dich("Tiếng Việt", "Vietnamese")),
              value: "Vietnamese",
              groupValue: NgonNgu,
              onChanged: (value) {
                setState(() {
                  NgonNgu = value!;
                  Language.DoiNgonNgu(value);
                });
                Navigator.pop(context);
              },
            ),
            RadioListTile(
              title: Text(Language.dich("Tiếng Anh", "English")),
              value: "English",
              groupValue: NgonNgu,
              onChanged: (value) {
                setState(() {
                  NgonNgu = value!;
                  Language.DoiNgonNgu(value);
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = HTXacThuc.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('Setting'),
        backgroundColor: Color.fromARGB(255, 250, 233, 239),
        foregroundColor: Colors.black,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          ListTile(
            leading: Icon(Icons.person),
            title: Text(Language.dich('Tài khoản của tôi', 'My account')),
            subtitle: Text(
              user?.email ??
                  Language.dich('Chưa đăng nhập', 'Do not have an account yet'),
            ),
          ),
          Divider(),

          ListTile(
            leading: Icon(Icons.lock_reset_outlined),
            title: Text(Language.dich('Đổi mật khẩu', 'Change Paswords')),
            onTap: () {
              DoiMatKhau(context);
            },
          ),

          ListTile(
            leading: Icon(Icons.translate),
            title: Text(Language.dich('Ngôn ngữ', 'Language')),
            subtitle: Text(NgonNgu),
            onTap: () {
              DoiNgonNgu(context);
            },
          ),
        ],
      ),
    );
  }
}
