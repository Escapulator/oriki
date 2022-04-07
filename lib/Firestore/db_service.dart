import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:oriki/Model/dob_model.dart';

class Repository {
  final userdata = FirebaseFirestore.instance.collection('UserData');

  Future createUser(DobModel dobModel) async {
    return await userdata.doc(dobModel.uid).set(dobModel.toJson());
  }

  Stream<List<DobModel>> getUser() {
    final data = userdata.snapshots().map((data) => data.docs
        .map((document) => DobModel.fromJson(document.data()))
        .toList());
    return data;
  }

  Future deleteUser(String uid) async {
    return await userdata.doc(uid).delete();
  }
}
