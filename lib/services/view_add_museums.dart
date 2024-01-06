import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/museum.dart';

//Collection Reference
CollectionReference museumsRef = FirebaseFirestore.instance.collection('museums');

//View museums
Future<List<Museum>> getMuseums() async {
  List<Museum> museums = [];
  await museumsRef
      .get()
      .then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      Museum museum = Museum(museumId: doc['museumId'], name: doc['name']);
      museums.add(museum);
    });
  })
      .catchError((error) => print("Failed to retrieve museums: $error"));

  return museums;

}

//add museum
Future<Museum> addMuseum(String name) async {
  String museumId = museumsRef.doc().id;
  await museumsRef.doc(museumId).set({
    'name': name,
    'museumId': museumId
  });

  print("Museum Added");
  return Museum(museumId: museumId, name: name);
}


