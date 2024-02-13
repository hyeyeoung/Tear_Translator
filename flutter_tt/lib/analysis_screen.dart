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
                background: Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 50,
                        color: Colors.lightGreen,
                      ),
                      Expanded(
                        child: Image.asset(
                          'tt_logo.png',
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
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
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index){
                      return Container(
                        alignment: Alignment.center,
                        color: Colors.lightBlue[100 * (index%9)],
                        height: 100.0,
                        child: Text('밥 주세용 T.T'),
                      );
                    },
                  childCount: 20
                ),
            ),
          ],
        )
      ),
    );
  }
}