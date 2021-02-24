part of 'shared.dart';

Future<File> getImage() async {
  var image = await ImagePicker().getImage(source: ImageSource.gallery);
  File file = File(image.path);
  return file;
}

Future<String> uploadImage(File image) async {
  String fileName = basename(image.path);

  StorageReference ref = FirebaseStorage.instance.ref().child(fileName);
  StorageUploadTask task = ref.putFile(image);
  var snapshot = await task.onComplete;

  return await snapshot.ref.getDownloadURL();
}
