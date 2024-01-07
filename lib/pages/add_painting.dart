import 'package:canvasthoughtsflutter/pages/camera.dart';
import 'package:canvasthoughtsflutter/widgets/stateful/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:async';
import 'dart:io';

class AddPainting extends StatefulWidget {
  AddPainting({super.key,
  required this.title,
  required this.artist
  });
  final TextEditingController title;
  final TextEditingController artist;
  @override
  State<AddPainting> createState() => _AddPaintingState();
}

class _AddPaintingState extends State<AddPainting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 60),
                Text(
                  'Add Painting',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.spinnaker(
                    textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1
                    ),
                  ),),
                SizedBox(height: 40),
                Text('Title'),
                SizedBox(height: 2),
                TextField(
                  controller: widget.title,
                  decoration: InputDecoration(
                    labelText: 'Enter title',
                    border: OutlineInputBorder(),
                  ),
                  onSubmitted: (text) {
                    setState(() {
                    });
                  },
                ),
                SizedBox(height: 40),
                Text('Artist'),
                SizedBox(height: 2),
                TextField(
                  controller: widget.artist,
                  decoration: InputDecoration(
                    labelText: 'Enter name of the artist',
                    border: OutlineInputBorder(),
                  ),
                  onSubmitted: (text) {
                    setState(() {
                    });
                  },
                ),
                SizedBox(height:40),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/search-paintings');
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.purple[200],
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15), // Rounded corners
                      ),
                    ),
                    child: Text(
                      'Search',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40),
                Text(
                  "Or just scan the painting's caption!",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.spinnaker(
                    textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1
                    ),),
                ),
                SizedBox(height: 40),
                Center(
                  child: FloatingActionButton(
                    onPressed: ()async{
                      WidgetsFlutterBinding.ensureInitialized();
                      final cameras = await availableCameras();
                      final firstCamera = cameras.first;
                      Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Camera(
                        camera: firstCamera,
                      ))
                      );
                    },
                    backgroundColor: Colors.purple[200],
                    elevation: 3,
                    shape: CircleBorder(),
                    child: Icon(Icons.photo_camera, size: 35),
                  ),
                )
              ]
          ),
        ),

      ),
      bottomNavigationBar: MyBottomNavigationBar(parentContext: context,currentIndex: 2),
    );
  }
}


