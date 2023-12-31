import 'package:canvasthoughtsflutter/pages/add_painting.dart';
import 'package:canvasthoughtsflutter/pages/home_page.dart';
import 'package:canvasthoughtsflutter/pages/loading_page.dart';
import 'package:canvasthoughtsflutter/pages/my_lists.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(MaterialApp(
      initialRoute: '/home',
      routes: {
        '/': (context) => Loading(),
        '/home': (context) => Home(),
        '/lists': (context) => MyLists(),
        '/add-painting': (context) => AddPainting(),
      }

  ));
}