import 'dart:io';
import 'dart:math';

import 'package:canvasthoughtsflutter/models/museum.dart';
import 'package:canvasthoughtsflutter/services/view_add_museums.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../firebase_options.dart';

class DummyData {

    CollectionReference museums = FirebaseFirestore.instance.collection('museums');
    CollectionReference paintings = FirebaseFirestore.instance.collection('paintings');
    
    Future<void> addMuseums(String name) {
      return museums
          .add({
        'name': name,
        'museumId': museums.doc().id
      })
          .then((value) => print("Museum Added"))
          .catchError((error) => print("Failed to add museum: $error"));
    }

    Future<void> addPainting(String title,String artist,String museumId,String image) {
      return paintings
          .add({
        'title': title,
        'paintingId': paintings.doc().id,
        'museumId': museumId,
        'imageUrl': image,
        'artist': artist
      })
          .then((value) => print("Painting Added"))
          .catchError((error) => print("Failed to add museum: $error"));
    }



    Future<void> insertDummyData() async {
      Random random = Random();
      await addMuseums('Louvre');
      await addMuseums('Uffizi Gallery');
      await addMuseums('Musee d Orsay');
      await addMuseums('Paul Getty Center');
      await addMuseums('Asian Collection');
      await addMuseums('Met Collection');
      await addMuseums('Modern Art Museum');
      List<Museum> savedMuseums = await getMuseums();
      List<String> museumIds = savedMuseums.map((museum) => museum.museumId).toList();
      await addPainting('Mona Lisa', 'Leonardo da Vinci', museumIds[random.nextInt(museumIds.length)],'https://www.google.com/url?sa=i&url=http%3A%2F%2Ft1.gstatic.com%2Flicensed-image%3Fq%3Dtbn%3AANd9GcQ-FvbbAq5IaJUhtwxXEwY0D-jiZju02ejnNHx_bQWL_27GF3srhwJgqusMAqKh3QqU&psig=AOvVaw253JK6JfjY5E4XG-8Roc1M&ust=1704490461680000&source=images&cd=vfe&opi=89978449&ved=0CA0QjhxqFwoTCNjJhPfXxIMDFQAAAAAdAAAAABAD');
      await addPainting('Starry Night', 'Vincent van Gogh',museumIds[random.nextInt(museumIds.length)], 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/ea/Van_Gogh_-_Starry_Night_-_Google_Art_Project.jpg/1024px-Van_Gogh_-_Starry_Night_-_Google_Art_Project.jpg');
      await addPainting('The Persistence of Memory', 'Salvador Dalí',museumIds[random.nextInt(museumIds.length)], 'https://upload.wikimedia.org/wikipedia/en/d/dd/The_Persistence_of_Memory.jpg');

    }

}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,);
  DummyData dd = DummyData();
  await dd.insertDummyData();
  print('Dummy data insertion completed!');
  exit(0);
}