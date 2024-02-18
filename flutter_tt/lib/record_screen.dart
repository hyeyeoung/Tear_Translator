import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class RecordScreen extends StatefulWidget {
  RecordScreen({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  _RecordScreenState createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  String viewTxt = "Recorde Player";

  late FlutterSoundRecorder myRecorder;
  late FlutterSoundPlayer myPlayer;
  bool isRecording  = false;
  bool isPlaying  = false;

  @override
  void initState() {
    super.initState();
    myRecorder = FlutterSoundRecorder();
    myPlayer = FlutterSoundPlayer();
  }

  @override
  void dispose() {
    myRecorder.closeRecorder();
    myPlayer.closePlayer();
    super.dispose();
  }


  Future<void> _recodeFunc() async {
    if (!isRecording) {
      PermissionStatus status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Microphone permission not granted"),
          ),
        );
        return;
      }
      setState(() {
        viewTxt = "Recording...";
        isRecording = true;
      });
      try {
        Directory tempDir = await getTemporaryDirectory();
        File outputFile = File('${tempDir.path}/flutter_sound_recording.aac');
        await myRecorder.startRecorder(
          toFile: outputFile.path,
          codec: Codec.aacADTS,
        );
        print("Recording Started");
      } catch (e) {
        print("Recording Error: $e");
      }
    } else {
      setState(() {
        viewTxt = "Stopping...";
        isRecording = false;
      });
      await myRecorder.stopRecorder();
      print("Recording Stopped");
    }
  }

  Future<void> playMyFile() async {
    if (!isPlaying) {
      try {
        Directory tempDir = await getTemporaryDirectory();
        File inFile = File('${tempDir.path}/flutter_sound_recording.aac');
        if (!await inFile.exists()) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Recording not found"),
            ),
          );
          return;
        }
        Uint8List dataBuffer = await inFile.readAsBytes();
        await myPlayer.startPlayerFromBuffer(dataBuffer);
        await myPlayer.startPlayerFromBufferWithCodec(dataBuffer, codec: Codec.aacADTS);
        setState(() {
          viewTxt = "Playing...";
          isPlaying = true;
        });
        print("Playing Started");
      } catch (e) {
        print("Playing Error: $e");
      }
    } else {
      await myPlayer.stopPlayer();
      setState(() {
        viewTxt = "Record Player";
        isPlaying = false;
      });
      print("Playing Stopped");
    }
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text(widget.title ?? "Default Title"),
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            viewTxt,
            style: Theme
                .of(context)
                .textTheme
                .headline4,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _recodeFunc,
            child: Text(isRecording ? "Stop Recording" : "Start Recording"),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: playMyFile,
            child: Text(isPlaying ? "Stop Playing" : "Start Playing"),
          ),
        ],
      ),
    ),
  );
}}
