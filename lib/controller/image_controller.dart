import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

import '../component/database_service.dart';

class ImageController extends GetxController {
  var image = "".obs;
  var flag = 0.obs;

  Reference get firebaseStorage => FirebaseStorage.instance.ref();

  @override
  void onInit() {
    image.value = "";
    super.onInit();
  }

  searchImage(String value) async {
    String newName = DatabaseService().getImage(value);
    var urlRef = firebaseStorage.child('$newName.jpg');
    image.value = await urlRef.getDownloadURL();
  }
  removeData() async {
    var urlRef = firebaseStorage.child('hanbab_icon.png');
    image.value = await urlRef.getDownloadURL();
    flag.value = 1;
  }
}