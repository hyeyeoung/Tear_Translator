import 'dart:convert'; // JSON 처리를 위해 필요
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_tt/analysis_screen.dart'; // 결과 페이지 임포트
import 'package:http/http.dart' as http;

class UploadAudioFile extends StatefulWidget {
  @override
  _UploadAudioFileState createState() => _UploadAudioFileState();
}

class _UploadAudioFileState extends State<UploadAudioFile> {
  // bool _isPickingFile = false;

  void _pickAndUploadFile() async {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.audio,
      );

      if (result != null) {
        Uint8List? fileBytes = result.files.single.bytes;
        String fileName = result.files.single.name;
        _uploadFile(fileBytes, fileName);
      } else {
        print('No file selected.');
      }
    
  }

  void _uploadFile(Uint8List? fileBytes, String fileName) async {
    if(fileBytes == null){
      print("file bytes are null");
      return;
    }
    var uri = Uri.parse('http://127.0.0.1:8000/upload');
    var request = http.MultipartRequest('POST', uri)
      ..files.add(http.MultipartFile.fromBytes(
        'audioFile',
        fileBytes,
        filename: fileName,
      ));

    var response = await request.send();

    if (response.statusCode == 200) {
      // 서버 응답 처리
      response.stream.bytesToString().then((responseString) {
        var responseData = json.decode(responseString);
        var result = responseData['result']; // 'hungry' 값을 추출

        // 결과값을 다음 페이지에 전달하며 이동
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AnalysisScreen(result: result),
          ),
        );
      });
    } else {
      print('File upload failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text('Upload Audio File'),
    //   ),
    //   body: Center(
    //     child: ElevatedButton(
    //       onPressed: _pickAndUploadFile,
    //       child: Text('Select and Upload Audio File'),
    //     ),
    //   ),
    // );
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromARGB(100, 41, 109, 182),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/tt_logo.png'),
              SizedBox(height: 20,),
              ElevatedButton(
                onPressed: _pickAndUploadFile, 
                child: Text('select and Upload Audio File'),
                )
            ]
            ),
        ),
      ),
    );
  }
}
