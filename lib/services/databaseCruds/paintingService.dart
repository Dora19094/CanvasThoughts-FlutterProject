import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/painting.dart';

CollectionReference paintingsRef = FirebaseFirestore.instance.collection('paintings');


Future<List<Painting>> getPaintings(String museumId) async{
    List<Painting> paintings = [];
    await paintingsRef
        .where('museumId', isEqualTo: museumId)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        List<String> feelings = List<String>.from(doc['feelings'] ?? []);
        Painting painting = Painting(museumId: doc['museumId'], title: doc['title'],paintingId: doc['paintingId'],imageUrl: doc['imageUrl'], artist: doc['artist'],notes: doc['notes'],feelings: feelings);
        paintings.add(painting);
      });
    })
        .catchError((error) => print("Failed to retrieve paintings: $error"));
    return paintings;
  }


Future<void> addPainting(String title,String artist,String museumId,String image) {
  String paintingId = paintingsRef.doc().id;
  return paintingsRef.doc(paintingId)
      .set({
    'title': title,
    'museumId': museumId,
    'imageUrl': image,
    'artist': artist,
    'notes' : '',
    'feelings': [],
    'paintingId': paintingId
  })
      .then((value) => print("Painting Added"))
      .catchError((error) => print("Failed to add museum: $error"));
}

Future<void> savePaintingNotes(Painting painting,String newNotes) {
  return paintingsRef.doc(painting.paintingId).update({
    'notes': newNotes,
  })
      .then((value) => print("Painting notes updated"))
      .catchError((error) => print("Failed to update painting's notes: $error"));
}

Future<void> deletePainting(String paintingId) {
  return paintingsRef.doc(paintingId).delete()
      .then((value) => print("Painting Deleted"))
      .catchError((error) => print("Failed to delete painting: $error"));
}

Future<void> savePaintingFeelings(Painting painting,List<String> feelings) {
  return paintingsRef.doc(painting.paintingId).update({
    'feelings': feelings,
  })
      .then((value) => print("Painting feelings updated"))
      .catchError((error) => print("Failed to update painting's feelings: $error"));
}







