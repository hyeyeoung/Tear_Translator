import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_tt/recording_screen.dart';
import 'package:http/http.dart' as http;

class AnalysisScreen extends StatelessWidget {
  AnalysisScreen({Key? key}) : super(key: key);

  String title = '';
  String message = '';

  Future<void> _getData(BuildContext context) async {
    try {
      final url = Uri.parse('http://127.0.0.1:8000/upload');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print('Received data: $responseData');
        final result = responseData['result'] as String;

        final contentMap = {
          "hungry": {
            "title": "Hungry",
            "description":
                "아이가 이렇게 울면 배고픔의 신호일 수 있습니다. 아이의 나이에 맞춰 적절한 식사를 제공하세요. 신생아는 대략 2-3시간 마다 수유가 필요하며, 6개월 된 아이는 4-5시간마다 고체 음식을 섭취할 수 있습니다. 이유식을 시작하는 아이에게는 부드러운 과일 퓌레나 야채 퓌레를 시도해 볼 수 있고, 1세 이상의 아이에게는 다양한 영양가 있는 식사를 제공해보세요. 단, 아직 소화하기 어려운 음식은 피해야 합니다. 아이가 충분한 영양을 섭취하고 있는지 확인하고, 필요하다면 소아과 의사와 상담하여 아이의 식사량과 식사 계획을 조절하세요."
          },
          "bellyPain": {
            "title": "Belly Pain",
            "description": "불편해요\n기저귀를 갈아주세요."
          },
        };

        final content = contentMap[result];
        if (content != null) {
          // Store content in variables
          title = content['title'] ?? '';
          message = content['message'] ?? '';
        } else {
          print('No content found for result: $result');
        }
      } else {
        print('Failed to fetch data. Error: ${response.reasonPhrase}');
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
            title: const Text("Tears Translator"),
            leading: IconButton(
                onPressed: () {
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
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(100, 105, 160, 219),
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
                            child: const Text('다시 녹음하기'),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => RecordingScreen()));
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
                                      value: 0.82,
                                      backgroundColor: Colors.white70,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Color.fromARGB(100, 84, 133, 186)),
                                      minHeight: 30,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ])),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    alignment: Alignment.center,
                    width: 150,
                    //height: 350.0,
                    child: Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(100, 84, 133, 186),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        width: 500,
                        //height: 300.0,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  message,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  '- 심심함: 아이와 함께 놀아주거나, 새로운 장난감이나 놀이 활동을 제공하세요.\n'
                                      '- 발열 여부 확인: 아이의 체온을 측정하여 발열이 있는지 확인하세요.\n'
                                      '- 아픔: 아이가 아플 수 있으니, 이상 징후가 보인다면 병원에 가서 상담하세요.\n'
                                      '- 안아주기: 아이를 다정하게 안아주어 안정감을 제공하세요.\n'
                                      '- 외부 환경 확인: 너무 시끄럽거나 밝은 환경은 아이를 불편하게 할 수 있습니다. 조용하고 어두운 환경을 만들어보세요.\n'
                                      '- 옷차림 조절: 아이가 너무 덥거나 추운지 확인하고 옷차림을 조절하세요.\n'
                                      '- 수분 섭취: 아이가 충분한 수분을 섭취했는지 확인하세요.\n'
                                      '- 자극적인 음식 피하기: 아이에게 자극적인 음식을 주지 않았는지 확인하세요.\n'
                                      '- 정기적인 수면 스케줄 유지: 아이의 수면 패턴을 유지하고 정기적인 낮잠을 재워주세요.\n'
                                      '- 소리나 빛에 대한 반응: 강한 소리나 밝은 빛에 민감할 수 있으니, 이에 대한 아이의 반응을 관찰하세요.\n',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(children: [
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
                            color: Color.fromARGB(100, 105, 160, 219),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          height: 150.0,
                          width: 150.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.insert_chart,
                                size: 100,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                '아이 밥 기록 체크',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        )),
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
                          color: Color.fromARGB(100, 105, 160, 219),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        height: 150.0,
                        width: 150.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.library_books,
                              size: 100,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              '아이 성장 기록',
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
