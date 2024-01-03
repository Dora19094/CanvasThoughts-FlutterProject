import 'package:canvasthoughtsflutter/pages/add_painting.dart';
import 'package:canvasthoughtsflutter/pages/home.dart';
import 'package:canvasthoughtsflutter/pages/loading.dart';
import 'package:canvasthoughtsflutter/pages/museums_list.dart';
import 'package:canvasthoughtsflutter/pages/paintings_list.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(MaterialApp(
      initialRoute: '/home',
      routes: {
        '/': (context) => Loading(),
        '/home': (context) => Home(),
        '/lists': (context) => MyLists(),
        '/add-painting': (context) => AddPainting(),
        '/paintings-list': (context) => ViewPaintingsList()
      }

  ));
}