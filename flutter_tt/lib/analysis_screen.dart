import 'package:flutter/material.dart';
import 'package:flutter_tt/recording_screen.dart';

class AnalysisScreen extends StatelessWidget {
  const AnalysisScreen({Key? key}) : super(key:key);

  @override
  Widget build(BuildContext context){
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

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
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              floating: false,
              expandedHeight: 460,
              leading: IconButton(
                focusColor: Colors.black12,
                icon: const Icon(Icons.menu),
                tooltip:  'AppBar Menu',
                onPressed:  (){},
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(100, 41, 109, 182),
                  ),
                  child : Padding(
                    padding: const EdgeInsets.only(top: 180),
                    child: Column(
                      children: [
                        Icon(Icons.mic,
                          size: 100,),
                        SizedBox(height: 20,),
                        ElevatedButton(
                          child: const Text('다시 녹음하기'),
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (_) => RecordingScreen()));

                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
              actions: [
                IconButton(
                  onPressed: (){},
                  icon: const Icon(Icons.search),
                  tooltip: 'AppBar Search',
                ),
                IconButton(
                  onPressed: (){},
                  icon: const Icon(Icons.more_vert),
                  tooltip: 'AppBar More',
                ),
              ],
            ),
            SliverList(
                delegate: SliverChildListDelegate([
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                        bottomLeft: Radius.zero,
                        bottomRight: Radius.zero,
                      ),
                    ),
                    alignment: Alignment.center,
                    width: 50,
                    height: 100.0,
                    child : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                      children : [
                        Text(
                          '82%    Hungry',
                          style: TextStyle(
                          color: Colors.black,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 50),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.blueGrey, // Specify the color of the border
                                  width: 0.5, // Specify the width of the border
                                ),
                              ),
                              child : ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: SizedBox(
                                  height: 10,
                                  child:  LinearProgressIndicator(
                                    value: 0.82,
                                    backgroundColor: Colors.white70,
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blueGrey),
                                    minHeight: 30,
                                  ),
                                ),
                              ),
                            ),
                        ),
                      ]
                    )
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                    ),
                    alignment: Alignment.center,
                    width: 150,
                    height: 150.0,
                    child: Text(
                      '밥 주세용 T.T',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                      alignment: Alignment.center,
                      color: Colors.green,
                      height: 200.0
                  ),
                  Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.zero,
                              topRight: Radius.zero,
                              bottomLeft: Radius.circular(10.0),
                              bottomRight: Radius.zero,
                            ),
                          ),
                          alignment: Alignment.center,
                          height: 200.0,
                          width: MediaQuery.of(context).size.width / 2,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              height: 150.0,
                              width: 150.0,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.insert_chart,
                                    size: 100,),
                                  SizedBox(height: 20,),
                                  Text(
                                    '아이 밥 기록 체크',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            )
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.zero,
                              topRight: Radius.zero,
                              bottomLeft: Radius.zero,
                              bottomRight: Radius.circular(10.0),
                            ),
                          ),
                          alignment: Alignment.center,
                          height: 200.0,
                          width: MediaQuery.of(context).size.width / 2,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            height: 150.0,
                            width: 150.0,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.library_books,
                                  size: 100,),
                                SizedBox(height: 20,),
                                Text(
                                  '아이 성장 기록',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]
                  ),
                ]),
              ),
          ],
        )
      ),
    );
  }
}