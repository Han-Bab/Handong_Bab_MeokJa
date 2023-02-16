import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

import '../component/database_service.dart';

class ImageController extends GetxController {
  var image = "".obs;

  Reference get firebaseStorage => FirebaseStorage.instance.ref();

  searchImage(String value) async {
    String newName = DatabaseService().getImage(value);
    var urlRef = firebaseStorage.child('$newName.jpg');
    image.value = await urlRef.getDownloadURL();
  }
}