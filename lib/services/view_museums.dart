import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/museum.dart';

Future<List<Museum>> getMuseums() async {
  List<Museum> museums = [];
  await FirebaseFirestore.instance
      .collection('museums')
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
