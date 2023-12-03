import 'package:cloud_firestore/cloud_firestore.dart';

class IlhamNoktasiModel{

  final String id;
  final String ilham;
  final bool favori;

  IlhamNoktasiModel({required this.id, required this.ilham,required this.favori});

  factory IlhamNoktasiModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return IlhamNoktasiModel(
      id: snapshot.id,
      ilham: data['ilham'],
      favori: data['favori'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ilham': ilham,
      'favori': favori,
    };
  }

}
