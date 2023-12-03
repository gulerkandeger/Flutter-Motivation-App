import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:motivasyon_page/entity/ilham_model.dart';

class IlhamNoktasiService{

  final CollectionReference ilhamCollection = FirebaseFirestore.instance.collection('ilhamnoktasi');

  Future<List<IlhamNoktasiModel>> ilhamVeriAlma() async{
    QuerySnapshot querySnapshot = await ilhamCollection.get();
    List<DocumentSnapshot> documents = querySnapshot.docs;
    documents.shuffle();
    return documents.map((doc){
      return IlhamNoktasiModel(
        id: doc.id,
        ilham: doc['ilham'],
        favori: doc['favori'],
      );
    }).toList();
  }


  Future<void> ilhamFavGuncelleme(String id, bool yeniFavoriDurumu) async {
    await ilhamCollection.doc(id).update({
      'favori': yeniFavoriDurumu,
    });
  }


}
