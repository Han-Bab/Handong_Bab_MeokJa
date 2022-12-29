import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
<<<<<<< Updated upstream
import 'package:han_bab/search_screen.dart';
import 'chatList_screen.dart';
=======
import 'chatList_screen.dart';
import 'package:han_bab/screens/main/main_screen.dart';
>>>>>>> Stashed changes
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
<<<<<<< Updated upstream
      home: SearchScreen(),
=======
      home: MainScreen(),
>>>>>>> Stashed changes
    );
  }
}
