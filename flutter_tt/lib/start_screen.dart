import 'package:flutter/material.dart';
import 'package:flutter_tt/record_screen.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            backgroundColor: Color.fromARGB(100, 41, 109, 182),
            body : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/tt_logo.png'),
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