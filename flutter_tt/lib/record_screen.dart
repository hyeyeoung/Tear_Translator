import 'package:flutter/material.dart';
import 'package:flutter_tt/recording_screen.dart';

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
        backgroundColor: Color.fromARGB(100, 105, 160, 219),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.mic,
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