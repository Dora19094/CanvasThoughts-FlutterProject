import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/museum.dart';
import '../../models/painting.dart';
import '../../services/databaseCruds/paintingService.dart';

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
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: SizedBox(
                    height: 130,
                    child: Card(
                      child: ListTile(
                        onTap: () {
                          Navigator.pushNamed(context, '/painting-notes',arguments: {'painting': paintings[index]});
                        },
                        leading: Container(
                          width: 70,
                          height: 100,
                          color: Colors.black,
                          child: Image.network(
                            paintings[index].imageUrl,
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                        title: Padding(
                          padding: const EdgeInsets.fromLTRB(7, 0, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                paintings[index].title,
                                style: GoogleFonts.spinnaker(
                                  textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 22,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                              Text(
                                paintings[index].artist,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () async{
                            await deletePainting(paintings[index].paintingId);
                            setState(() {
                              paintings.remove(paintings[index]);
                            });
                          },
                        ),
                        contentPadding: EdgeInsets.all(5),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
