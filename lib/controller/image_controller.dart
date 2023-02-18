import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

import '../component/database_service.dart';

class ImageController extends GetxController {
  var image = "".obs;

  Reference get firebaseStorage => FirebaseStorage.instance.ref();

  @override
  void onInit() {
    image.value = "";
    super.onInit();
  }

  searchImage(String name) async {
    String newName = DatabaseService().getImage(name);
    Reference urlRef;

    if(newName == "no file") {
      urlRef = firebaseStorage.child('hanbab_icon.png');
    } else {
      urlRef = firebaseStorage.child('$newName.jpg');
    }
    image.value = await urlRef.getDownloadURL();
  }
  removeData() async {
    var urlRef = firebaseStorage.child('hanbab_icon.png');
    image.value = await urlRef.getDownloadURL();
  }
}