import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';


class RecordScreen extends StatefulWidget {
  RecordScreen({this.title}) : super();
  final String? title;

  @override
  _RecordScreenState createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  String viewTxt = "Record Player";

  late FlutterSoundRecorder myRecorder;
  late FlutterSoundPlayer myPlayer;
  bool check = false;
  bool playCheck = false;

  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    initializeAudioSessions();
  }

  Future<void> initializeAudioSessions() async {
    try {
      myRecorder = FlutterSoundRecorder();
      await myRecorder.openRecorder();
      //myPlayer = FlutterSoundPlayer();
      //await myPlayer.openAudioSession();
    } catch (e) {
      print('Error initializing audio sessions: $e');
    }
  }

  @override
  void dispose() {
    myRecorder.closeRecorder();
    //myPlayer.closeRecorder();
    super.dispose();
  }

  Future<void> _recordFunction() async {
    try {
      PermissionStatus status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        throw RecordingPermissionException("Microphone permission not granted");
      }

      setState(() {
        viewTxt = "Recording...";
      });

      if (!check) {
        Directory tempDir = await getTemporaryDirectory();
        File outputFile = File('${tempDir.path}/flutter_sound-tmp.aacADTS');

        await myRecorder.startRecorder(
          codec: Codec.aacADTS,
          toFile: outputFile.path,
        );

        print("START");
        setState(() {
          check = true;
        });
      } else {
        print("STOP");
        setState(() {
          viewTxt = "Awaiting...";
          check = false;
        });
        await myRecorder.stopRecorder();
      }
    } catch (e) {
      print('Error recording: $e');
    }
  }

  Future<void> playRecording() async {
    try {
      if (!playCheck) {
        Directory tempDir = await getTemporaryDirectory();
        File inFile = File('${tempDir.path}/flutter_sound-tmp.aacADTS');

        Uint8List dataBuffer = await inFile.readAsBytes();
        setState(() {
          playCheck = true;
        });

        await myPlayer.startPlayer(
          codec: Codec.aacADTS,
          fromDataBuffer: dataBuffer,
          whenFinished: () {
            print('Playback finished');
            setState(() {});
          },
        );
      } else {
        await myPlayer.stopPlayer();
        setState(() {
          playCheck = false;
        });
        print("PLAY STOP!!");
      }
    } catch (e) {
      print('Error playing recording: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text(widget.title ?? ''),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              viewTxt,
              style: Theme.of(context).textTheme.headline4,
            ),
            Container(
              margin: EdgeInsets.all(20.0),
              child: FloatingActionButton(
                onPressed: _recordFunction,
                tooltip: 'Record',
                child: check ? Icon(Icons.stop) : Icon(Icons.play_arrow),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                border: Border.all(width: 2.0, color: Colors.grey[200]!),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                children: <Widget>[
                  Text("Playback Controller\n(Recorded File)"),
                  IconButton(
                    icon: playCheck
                        ? Icon(Icons.stop)
                        : Icon(Icons.play_circle_filled),
                    onPressed: playRecording,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
