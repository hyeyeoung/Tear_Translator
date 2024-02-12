import 'package:flutter/material.dart';
import 'package:flutter_tt/record_screen.dart';
import 'package:flutter_tt/analysis_screen.dart';

void main() {
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Navigator',
      home: Scaffold(
        backgroundColor: Color.fromARGB(100, 41, 109, 182),
        body : Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('logo.png'),
                SizedBox(height: 20,),
                ElevatedButton(
                    child: const Text('Start'),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_) => RecordScreen()));
                  },
                )
              ],
          ),
        )
      )
    );
  }
}
