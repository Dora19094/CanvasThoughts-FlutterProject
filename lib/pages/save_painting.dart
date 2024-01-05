import 'package:canvasthoughtsflutter/models/painting.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/museum.dart';
import '../services/view_add_museums.dart';
import '../services/view_add_paintings.dart';

class SelectandSave extends StatefulWidget {
  const SelectandSave({super.key});

  @override
  State<SelectandSave> createState() => _SelectandSaveState();
}

class _SelectandSaveState extends State<SelectandSave> {
  List<Museum> userLists = [];
  TextEditingController newMuseumController = TextEditingController();
  List<int> selectedTiles = [];

  void addNewMuseum(String name) async {
    Museum addedMuseum = await addMuseum(name);
    setState(() {
      userLists.add(addedMuseum);
    });

    newMuseumController.clear();
  }

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


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchMuseums();
  }

  @override
  Widget build(BuildContext context) {
    final data =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final painting = data?['selectedPainting'] as Painting?;


    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 30),
          Text(
            'Now select your destination lists',
            textAlign: TextAlign.center,
            style: GoogleFonts.spinnaker(
              textStyle: TextStyle(
                color: Colors.black,
                fontSize: 24,
                letterSpacing: 0.5,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: userLists.length + 1,
              itemBuilder: (context, index) {
                bool isSelected = selectedTiles.contains(index);
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
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (selectedTiles.contains(index)){
                          selectedTiles.remove(index);
                        }
                        else {
                          selectedTiles.add(index);
                        }
                        print(selectedTiles);
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 70),
                      child: Card(
                        color: isSelected ? Colors.deepPurple[100] : null,
                        child: ListTile(
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
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () async{
                for (int i in selectedTiles)
                  {
                    await addPainting(painting!.title,painting.artist,userLists[i].museumId,painting.imageUrl);
                  }
                Navigator.restorablePushNamedAndRemoveUntil(context, '/lists', (route) => false);
                },
              child: Text('Save'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
          ],
        ),
      ),
    );
  }
}
