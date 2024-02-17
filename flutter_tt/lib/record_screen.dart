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
  bool check = false;
  bool playCheck = false;

  @override
  void initState() {
    Future.microtask(() async{
      myRecorder = FlutterSoundRecorder();
      await FlutterSoundRecorder().openRecorder();
      myPlayer = FlutterSoundPlayer();
    });
    super.initState();
  }

  @override
  void dispose(){
    myRecorder.closeRecorder();
    myPlayer.closePlayer();
    super.dispose();
  }


  Future<void> _recodeFunc() async{
    PermissionStatus status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) throw RecordingPermissionException("Microphone permission not granted");
    setState(() {
      viewTxt = "Recoding ~";
    });
    if(!check){
      Directory tempDir = await getTemporaryDirectory();
      File outputFile = File('${tempDir.path}/flutter_sound-tmp.aacADTS');
      await myRecorder.startRecorder(toFile: outputFile.path,codec: Codec.aacADTS);
      print("START");
      setState(() {
        check = !check;
      });
      return;
    }
    print("STOP");
    setState(() {
      check = !check;
      viewTxt = "await...";
    });
    await myRecorder.stopRecorder();
    return;
  }

  Future<void> playMyFile(BuildContext context) async{
    if(!playCheck){
      Directory tempDir = await getTemporaryDirectory();
      File inFile = File('${tempDir.path}/flutter_sound-tmp.aacADTS');
      try{
        Uint8List dataBuffer = await inFile.readAsBytes();
        print("dataBuffer $dataBuffer");
        setState(() {
          playCheck = !playCheck;
        });
        await this.myPlayer.startPlayer(
            fromDataBuffer: dataBuffer,
            codec: Codec.aacADTS,
            whenFinished: () {
              print('Play finished');
              setState(() {});
            });
      }
      catch(e){
        print(" NO Data");
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("NO DATA!!!!!!"),
            )
        );
      }
      return;
    }
    await myPlayer.stopPlayer();
    setState(() {
      playCheck = !playCheck;
    });
    print("PLAY STOP!!");
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
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
                onPressed: _recodeFunc,
                tooltip: 'Increment',
                child: check ? Icon(Icons.stop) :Icon(Icons.play_arrow),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                  border: Border.all(width: 2.0, color: Colors.grey[200]!),
                  borderRadius: BorderRadius.circular(15.0)
              ),
              child: Column(
                children: <Widget>[
                  Text("Play Controller\n(Recorde File)"),
                  IconButton(
                    icon: playCheck ? Icon(Icons.stop) : Icon(Icons.play_circle_filled),
                    onPressed: () async{
                      await playMyFile(context);
                    },
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
