import 'package:canvasthoughtsflutter/services/view_add_museums.dart';
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
  List<Museum> userLists = [];
  TextEditingController newMuseumController = TextEditingController();

  Future<void> fetchMuseums() async {
    try {
      List<Museum> museums = await getMuseums();
      setState(() {
        userLists = museums;
      });
      print('We have ${userLists.length} in the database');
    } catch (error) {
      print('Error fetching museums: $error');
    }
  }

  void addNewMuseum(String name) async{
    Museum addedMuseum = await addMuseum(name);
    setState(() {
      userLists.add(addedMuseum);
    });

    newMuseumController.clear();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchMuseums();
  }

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
          SizedBox(height: 25),
          Expanded(
            child: ListView.builder(
              itemCount: userLists.length + 1,
              itemBuilder: (context, index) {
                if (index == userLists.length) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 70),
                    child: Card(
                      child: ListTile(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Add New Museum"),
                                  content: TextField(
                                    controller: newMuseumController,
                                    decoration:
                                    InputDecoration(labelText: "Museum Name"),
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        addNewMuseum(newMuseumController.text);
                                      },
                                      child: Text("Add"),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("Cancel"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        title: Icon(Icons.add),
                        titleAlignment: ListTileTitleAlignment.center,
                      ),
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 70),
                    child: Card(
                      child: ListTile(
                        onTap: () {
                          Navigator.pushNamed(context, '/paintings-list',
                              arguments: {'museum': userLists[index]});
                        },
                        title: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            userLists[index].name,
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
                      ),
                    ),
                  );
                }
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
