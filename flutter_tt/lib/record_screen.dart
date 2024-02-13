import 'package:flutter/material.dart';
import 'package:flutter_tt/analysis_screen.dart';
import 'package:flutter_tt/recording_screen.dart';
import 'package:lottie/lottie.dart';

class RecordScreen extends StatelessWidget {
  const RecordScreen({Key? key}) : super(key:key);

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Tears Translator"),
          leading: IconButton(onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back)),
        ),
        backgroundColor: Color.fromARGB(100, 41, 109, 182),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.record_voice_over_rounded,
              size: 100,),
              SizedBox(height: 20,),
              ElevatedButton(
                child: const Text('녹음하기'),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_) => RecordingScreen()));

                },
              )
            ],
          ),
        ),

      ),
    );
  }
}