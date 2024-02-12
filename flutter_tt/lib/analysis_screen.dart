import 'package:flutter/material.dart';
import 'package:flutter_tt/record_screen.dart';

class AnalysisScreen extends StatelessWidget {
  const AnalysisScreen({Key? key}) : super(key:key);

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
          child:
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.record_voice_over_rounded,
                  size: 100,),
                SizedBox(height: 20,),
                ElevatedButton(
                  child: const Text('녹음하기'),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_) => RecordScreen()));

                  },
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(16),
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hungry',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '배가고파요 T.T',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        '82%',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        '아이에게 밥을 주세요',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
          ),
        ),
      ),
    );
  }
}