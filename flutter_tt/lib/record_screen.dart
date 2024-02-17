import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'dart:async';
import 'package:flutter_tt/analysis_screen.dart';

class RecordScreen extends StatelessWidget {
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder(); // _recorder 변수 선언 및 초기화

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
              SizedBox(height: 20,),
              ElevatedButton(
                child: const Text('Recording start'),
                onPressed: () {
                  _startRecording(context);
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
      _recorder.startRecorder(toFile: 'audio.mp4');
      print('Recording started');

      // 녹음 중 메시지 표시
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('녹음 중입니다...'),
        ),
      );

      // 7초 후에 녹음 종료
      Timer(Duration(seconds: 7), () {
        _stopRecording(context);
      });
    } catch (e) {
      print('Error starting recording: $e');
    }
  }

  void _stopRecording(BuildContext context) async {
    try {
      String? path = await _recorder.stopRecorder(); // 녹음 종료

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