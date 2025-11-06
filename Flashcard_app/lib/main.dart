import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flashcard_app/screens/login_screen.dart';
import 'firebase_options.dart';
import 'language.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: Language.NgonNguHienTai,
      builder: (context, lang, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flashcard App',
          theme: ThemeData(primaryColor: Color(0xFFF9F3F5)),
          home: const LoginScreen(),
        );
      },
    );
  }
}
