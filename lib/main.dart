import 'dart:core';

import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';

void main() => runApp(AnimalSounds());

class AnimalSounds extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Animal Sounds',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
        ),
        body: Animals(),
      ),
    );
  }
}

class Animals extends StatefulWidget {
  @override
  _AnimalsState createState() => _AnimalsState();
}

class _AnimalsState extends State<Animals> {
  int animalSequence = 0;
  var animal = ['cow', 'chicken', 'goat', 'horse'];
  var animalName = 'cow';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SafeArea(
        child: Column(
          children: <Widget>[
            FlatButton(
              onPressed: () {
                setState(() {
                  final audioPlayer = AudioCache();
                  audioPlayer.play('$animalName.wav');
                  print(animal);
                  print(animalSequence);
                  animalSequence++;
                  if (animalSequence < animal.length) {
                    animalName = animal[animalSequence];
                  } else {
                    animalSequence = 0;
                    animalName = animal[animalSequence];
                  }
                });
              },
              child: Image.asset('images/$animalName.png'),
            ),
          ],
        ),
      ),
    );
  }
}
