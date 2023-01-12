import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:han_bab/kakao/kakao_login.dart';
import 'package:han_bab/kakao/main_view_model.dart';

import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

class KakaoMain extends StatelessWidget {
  const KakaoMain({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    final viewModel = MainViewModel(KakaoLogin());

    return Scaffold(
        appBar: AppBar(
            title: Text("dd")
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(viewModel.user?.kakaoAccount?.profile?.profileImageUrl ?? ' '),
              Text(
                '${viewModel.isLogined}',
                style: Theme.of(context).textTheme.headline4,
              ),
              ElevatedButton(
                onPressed: () async {
                  await viewModel.login();
                  setState(() {});
                },
                child: const Text('Login'),
              ),
              ElevatedButton(
                onPressed: () async {
                  await viewModel.logout();
                  setState(() {});
                },
                child: const Text('Logout'),
              )
            ],
          ),
        )
    );
  }
}