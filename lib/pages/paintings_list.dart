import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/museum.dart';
import '../models/painting.dart';
import '../services/view_paintings.dart';

class ViewPaintingsList extends StatefulWidget {
  const ViewPaintingsList({super.key});

  @override
  State<ViewPaintingsList> createState() => _ViewPaintingsListState();
}

class _ViewPaintingsListState extends State<ViewPaintingsList> {
  Map data = {};
  late Museum museum;
  List<Painting> paintings = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchPaintings();
  }

  Future<void> fetchPaintings() async {
    data = ModalRoute.of(context)?.settings.arguments as Map;
    museum = data['museum'];
    try {
      List<Painting> fetchedPaintings = await getPaintings(museum.museumId);
      setState(() {
        paintings = fetchedPaintings;
      });
    } catch (error) {
      print('Error fetching paintings: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          museum.name,
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
              itemCount: paintings.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 70),
                  child: Card(
                      child: ListTile(
                    onTap: () {
                      //TODO navigate to view painting
                    },
                    title: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        paintings[index].title,
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
    );
  }
}
