import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/stateful/navigation_bar.dart';
import '../../widgets/stateless/logo.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String description = 'René Magritte, the surrealist painter, '
      'had a peculiar habit of painting in a suit and tie, even in the privacy '
      'of his studio. He believed it helped him maintain a professional mindset.';
  String image = 'rene_magritte.jpg';

  @override
  Widget build(BuildContext context) {
    double imageHeight = MediaQuery.of(context).size.height * (2 / 5);
    double imageWidth = MediaQuery.of(context).size.width * (7 / 9);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Logo(),
              SizedBox(height: 35),
              Text(
                'Artistic Fact Of The Day',
                style: GoogleFonts.patuaOne(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 24,
                    letterSpacing: 1.6,
                  ),
                ),
              ),
              SizedBox(height: 15),
              Container(
                height: imageHeight,
                width: imageWidth,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 6.0,
                    ),
                    image: DecorationImage(
                      image: AssetImage('assets/$image'),
                      fit: BoxFit.cover,
                    )),
              ),
              SizedBox(height:20),
              Container(
                height: imageHeight,
                width: imageWidth,
                child: Text(
                  description,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.spinnaker(
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: MyBottomNavigationBar(parentContext: context,currentIndex: 1),
    );
  }
}
