import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            border: Border.all(
              color: Colors.black,
              width: 5,
            ),
          ),
          child:Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 8, 8),
            child: Text(
              'Canvas Thoughts',
              style: GoogleFonts.patuaOne(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 32,
                    letterSpacing: 1.6,
                  )
              ),
            ),
          )
      ),
    );
  }
}
