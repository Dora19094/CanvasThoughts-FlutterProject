import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/painting.dart';

class PaintingNotes extends StatefulWidget {
  const PaintingNotes({Key? key}) : super(key: key);

  @override
  State<PaintingNotes> createState() => _PaintingNotesState();
}

class _PaintingNotesState extends State<PaintingNotes> {
  Map<dynamic,dynamic> data = {};
  late Painting painting;
  TextEditingController _textEditingController = TextEditingController();
  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)?.settings.arguments as Map;
    painting = data['painting'];

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
          centerTitle: true
      ),
      body: Scrollbar(
        thumbVisibility: true,
        thickness: 8,
        radius: Radius.circular(15),
        child: SingleChildScrollView(
          child: Column(
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
                  subtitle: Text(painting.artist,textAlign: TextAlign.center),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      setState(() {
                        isEditing = true;
                      });
                    },
                  ),
                ),
              ),
              isEditing
                  ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _textEditingController,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: painting.notes.isEmpty ?'Enter your notes...' : painting.notes,
                    border: OutlineInputBorder(),
                  ),
                ),
              )
                  : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  painting.notes.isEmpty ? "Let's add some notes here!": painting.notes,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              if (isEditing)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // TODO save the notes
                        setState(() {
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
    );
  }
}
