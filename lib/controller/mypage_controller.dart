import 'dart:io';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:ios_utsname_ext/extension.dart';
import 'package:package_info_plus/package_info_plus.dart';

class MypageController extends GetxController {
  static MypageController instance = Get.find();

  void sendEmail() async {
    String body = await _getEmailBody();

    final Email email = Email(
      body: body,
      subject: '[한밥 어플리케이션 제보 및 문의]',
      recipients: ['21900215@handong.ac.kr'],
      cc: [],
      bcc: [],
      attachmentPaths: [],
      isHTML: false,
    );
    try {
      await FlutterEmailSender.send(email);
    } catch (e) {
      print(e);
      String title = "알림";
      String message =
          "죄송합니다 \u{1F625}\n\n기본 메일앱을 사용할 수 없어서\n앱에서 바로 문의메일을 전송하기\n어렵습니다.\n\n아래 명시된 이메일로 연락주시면\n친절하고 빠르게 답변해드리도록\n하겠습니다 \u{1F60A}\n";
      Get.defaultDialog(
        title: title,
        titlePadding: const EdgeInsets.fromLTRB(20, 40, 20, 40),
        content: SizedBox(
          height: 300,
          width: double.infinity,
          child: Column(
            children: [
              Text(
                message,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "21900215@handong.ac.kr",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
        contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      );
    }
  }

  Future<String> _getEmailBody() async {
    Map<String, dynamic> appInfo = await _getAppInfo();
    Map<String, dynamic> deviceInfo = await _getDeviceInfo();

    String body = '';

    body += "\n\n";
    body += "==================\n";
    body += "아래 내용을 함께 보내주시면 큰 도움이 됩니다 ☺️\n";

    appInfo.forEach((key, value) {
      body += "$key: $value\n";
    });

    deviceInfo.forEach((key, value) {
      body += "$key: $value\n";
    });

    body += "==================\n";

    return body;
  }

  Future<Map<String, dynamic>> _getDeviceInfo() async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    Map<String, dynamic> deviceData = <String, dynamic>{};

    try {
      if (Platform.isAndroid) {
        deviceData = _readAndroidDeviceInfo(await deviceInfoPlugin.androidInfo);
      } else if (Platform.isIOS) {
        deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
      }
    } catch (e) {
      print(e);
      deviceData = {"ERROR": "플랫폼 버전을 불러오는데 실패했습니다."};
    }

    return deviceData;
  }

  Map<String, dynamic> _readAndroidDeviceInfo(AndroidDeviceInfo info) {
    var release = info.version.release;
    var sdkInt = info.version.sdkInt;
    var manufacturer = info.manufacturer;
    var model = info.model;

    return {
      "OS 버전": "Android $release (SDK $sdkInt)",
      "기기": "$manufacturer $model"
    };
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo info) {
    var systemName = info.systemName;
    var version = info.systemVersion;
    var machine = info.utsname.machine?.iOSProductName;

    return {"OS 버전": "$systemName $version", "기기": "$machine"};
  }

  Future<Map<String, dynamic>> _getAppInfo() async {
    PackageInfo info = await PackageInfo.fromPlatform();
    return {"한밥 Version": info.version};
  }
}
