import 'package:canvasthoughtsflutter/services/view_add_museums.dart';
import 'package:canvasthoughtsflutter/widgets/stateful/museumList.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/museum.dart';
import '../widgets/stateful/navigation_bar.dart';

class MyLists extends StatefulWidget {
  const MyLists({super.key});

  @override
  State<MyLists> createState() => _MyListsState();
}

class _MyListsState extends State<MyLists> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          'My Lists',
          textAlign: TextAlign.center,
          style: GoogleFonts.patuaOne(
              textStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 26,
              ),
              letterSpacing: 1.0),
        ),
        shape: Border(bottom: BorderSide(color: Colors.grey, width: 2)),
        elevation: 4,
      ),
      body: MuseumList(onTapMuseum: 'view', parentContext: context),
      bottomNavigationBar:
          MyBottomNavigationBar(parentContext: context, currentIndex: 0),
    );
  }
}
