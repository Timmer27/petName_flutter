import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class PetNameInfo extends StatelessWidget {
  final XFile image;
  final String imagePath;

  PetNameInfo({required this.image, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            // Navigator.pop(context);
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                    width: screenWidth * 0.85,
                    height: screenHeight * 0.7,
                    child: Image.asset('images/dog2.png')
                    // child: Image.file(File(imagePath)),
                    ),
                Container(
                  child: Text('species info description'),
                ),
                Container(
                  child: Text('species personality description'),
                ),
                Container(
                  child: Text('species name recommendation'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
