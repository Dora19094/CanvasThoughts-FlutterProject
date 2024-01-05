import 'package:canvasthoughtsflutter/pages/add_painting.dart';
import 'package:canvasthoughtsflutter/pages/home.dart';
import 'package:canvasthoughtsflutter/pages/loading.dart';
import 'package:canvasthoughtsflutter/pages/museums_list.dart';
import 'package:canvasthoughtsflutter/pages/paintings_list.dart';
import 'package:canvasthoughtsflutter/pages/save_painting.dart';
import 'package:canvasthoughtsflutter/pages/search_paintings_list.dart';
import 'package:canvasthoughtsflutter/pages/view_painting_notes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';


Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,);
  runApp(MaterialApp(
      initialRoute: '/home',
      routes: {
        '/': (context) => Loading(),
        '/home': (context) => Home(),
        '/lists': (context) => MyLists(),
        '/add-painting': (context) => AddPainting(),
        '/paintings-list': (context) => ViewPaintingsList(),
        '/search-paintings': (context) => SearchPaintingsList(),
        '/save-painting': (context) => SelectandSave(),
        '/painting-notes': (context) => PaintingNotes(),

      }

  ));
}