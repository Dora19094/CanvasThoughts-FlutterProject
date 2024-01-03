// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class DatabaseService {
//   //collection reference
//   final CollectionReference museums =
//       FirebaseFirestore.instance.collection('museums');
//
//   final CollectionReference paintings =
//       FirebaseFirestore.instance.collection('paintings');
//
//   Future<DocumentReference<Object?>> addMuseum(String name) async {
//     return await museums.add({'name': name});
//   }
//
//   Future<DocumentReference<Object?>> addPainting(
//       int museumId, String title, String imageUrl) async {
//     return await paintings.add({
//       'museumId': museumId,
//       'title': title,
//       'imageUrl': imageUrl,
//     });
//   }
//
//   Future<void> insertDummyData() async {
//     await addMuseum('Museum A');
//     await addMuseum('Museum B');
//
//     QuerySnapshot museumSnapshot = await museums.get();
//     List<DocumentSnapshot> museumsDocuments = museumSnapshot.docs;
//
//     for (DocumentSnapshot museum in museumsDocuments) {
//       int museumId = int.parse(museum.id);
//       await addPainting(museumId, 'Painting 1', 'image_url_1');
//       await addPainting(museumId, 'Painting 2', 'image_url_2');
//     }
//   }
// }
