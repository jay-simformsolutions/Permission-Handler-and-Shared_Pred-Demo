import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:permission_handler_demo/pages/firebase/model/user_model.dart';

class CloudFireStorePage {
  CloudFireStorePage._internal();

  static final instance = CloudFireStorePage._internal();

  Future<List<UserModel>?> getAllEntries(String collection) async {
    final users = await FirebaseFirestore.instance.collection('users').get();
    return users.docs.map(UserModel.fromJson).toList();
  }

  Future<DocumentReference<Map<String, dynamic>>> addNewUser(
      String collection, Map<String, dynamic> data) async {
    return FirebaseFirestore.instance.collection(collection).add(data);
  }

  Future<void> updateEntryWithId(
      String collection, String documentId, Map<String, dynamic> data) async {
    await FirebaseFirestore.instance
        .collection(collection)
        .doc(documentId)
        .update(data);
  }

  // deletes the entry with the given document id
  Future<void> deleteUser(String collection, String documentId) async {
    await FirebaseFirestore.instance
        .collection(collection)
        .doc(documentId)
        .delete();
  }
}
