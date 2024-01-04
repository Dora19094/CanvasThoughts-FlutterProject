import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../firebase_options.dart';

class DummyData {

    CollectionReference museums = FirebaseFirestore.instance.collection('museums');

    Future<void> addMuseums(String name) {
      return museums
          .add({
        'name': name,
        'museumId': FirebaseFirestore.instance.collection('museums').doc().id
      })
          .then((value) => print("Museum Added"))
          .catchError((error) => print("Failed to add museum: $error"));
    }

    Future<void> insertDummyData() async {
      await addMuseums('Louvre');
      //await addMuseums('Uffizi Gallery');
      await addMuseums('Musee d Orsay');
      await addMuseums('Paul Getty Center');
      await addMuseums('Asian Collection');
      await addMuseums('Met Collection');
      await addMuseums('Modern Art Museum');
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