import 'package:canvasthoughtsflutter/pages/main/add_painting.dart';
import 'package:canvasthoughtsflutter/services/imageToText.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:io';





class Camera extends StatefulWidget {
  const Camera({
    super.key,
    required this.camera,
  });

  final CameraDescription camera;

  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera> {

  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
      imageFormatGroup: ImageFormatGroup.nv21

    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Take a picture'),
        centerTitle: true,
        leading:
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.pushReplacementNamed(context,'/add-painting');
            },
          )
        ,
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            await _initializeControllerFuture;
            _controller.setFlashMode(FlashMode.off);
            final image = await _controller.takePicture();

            if (!mounted) return;

            await Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(
                  imagePath: image.path,
                ),
              ),
                    (Route route) => false
            );
          } catch (e) {
            print(e);
          }
        },
        backgroundColor: Colors.purple[200],
        elevation: 3,
        shape: CircleBorder(),
        child: const Icon(Icons.photo_camera, size: 35),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: Container(
        height: 60,
      ),
    );
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;
  //String
  const DisplayPictureScreen({super.key,
    required this.imagePath,
    });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Make sure the picture is clear!')),
      body: Image.file(File(imagePath)),
      floatingActionButton: ElevatedButton(
        child: Text('OK'),
        style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: Colors.purple[200],
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15), // Rounded corners
            )
        ),
        onPressed: ()async{
          List<String> result = await search_image(imagePath);
          TextEditingController title = new TextEditingController();
          TextEditingController artist = new TextEditingController();
          title.text = result[0];
          artist.text = result[1];
          print(result[0]);
          Navigator.pushReplacement(context,MaterialPageRoute (
            builder: (context) => AddPainting(
              title: title,
              artist: artist,
            ),
          )
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: Container(
        height: 60,
      ),
    );
  }
}



