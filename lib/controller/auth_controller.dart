import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:han_bab/view/login/after_google_login.dart';
import 'package:han_bab/view/login/login_page.dart';
import 'package:han_bab/view/login/verify_login_page.dart';
import 'package:han_bab/view/main/main_screen.dart';

// 각기 다른 상황에서 곧바로 사용자들이 원하는 페이지로 이동을 시켜야 함
class AuthController extends GetxController {
  // 아래 3줄은 GetX 를 사용해서 파베 로그인을 구현할 때 가장 핵심되는 부분이므로 잘 알아야 함.
  // 전역적(global)으로 AuthController 에 접근 가능하게 함.
  static AuthController instance = Get.find();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    print("authInIt");
    getCurrentUser();
  }

  // 현재 시점에서 초기화되는 것이 아니므로 late 붙혀줌.
  late Rx<User?> _user;
  final FirebaseAuth authentication = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  bool isVerified = false;

  final RxBool isUniqueNick = false.obs;

  // GetX Controller 초기 렌더링 후,정보를 불러와주려고 초기화할 때 필요
  @override
  void onReady() {
    super.onReady();
    // Rx<User?>로 선언해줬기 때문에 타입 선언 필수
    _user = Rx<User?>(authentication.currentUser);
    // user 상태를 곧바로 check 할 수 있게 하기 위한 선언 (예전 StreamBuilder 느낌)
    _user.bindStream(authentication.userChanges());
    // 상시 파베 이벤트 상태 감지
    ever(_user, _moveToPage);
  }

  _moveToPage(User? user) {
    // user 정보 존재 (로그인)
    if (user != null) {
      if (user.emailVerified) {
        Get.offAll(() => MainScreen());
      }
    }
    // user 정보가 없다 (로그아웃 상태)
    else {
      Get.offAll(() => LoginPage());
    }
  }

  void register(Map userInfo) async {
    try {
      print(userInfo);
      await authentication.createUserWithEmailAndPassword(
        email: userInfo['userEmail'],
        password: userInfo['userPW'],
      );
      // newUser.user!.uid 는 특정 다큐먼트를 위한 식별자 역할
      // set 메소드 내애서 원하는 엑스트라 데이터를 추가해줄 수 있다. 데이터는 항상 map 형태
      addInfo(userInfo);
      if (!authentication.currentUser!.emailVerified) {
        Get.off(() => VerifyLoginPage());
      }
    } catch (e) {
      Get.snackbar('Error Message', 'User Message',
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM,
          titleText: const Text(
            'Registration is failed',
            style: TextStyle(color: Colors.white),
          ),
          messageText: Text(
            e.toString(),
            style: const TextStyle(
              color: Colors.white,
            ),
          ));
    }
  }

  // READ Collection 내의 모든 데이터 가져올 때
  Future<bool> checkNickName(String nickName) async {
    CollectionReference<Map<String, dynamic>> collectionReference =
        FirebaseFirestore.instance.collection('user');
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await collectionReference
            .where('visibility', isEqualTo: 'public')
            .get();
    for (var doc in querySnapshot.docs) {
      if (doc.data()['userNickName'] != null) {
        if (nickName == doc.data()['userNickName']) {
          return false;
        }
      }
    }
    return true;
  }

  void checkInfo() async {
    final user = authentication.currentUser;
    var docRef =
        await FirebaseFirestore.instance.collection('user').doc(user?.uid);
    docRef.get().then((DocumentSnapshot doc) {
      // print(doc.data());
      if (doc.data() == null) {
        Get.snackbar(
          '알림',
          '구글 로그인의 경우 추가 정보 입력이 필요합니다',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.lightBlue,
          colorText: Colors.white,
        );
        Get.off(() => AfterGoogleLogin(),
            transition: Transition.zoom, duration: const Duration(seconds: 1));
      }
    });
  }

  void addInfo(Map userInfo) async {
    try {
      final user = authentication.currentUser;
      await FirebaseFirestore.instance.collection('user').doc(user!.uid).set({
        'userEmail': userInfo['userEmail'],
        'userName': userInfo['userName'],
        'userPhone': userInfo['userPhone'],
        'userNickName': userInfo['userNickName'],
        'groups': [],
        'uid': user.uid,
        'kakaoLink': false,
        'tossLink': false,
        'visibility': 'public',
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> editInfo(String field, String info) async {
    try {
      final user = authentication.currentUser;
      if (field == 'userName') {
        await FirebaseFirestore.instance
            .collection('user')
            .doc(user!.uid)
            .update({
          'userName': info,
        });
      }
      if (field == 'userNickName') {
        await FirebaseFirestore.instance
            .collection('user')
            .doc(user!.uid)
            .update({
          'userNickName': info,
        });
      }
      if (field == 'userPhone') {
        await FirebaseFirestore.instance
            .collection('user')
            .doc(user!.uid)
            .update({
          'userPhone': info,
        });
      }
      Get.snackbar('알림', '유저 정보가 성공적으로 변경되었습니다',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.lightBlue,
          colorText: Colors.white);
    } catch (e) {
      Get.snackbar('에러', e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  void login(Map userInfo) async {
    try {
      await authentication.signInWithEmailAndPassword(
        email: userInfo['userEmail'],
        password: userInfo['userPW'],
      );
      if (!authentication.currentUser!.emailVerified) {
        Get.off(() => VerifyLoginPage());
      }
    } catch (e) {
      print(e);
      Get.snackbar('Error Message', 'User Message',
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM,
          titleText: const Text(
            '로그인 실패',
            style: TextStyle(color: Colors.white),
          ),
          messageText: Text(
            e.toString(),
            style: const TextStyle(
              color: Colors.white,
            ),
          ));
    }
  }

  // 구글 간편 로그인
  Future<dynamic> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount!.email.contains('@handong.ac.kr')) {
        // Obtain the auth details from the request
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        // Create a new credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        print("로그인 성공");
        // Once signed in, return the UserCredential
        return await authentication.signInWithCredential(credential);
      } else {
        print("로그인 실패");
        Get.snackbar("로그인 실패", "한동 이메일로만 로그인 할 수 있습니다",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
            duration: const Duration(seconds: 2));
        return await _googleSignIn.signOut();
      }
    } catch (e) {
      print(e);
    }
  }

  void getCurrentUser() {
    try {
      final user = authentication.currentUser;
      if (user != null) {
        checkInfo();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<String> getUserInfo(String info) async {
    final user = authentication.currentUser;
    var docRef = await FirebaseFirestore.instance
        .collection('user')
        .doc(user?.uid)
        .get();
    return docRef[info];
  }

  Future<bool> checkUserLink(String info) async {
    final user = authentication.currentUser;
    var docRef = await FirebaseFirestore.instance
        .collection('user')
        .doc(user?.uid)
        .get();
    // print(docRef[info]);
    return docRef[info];
  }

  Future<void> logoutGoogle() async {
    await _googleSignIn.signOut();
  }

  void logout() {
    authentication.signOut();
  }

  Future<void> resetPassword(String email) async {
    await authentication.sendPasswordResetEmail(email: email);
  }
}
