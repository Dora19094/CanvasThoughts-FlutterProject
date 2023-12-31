import 'package:canvasthoughtsflutter/widgets/stateful/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyLists extends StatefulWidget {
  const MyLists({super.key});

  @override
  State<MyLists> createState() => _MyListsState();
}

class _MyListsState extends State<MyLists> {
  List<String> user_lists = [
    'Louvre',
    'Modern Art Museum',
    'Met Collection',
    'Asian Collection',
    'Paul Getty Center',
    'Musee d Orsay',
    'Uffizi Gallery'
  ];

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
      body: Column(
        children: [
          SizedBox(height:25),
          Expanded(
            child: ListView.builder(
              itemCount: user_lists.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 70),
                  child: Card(
                      child: ListTile(
                    onTap: () {
                      //TODO navigate to this list of paintings
                    },
                    title: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        user_lists[index],
                        textAlign: TextAlign.center,
                        style: GoogleFonts.spinnaker(
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                    titleAlignment: ListTileTitleAlignment.center,
                  )),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar:
          MyBottomNavigationBar(parentContext: context, currentIndex: 0),
    );
  }
}
