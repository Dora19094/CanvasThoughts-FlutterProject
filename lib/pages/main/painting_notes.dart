import 'package:canvasthoughtsflutter/services/apiCalls/feelingsService.dart';
import 'package:canvasthoughtsflutter/services/databaseCruds/paintingService.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/painting.dart';

class PaintingNotes extends StatefulWidget {
  const PaintingNotes({Key? key}) : super(key: key);

  @override
  State<PaintingNotes> createState() => _PaintingNotesState();
}

class _PaintingNotesState extends State<PaintingNotes> {
  Map<dynamic, dynamic> data = {};
  late Painting painting;
  TextEditingController _textEditingController = TextEditingController();
  bool isEditing = false;
  bool notesChanged = false;


  Future<List<String>> saveNotes(String updatedNotes) async{
    try {
      await savePaintingNotes(painting, updatedNotes);
      if (updatedNotes == ''){
        return [];
      }
      List<String> feels = await feelingsService(updatedNotes);
      savePaintingFeelings(painting, feels);
      return feels;
    } catch (error) {
      print('Error fetching museums: $error');
    }
    return [];
  }


  @override
  Widget build(BuildContext context) {
    data = ModalRoute
        .of(context)
        ?.settings
        .arguments as Map;
    painting = !notesChanged ? data['painting'] : painting;
    _textEditingController.text = painting.notes;

    return Scaffold(
        appBar: AppBar(
            title: Text(
              'Notes',
              textAlign: TextAlign.center,
              style: GoogleFonts.patuaOne(
                textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 26,
                ),
              ),
            ),
            centerTitle: true),
        body: Scrollbar(
          thumbVisibility: true,
          thickness: 8,
          radius: Radius.circular(15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 380,
                  color: Colors.black,
                  width: double.infinity,
                  child: Image.network(
                    painting.imageUrl,
                    fit: BoxFit.scaleDown,
                  ),
                ),
                Card(
                  child: ListTile(
                    contentPadding: EdgeInsets.fromLTRB(70, 0, 0, 0),
                    title: Text(
                      painting.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    subtitle: Text(
                        painting.artist, textAlign: TextAlign.center),
                    trailing: IconButton(
                      icon: Icon(Icons.info),
                      iconSize: 32,
                      color: Colors.deepPurple[300],
                      onPressed: () {
                        Navigator.pushNamed(context, '/wikki-info',arguments: {'painting': painting});
                      },
                    ),
                  ),
                ),
                painting.feelings.isNotEmpty ?
                Card(
                  child: ListTile(
                    title: Text(
                      "Prominent Feelings",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    subtitle: Text(
                      painting.feelings.join(" "),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        wordSpacing: 25
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ):Container(),
                isEditing
                    ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _textEditingController,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: painting.notes.isEmpty
                          ? 'Enter your notes...'
                          : '',
                      border: OutlineInputBorder(),
                    ),
                  ),
                )
                    : Padding(
                  padding: const EdgeInsets.all(19.0),
                  child: Text(
                    painting.notes.isEmpty
                        ? "Let's add some notes here!"
                        : painting.notes,
                    style: TextStyle(
                      fontSize: 19,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                if (isEditing)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () async{
                          String updatedNotes = _textEditingController.text;
                          print(updatedNotes);
                          List<String> feels = await saveNotes(updatedNotes);
                          setState(() {
                            painting.feelings = feels;
                            notesChanged = true;
                            painting.notes = updatedNotes;
                            isEditing = false;
                          });
                        },
                        child: Text('Save'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isEditing = false;
                          });
                        },
                        child: Text('Cancel'),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
        floatingActionButton:
            !isEditing ?
        Align(
          alignment: Alignment.bottomRight,
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                isEditing = true;
              });
            },
            child: Text('Edit Notes'),
          ),
        ): Container(),
    );
  }
}
