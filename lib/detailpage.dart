import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:text_to_speech_example/model/places.dart';

class DetailPage extends StatefulWidget {
  final Places places;

  DetailPage({Key key, this.places}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<DetailPage> {
  FlutterTts flutterTts;
  dynamic languages;
  dynamic voices;
  String language;
  String voice;

  //background music
  static AudioPlayer audioPlayer = new AudioPlayer();
  static AudioCache player = new AudioCache(fixedPlayer: audioPlayer);
  static const audioPath = "violin_and_guitar.mp3";

  TtsState ttsState = TtsState.stopped;

  get isPlaying => ttsState == TtsState.playing;

  get isStopped => ttsState == TtsState.stopped;

  @override
  initState() {
    super.initState();
    initTts();
  }

  initTts() {
    flutterTts = FlutterTts();

    if (Platform.isAndroid) {
      flutterTts.ttsInitHandler(() {
        _getLanguages();
        _getVoices();
      });
    } else if (Platform.isIOS) {
      _getLanguages();
    }

    flutterTts.setStartHandler(() {
      setState(() {
        ttsState = TtsState.playing;
      });
    });

    flutterTts.setCompletionHandler(() {
      setState(() {
        ttsState = TtsState.stopped;
        audioPlayer.stop();
      });
    });

    flutterTts.setErrorHandler((msg) {
      setState(() {
        ttsState = TtsState.stopped;
      });
    });
  }

  Future _getLanguages() async {
    languages = await flutterTts.getLanguages;
    if (languages != null) setState(() => languages);
  }

  Future _getVoices() async {
    voices = await flutterTts.getVoices;
    if (voices != null) setState(() => voices);
  }

  Future _speak() async {
    player.play(audioPath);
    var result = await flutterTts.speak(widget.places.description);
    if (result == 1) setState(() => ttsState = TtsState.playing);
  }

  Future _stop() async {
    audioPlayer.stop();
    var result = await flutterTts.stop();
    if (result == 1) setState(() => ttsState = TtsState.stopped);
  }

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
    audioPlayer.stop();
  }

  @override
  Widget build(BuildContext context) {
    final topAppBar = AppBar(
      elevation: 0.1,
      backgroundColor: Colors.deepOrangeAccent,
      title: Text("Detail"),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.list),
          onPressed: () {},
        )
      ],
    );

    return Scaffold(appBar: topAppBar, body: descriptionLayoutWidget());
  }

  Widget descriptionLayoutWidget() {
    return Column(
      children: <Widget>[
        new Text(
          widget.places.description,
          style: new TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 16.0,
          ),
        ),
        new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new RaisedButton(
              padding: const EdgeInsets.all(8.0),
              textColor: Colors.white,
              color: Colors.green,
              onPressed: _speak,
              child: new Text("Speak"),
            ),
            new RaisedButton(
              onPressed: _stop,
              textColor: Colors.white,
              color: Colors.red,
              padding: const EdgeInsets.all(8.0),
              child: new Text(
                "Stop",
              ),
            ),
          ],
        )
      ],
    );
  }
}

enum TtsState { playing, stopped }
