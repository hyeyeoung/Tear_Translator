import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'dart:async';
import 'dart:io'; // Add this import for File class
import 'package:flutter_tt/analysis_screen.dart';

class RecordScreen extends StatelessWidget {
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  bool _isRecording = false; // Added variable to track recording state

  RecordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Tears Translator"),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
          ),
        ),
        backgroundColor: Color.fromARGB(100, 105, 160, 219),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.mic, size: 100,),
              SizedBox(height: 20,), // Corrected typo and added comma
              ElevatedButton(
                child: _isRecording ? Text('Recording...') : Text('Start Recording'),
                onPressed: () {
                  if (!_isRecording) {
                    _startRecording(context);
                  } else {
                    _stopRecording(context);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void _startRecording(BuildContext context) async {
    try {
      await _recorder.openAudioSession();
      await _recorder.startRecorder(toFile: 'audio.mp4');
      print('Recording started');
      _isRecording = true; // Update recording state

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Recording...'),
        ),
      );

      Timer(Duration(seconds: 7), () {
        _stopRecording(context);
      });
    } catch (e) {
      print('Error starting recording: $e');
    }
  }

  void _stopRecording(BuildContext context) async {
    try {
      _isRecording = false; // Update recording state
      String? path = await _recorder.stopRecorder();
      String newPath = 'assets/tt.mp4';
      File originalFile = File(path!);
      File newFile = await originalFile.rename(newPath);

      print('File moved to: ${newFile.path}');
      print('Recording stopped: $path');

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AnalysisScreen()),
      );
    } catch (e) {
      print('Error stopping recording: $e');
    }
  }
}