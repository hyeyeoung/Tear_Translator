import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late String _filePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('음성 녹음 및 전송'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _startRecording,
              child: Text('녹음 시작'),
            ),
            ElevatedButton(
              onPressed: _stopRecording,
              child: Text('녹음 종료'),
            ),
            ElevatedButton(
              onPressed: _uploadFile,
              child: Text('파일 전송'),
            ),
          ],
        ),
      ),
    );
  }

  void _startRecording() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    _filePath = '${appDocDir.path}/audio_record.wav';
    // 녹음을 시작하는 코드를 추가
  }

  void _stopRecording() {
    // 녹음을 종료하는 코드를 추가
  }

  void _uploadFile() async {
    if (_filePath != null && File(_filePath).existsSync()) {
      var request = http.MultipartRequest('POST', Uri.parse('YOUR_FLASK_SERVER_URL'));
      request.files.add(await http.MultipartFile.fromPath('audio', _filePath));
      
      try {
        var response = await request.send();
        if (response.statusCode == 200) {
          print('파일 전송 성공');
        } else {
          print('파일 전송 실패: ${response.reasonPhrase}');
        }
      } catch (e) {
        print('오류 발생: $e');
      }
    } else {
      print('파일이 존재하지 않습니다.');
    }
  }
}
