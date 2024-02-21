import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_tt/file_pick.dart';
import 'package:flutter_tt/file_pick.dart';
import 'package:http/http.dart' as http;

class AnalysisScreen extends StatelessWidget {
  // AnalysisScreen({Key? key}) : super(key: key);

  String title = '';
  String message = '';

  final String result;
  AnalysisScreen({required this.result});

  Future<void> _getData(BuildContext context) async {
    try {
      final contentMap = {
        "hungry": {
          "title": "Hungry",
          "description":
              "When a child cries like this, it can be a sign of hunger. \n Provide a proper meal at your child's age.\n A newborn baby needs feeding approximately every 2-3 hours, and a 6-month-old child can consume solid food every 4-5 hours.\n For children who start feeding, try soft fruit puree or vegetable puree, and for children over the age of 1, try a variety of nutritious meals.\n However, you should avoid foods that are still difficult to digest.\n Make sure your child is getting enough nutrition and, if necessary, consult a pediatrician to adjust his or her meal plan.\n"
        },
        "belly_pain": {
          "title": "Belly Pain",
          "description":
              "The child may be experiencing abdominal pain.\n\n The newborn can experience gas-induced abdominal pain, which can help release gas by gently massaging his or her stomach or moving his or her legs like he or she is riding a bicycle.\n If the child is showing symptoms of constipation or diarrhea, he or she may need to control his or her diet or consult a pediatrician.\n If you are experiencing discomfort due to high gas levels, it is recommended to lean on your shoulder and gently pat your back to remove the gas.\n Also, if you have indigestion, keep the child in a slightly upright position and induce belching.\n Putting a warm pad on the child's stomach can be helpful, too.\n"
        },
        "burping": {
          "title": "Burping",
          "description":
              "If a child does not burp after eating, the gas can make them uncomfortable.\n A child's digestive system is different from that of adults, so burp is an important process to expel air and help with digestion.\n Raise your child up during lactation or meals and gently pat him on the back to induce burp.\n This is especially important for babies who eat liquid food.\n It is recommended that the child not lie down right after lactation, and that they remain upright for 10-15 minutes after lactation.\n"
        },
        "discomfort": {
          "title": "Discomfort",
          "description":
              "When the child feels uncomfortable, there are a number of actions to take.\n First, check your diaper and replace it if necessary.\n Your child may feel uncomfortable, so move him or her into a different position.\n Hugging and calming him or her can give him or her sense of security.\n Check the temperature and environment around you and make sure it is not too hot or cold.\n You can give your child familiar objects or toys to provide stability.\n Even stimulating conditions, such as bright light or loud sounds, can make him or her uncomfortable, so try creating a quiet, dark environment.\n Also, if your child is adjusting, he or she may feel anxious about it, so help him feel secure.\n"
        },
        "tired": {
          "title": "Tired",
          "description":
              "If your child looks tired, try putting him or her to a nap in a quiet, dark environment.\n Darken and quieten the room to help him or her fall asleep comfortably.\n It is also good to gently pat the child and sing him or her a lullaby.\n Using a white noise device makes it easier for him or her to fall asleep.\n It is important to monitor your child's nap pattern to detect tired signals in advance and maintain a regular sleep schedule.\n Getting enough sleep is critical for your growth and development.\n"
        }
      };

      final content = contentMap[result];
      if (content != null) {
        // Store content in variables
        title = content['title'] ?? '';
        message = content['description'] ?? '';
      } else {
        print('No content found for result: $result');
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to fetch data. Please try again.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    _getData(context);

    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text("Tears Translator",
                style: TextStyle(fontFamily: "Anta-Regular")),
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back)),
          ),
          backgroundColor: Colors.deepPurple[100],
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                floating: false,
                expandedHeight: 460,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: BoxDecoration(
                      color: Colors.deepPurple[100],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 180),
                      child: Column(
                        children: [
                          Icon(
                            Icons.mic,
                            size: 100,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            child: const Text('Retry Upload',
                                style: TextStyle(fontFamily: "Anta-Regular")),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => UploadAudioFile()));
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
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
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              title,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 50),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Colors.blueGrey,
                                    // Specify the color of the border
                                    width:
                                        0.5, // Specify the width of the border
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: SizedBox(
                                    height: 10,
                                    child: LinearProgressIndicator(
                                      value: 1,
                                      backgroundColor: Colors.white70,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          const Color.fromRGBO(
                                              179, 157, 219, 1)),
                                      minHeight: 30,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ])),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    alignment: Alignment.center,
                    width: 150,
                    //height: 350.0,
                    child: Expanded(
                      child: Container(
                        margin: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple[200],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        width: 730,
                        // height: 300.0,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(30),
                                child: Text(
                                  message,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w600,
                                      fontFamily:
                                          'Fredoka-VariableFont_wdthwght'),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Divider(),
                              Padding(
                                padding: EdgeInsets.all(30),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Others',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w800,
                                          fontFamily:
                                              'Fredoka-VariableFont_wdthwght',
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        '- Bored:\nPlay with your child, or offer new toys or play activities.\n\n'
                                        '- Check for fever:\nCheck your child\'s temperature to see if he or she has fever.\n\n'
                                        '- Sick:\nYour child may be sick, so if you see any signs of abnormality, go to the hospital and consult.\n\n'
                                        '- Hugging:\n Give your child a sense of security by hugging him affectionately.\n\n'
                                        '- Check external environment:\n Too loud or bright environments can make your child uncomfortable. Create a quiet, dark environment.\n\n'
                                        '- Adjust your clothes:\n Make sure your child is too hot or cold and adjust your clothes.\n\n'
                                        '- Water intake:\n Make sure your child has consumed enough water.\n\n'
                                        '- Avoid stimulating food:\n Make sure your child is not fed stimulating food.\n\n'
                                        '- Maintain regular sleep schedules:\n Maintain your child\'s sleep patterns and put him to sleep on a regular nap.\n\n'
                                        '- Response to sound or light:\n You may be sensitive to strong sounds or bright lights, so observe your child\'s reaction to this\n\n',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15.0,
                                            fontFamily:
                                                'Fredoka-VariableFont_wdthwght'),
                                      ),
                                    ]),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(children: [
                    Container(
                        margin: EdgeInsets.only(left: 20),
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
                            color: Colors.deepPurple[50],
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          height: 150.0,
                          width: 130.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.insert_chart,
                                size: 80,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Child meal record',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        )),
                    Container(
                      margin: EdgeInsets.only(right: 20),
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
                          color: Colors.deepPurple[50],
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        height: 150.0,
                        width: 130.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.library_books,
                              size: 80,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Child growth record',
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
                ]),
              ),
            ],
          )),
    );
  }
}
