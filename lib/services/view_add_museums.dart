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

//Add museum
Future<Museum> addMuseum(String name) async{
  try {
    DocumentReference<Object?> docRef = await museumsRef.add({
      'name': name,
      'museumId': museumsRef.doc().id,
    });
    print("Museum Added with ID: ${docRef.id}");
    return Museum(museumId: docRef.id, name: name);
  } catch (error) {
    print("Failed to add museum: $error");
    throw Exception("Failed to add museum: $error");
  }
}