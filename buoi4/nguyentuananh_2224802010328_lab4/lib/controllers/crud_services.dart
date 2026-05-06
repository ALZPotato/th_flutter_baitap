import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CRUDService {
  User? user = FirebaseAuth.instance.currentUser;

  // Thêm contact mới
  Future addNewContacts(String name, String phone, String email) async {
    Map<String, dynamic> data = {"name": name, "email": email, "phone": phone};
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .collection("contacts")
          .add(data);
      print("Document Added");
    } catch (e) {
      print(e.toString());
    }
  }

  // Đọc danh sách contacts
  Stream<QuerySnapshot> getContacts({String? searchQuery}) {
    var contactsQuery = FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .collection("contacts")
        .orderBy("name");

    if (searchQuery != null && searchQuery.isNotEmpty) {
      String searchEnd = searchQuery + "\uf8ff";
      return contactsQuery
          .where("name", isGreaterThanOrEqualTo: searchQuery, isLessThan: searchEnd)
          .snapshots();
    }
    return contactsQuery.snapshots();
  }

  // Cập nhật contact
  Future updateContact(String name, String phone, String email, String docID) async {
    Map<String, dynamic> data = {"name": name, "email": email, "phone": phone};
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .collection("contacts")
          .doc(docID)
          .update(data);
    } catch (e) {
      print(e.toString());
    }
  }

  // Xóa contact
  Future deleteContact(String docID) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .collection("contacts")
          .doc(docID)
          .delete();
    } catch (e) {
      print(e.toString());
    }
  }
}