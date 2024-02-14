import 'package:flutter/material.dart';
import 'package:flutter_tt/record_screen.dart';

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
                    padding: const EdgeInsets.only(top: 60),
                    child: Column(
                      children: [
                        Expanded(
                          child: Image.asset(
                            'record.png',
                            width: screenWidth * 0.616666,
                            height: screenHeight * 0.0859375,
                          ),
                        ),
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
                    alignment: Alignment.center,
                    color: Colors.red,
                    width: 150,
                    height: 100.0,
                    child: Text('밥 주세용 T.T'),
                ),
                Container(
                    alignment: Alignment.center,
                    color: Colors.purple,
                    height: 150.0
                ),
                Container(
                    alignment: Alignment.center,
                    color: Colors.green,
                    height: 200.0
                ),
                Row(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      color: Colors.blue,
                      height: 200.0,
                      width: MediaQuery.of(context).size.width / 2,
                  ),
                    Container(
                        alignment: Alignment.center,
                        color: Colors.pink,
                        height: 200.0,
                      width: MediaQuery.of(context).size.width / 2,
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