import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/museum.dart';
import '../../services/view_add_museums.dart';

class MuseumList extends StatefulWidget {
  final String onTapMuseum;
  final BuildContext parentContext;
  const MuseumList({super.key, required this.onTapMuseum, required this.parentContext});

  @override
  State<MuseumList> createState() => _MuseumListState();
}

class _MuseumListState extends State<MuseumList> {
  List<Museum> userLists = [];
  TextEditingController newMuseumController = TextEditingController();
  Map<String,Function> onTap = {};

  @override
  void initState() {
    super.initState();
    onTap = {
      'view': (index) {
        Navigator.pushNamed(context, '/paintings-list',
            arguments: {'museum': userLists[index]});
      },
      'save': (index) {

      }
    };
  }

  void addNewMuseum(String name) async{
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
    return Column(
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
                        onTap[widget.onTapMuseum]!(index);
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
    );
  }
}
