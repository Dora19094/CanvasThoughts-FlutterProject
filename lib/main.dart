import 'package:canvasthoughtsflutter/pages/main/add_painting.dart';
import 'package:canvasthoughtsflutter/pages/main/home.dart';
import 'package:canvasthoughtsflutter/pages/secondary/infoWikki.dart';
import 'package:canvasthoughtsflutter/pages/main/museums_list.dart';
import 'package:canvasthoughtsflutter/pages/main/paintings_list.dart';
import 'package:canvasthoughtsflutter/pages/secondary/save_painting.dart';
import 'package:canvasthoughtsflutter/pages/secondary/search_paintings_list.dart';
import 'package:canvasthoughtsflutter/pages/main/painting_notes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'dart:async';



Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,);
  runApp(MaterialApp(
      initialRoute: '/home',
      routes: {
        '/home': (context) => Home(),
        '/lists': (context) => MyLists(),
        '/add-painting': (context) => AddPainting(title: new TextEditingController(),artist: new TextEditingController()),
        '/paintings-list': (context) => ViewPaintingsList(),
        '/search-paintings': (context) => SearchPaintingsList(),
        '/save-painting': (context) => SelectandSave(),
        '/painting-notes': (context) => PaintingNotes(),
        '/wikki-info': (context) => WikkiInfo(),

      }

  ));
}