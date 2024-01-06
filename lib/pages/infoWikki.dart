import 'package:canvasthoughtsflutter/services/get_wikki_info.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/painting.dart';


class WikkiInfo extends StatefulWidget {
  const WikkiInfo({super.key});

  @override
  State<WikkiInfo> createState() => _WikkiInfoState();
}


class _WikkiInfoState extends State<WikkiInfo> {
  String information = "Loading... please wait.";
  Map<dynamic, dynamic> data = {};
  late Painting painting;
  late bool hasInfo = false;

  void setInfo() async{
    try {
      String info = await searchPaintingInfo(painting.title, painting.artist);
      setState(() {
        hasInfo = true;
        information = info;
      });
    } catch (error) {
      print('Error fetching Wikipedia information: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute
        .of(context)
        ?.settings
        .arguments as Map;
    painting = data['painting'];
    if (!hasInfo) {
      setInfo();
    }

    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Painting Information',
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
                ),
              ),
               Padding(
                padding: const EdgeInsets.all(19.0),
                child: Text(
                  information,
                  style: TextStyle(
                    fontSize: 19,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
