import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/painting.dart';

CollectionReference paintingsRef = FirebaseFirestore.instance.collection('paintings');


Future<List<Painting>> getPaintings(String museumId) async{
    List<Painting> paintings = [];
    await paintingsRef
        .where('museumId', isEqualTo: museumId)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        Painting painting = Painting(museumId: doc['museumId'], title: doc['title'],paintingId: doc['paintingId'],imageUrl: doc['imageUrl'], artist: doc['artist']);
        paintings.add(painting);
      });
    })
        .catchError((error) => print("Failed to retrieve paintings: $error"));
    return paintings;
  }

