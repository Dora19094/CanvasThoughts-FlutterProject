import 'package:canvasthoughtsflutter/models/painting.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/searchPaintingsService.dart';

class SearchPaintingsList extends StatefulWidget {
  const SearchPaintingsList({super.key});

  @override
  State<SearchPaintingsList> createState() => _SearchPaintingsListState();
}

class _SearchPaintingsListState extends State<SearchPaintingsList> {
  List<Painting> searchPaintings = [];

  Future<void> fetchSearchedPaintings() async {
    try {
      List<Painting> search = await fetchSpecificPaintings();
      setState(() {
        searchPaintings = search;
      });
      print('We have fetched ${searchPaintings.length}');
    } catch (error) {
      print('Error fetching searched paintings: $error');
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchSearchedPaintings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 30),
          Text(
            'Select your painting!',
            textAlign: TextAlign.center,
            style: GoogleFonts.spinnaker(
              textStyle: TextStyle(
                color: Colors.black,
                fontSize: 24,
                letterSpacing: 0.5
              ),
          )
          ),
          Expanded(
            child: Scrollbar(
              thumbVisibility: true,
              thickness: 10,
              radius: Radius.circular(8),
              child: ListView.builder(
                itemCount: searchPaintings.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                    child: SizedBox(
                      height: 130,
                      child: Card(
                        child: ListTile(
                          onTap: () {
                            Navigator.pushNamed(context,'/save-painting',arguments: {'selectedPainting': searchPaintings[index]});
                          },
                          leading: Container(
                            width: 70,
                            height: 100,
                            color: Colors.black,
                            child: Image.network(
                              searchPaintings[index].imageUrl,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                          title: Padding(
                            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  searchPaintings[index].title,
                                  style: GoogleFonts.spinnaker(
                                    textStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 24,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                                Text(
                                  searchPaintings[index].artist,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Material(
            elevation: 40,
            child: Column(
              children: [
                SizedBox(height: 15,width:MediaQuery.of(context).size.width),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'),
                ),
                SizedBox(height: 15,width:MediaQuery.of(context).size.width),
              ],
            ),
          )
        ],
      ),
    );
  }
}
