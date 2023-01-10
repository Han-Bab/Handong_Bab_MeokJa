import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _authentication = FirebaseAuth.instance;

    return Scaffold(
      appBar: AppBar(
        title: const Text("마이페이지"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: Card(
              child: Column(
                children: [
                  ListTile(
                    title: const Text(
                      "로그아웃",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.exit_to_app_rounded,
                      color: Colors.black87,
                    ),
                    onTap: () {
                      print("logout");
                      GoogleSignIn().signOut();
                      _authentication.signOut();
                      // Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: const Text(
                      "로그아웃",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.exit_to_app_rounded,
                      color: Colors.black87,
                    ),
                    onTap: () {
                      print("logout");
                      GoogleSignIn().signOut();
                      _authentication.signOut();
                      // Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

void showToast() {
  Fluttertoast.showToast(
    msg: '토스트 테스트',
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.blue,
    fontSize: 15,
    textColor: Colors.white,
    toastLength: Toast.LENGTH_SHORT,
  );
}
