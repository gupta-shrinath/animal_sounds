import 'dart:core';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
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

class _AnimalsState extends State<Animals> with WidgetsBindingObserver {
  int animalSequence = 0;
  var animal = ['cow', 'chicken', 'goat', 'horse'];
  var animalName = 'cow';
  static AudioCache _audioCache = AudioCache();
  static AudioPlayer _audioPlayer;

  void changeAnimal() async {
    _audioPlayer.stop();
    animalSequence++;
    if (animalSequence < animal.length) {
      animalName = animal[animalSequence];
    } else {
      animalSequence = 0;
      animalName = animal[animalSequence];
      playAnimalSound();
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _audioPlayer.stop();
    }
  }

  void playAnimalSound() async {
    _audioPlayer?.release();
    _audioPlayer = await _audioCache.play('$animalName.wav');
  }

  @override
  Widget build(BuildContext context) {
    playAnimalSound();
    return Center(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('images/$animalName.png'),
            SizedBox(
              height: 35.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 250.0),
              child: GestureDetector(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        Color(0xFF0D47A1),
                        Color(0xFF1976D2),
                        Color(0xFF42A5F5),
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 30.0),
                  child: const Text(
                    'Next',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                onTap: () {
                  setState(() {
                    changeAnimal();
                  });
                },
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 250.0),
              child: GestureDetector(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        Color(0xFF0D47A1),
                        Color(0xFF1976D2),
                        Color(0xFF42A5F5),
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 5.0),
                  child: const Text(
                    'Play Again',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                onTap: () {
                  playAnimalSound();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
