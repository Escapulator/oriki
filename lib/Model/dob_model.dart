import 'package:cloud_firestore/cloud_firestore.dart';

class DobModel {
  String name;
  String email;
  int number;
  Timestamp date;
  String uid;

  DobModel(
      {required this.name,
      required this.uid,
      required this.email,
      required this.number,
      required this.date});

  factory DobModel.fromJson(Map<String, dynamic> json) => DobModel(
      name: json['name'],
      email: json['email'],
      number: json['number'],
      date: json['date'],
      uid: json['uid']);

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'number': number,
        'date': date,
        'uid': uid,
      };
}
