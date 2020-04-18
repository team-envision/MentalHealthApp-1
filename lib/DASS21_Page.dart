import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:mental_health_app/BACE_Page.dart';
import 'package:mental_health_app/question.dart';

import 'Showup.dart';

class Dass21Page extends StatefulWidget {
  @override
  _Dass21PageState createState() => _Dass21PageState();
}

class _Dass21PageState extends State<Dass21Page> {
  SwiperController _controller = SwiperController();
  List<Question> DASS21_Questions = [
    Question(),
    Question(),
    Question(),
    Question(),
    Question(),
    Question(),
    Question(),
    Question(),
    Question(),
    Question(),
    Question(),
    Question(),
    Question(),
    Question(),
    Question(),
    Question(),
    Question(),
    Question(),
    Question(),
    Question(),
    Question(),
  ];

  List<String> questions = [
    "I found it hard to wind down",
    "I was aware of dryness of my mouth",
    "I couldn’t seem to experience any positive feeling at all",
    "I experienced breathing difficulty (eg, excessively rapid breathing,breathlessness in the absence of physical exertion)",
    "I found it difficult to work up the initiative to do things",
    "I tended to over-react to situations",
    "I experienced trembling (eg, in the hands)",
    "I felt that I was using a lot of nervous energy",
    "I was worried about situations in which I might panic and make a fool of myself",
    "I felt that I had nothing to look forward to",
    "I found myself getting agitated",
    "I found it difficult to relax",
    "I felt down-hearted and blue",
    "I was intolerant of anything that kept me from getting on with what I was doing",
    "I felt I was close to panic",
    "I was unable to become enthusiastic about anything",
    "I felt I wasn’t worth much as a person",
    "I felt that I was rather touchy",
    "I was aware of the action of my heart in the absence of physicalexertion (eg,sense of heart rate increase, heart missing a beat)",
    "I felt scared without any good reason",
    "I felt that life was meaningless"
  ];
  List<List<bool>> isselected = new List.generate(21, (j) => [false,false,false,false]);
  List<int> anxietyIndex = [1, 3, 6, 8, 14, 17, 18];
  List<int> stressIndex = [0, 5, 7, 10, 11, 13, 17];
  List<int> depressionIndex = [2, 4, 9, 12, 15, 16, 19];
  List<Color> randomizecolor = [Colors.blue,Colors.green,Colors.red,Colors.purple,Colors.pink,Colors.orange];
  _getQuestions() {
    for (int i = 0; i < 21; i++) {
      DASS21_Questions[i].getQues(questions[i], 'assets/dass_${(i + 1)}.png');
      DASS21_Questions[i].getOptions("Never", "Sometimes", "Often", "Always");
      DASS21_Questions[i]
          .getColor(randomizecolor[i%6], randomizecolor[i%6], randomizecolor[i%6], randomizecolor[i%6]);
    }
    anxietyIndex.forEach((index) {
      DASS21_Questions[index].type = 2;
    });
    depressionIndex.forEach((index) {
      DASS21_Questions[index].type = 1;
    });
    stressIndex.forEach((index) {
      DASS21_Questions[index].type = 3;
    });
  }

  _getResult() {
    if (total_s >= 0 && total_s <= 7)
      result_s = "Normal";
    else if (total_s >= 8 && total_s <= 9)
      result_s = "Mild";
    else if (total_s >= 10 && total_s <= 12)
      result_s = "Moderate";
    else if (total_s >= 13 && total_s <= 16)
      result_s = "Severe";
    else
      result_s = "Extremely Severe";

    if (total_a >= 0 && total_a <= 3)
      result_a = "Normal";
    else if (total_a >= 4 && total_a <= 5)
      result_a = "Mild";
    else if (total_a >= 6 && total_a <= 7)
      result_a = "Moderate";
    else if (total_a >= 8 && total_a <= 9)
      result_a = "Severe";
    else
      result_a = "Extremely Severe";

    if (total_d >= 0 && total_d <= 4)
      result_d = "Normal";
    else if (total_d >= 5 && total_d <= 6)
      result_d = "Mild";
    else if (total_d >= 7 && total_d <= 10)
      result_d = "Moderate";
    else if (total_d >= 11 && total_d <= 13)
      result_d = "Severe";
    else
      result_d = "Extremely Severe";
  }

  int total_a = 0, total_d = 0, total_s = 0;
  String result_a, result_d, result_s;
  @override
  void initState() {
    super.initState();
    _getQuestions();
  }

  bool change = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Swiper(
        curve: Curves.easeInOutCubic,
        scrollDirection: Axis.horizontal,
        loop: false,
        viewportFraction: 0.95,
        scale: 0.5,
        itemCount: 22,
        controller: _controller,
        itemBuilder: (BuildContext context, int index) {
          if (index < 21) {
            return page(DASS21_Questions[index], index);
          } else if (index == 21) {
            return summary();
          } else
            return null;
        },
      ),
    );
  }

  Widget page(Question question, int index) {
    return Center(
      child: SizedBox(
        //height: 800,
        child: Column(
          children: <Widget>[
            ShowUp(
              delay: 500,
              child: Container(
                  child: Image(
                image: AssetImage(question.imgURL),
                height: 260,
              )),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                question.ques,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                _controller.next();
                if (DASS21_Questions[index].type == 1) {
                  total_d += 0;
                } else if (DASS21_Questions[index].type == 2) {
                  total_a += 0;
                } else
                  total_s += 0;
                setState(() {
                  DASS21_Questions[index].answer = question.opt1;
                  DASS21_Questions[index].points = 0;
                  isselected[index][0] = true;
                  isselected[index][1] = false;
                  isselected[index][2] = false;
                  isselected[index][3] = false;
                });
              },
              child: Card(
                elevation: 8,
                color: question.opt1Color,
                child: ListTile(
                  leading:
                      Icon(Icons.keyboard_arrow_right, color: Colors.white),
                      trailing: isselected[index][0]? Icon(Icons.spellcheck, color: Colors.white) : null,
                  title: Text(
                    question.opt1,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                _controller.next();
                if (DASS21_Questions[index].type == 1) {
                  total_d += 1;
                } else if (DASS21_Questions[index].type == 2) {
                  total_a += 1;
                } else
                  total_s += 1;
                setState(() {
                  DASS21_Questions[index].answer = question.opt2;
                  DASS21_Questions[index].points = 1;
                  isselected[index][0] = false;
                  isselected[index][1] = true;
                  isselected[index][2] = false;
                  isselected[index][3] = false;
                });
              },
              child: Card(
                elevation: 8,
                color: question.opt2Color,
                child: ListTile(
                  leading:
                      Icon(Icons.keyboard_arrow_right, color: Colors.white),
                      trailing: isselected[index][1]? Icon(Icons.spellcheck, color: Colors.white) : null,
                  title: Text(
                    question.opt2,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                _controller.next();
                if (DASS21_Questions[index].type == 1) {
                  total_d += 2;
                } else if (DASS21_Questions[index].type == 2) {
                  total_a += 2;
                } else
                  total_s += 2;
                setState(() {
                  DASS21_Questions[index].answer = question.opt3;
                  DASS21_Questions[index].points = 2;
                  isselected[index][0] = false;
                  isselected[index][1] = false;
                  isselected[index][2] = true;
                  isselected[index][3] = false;
                });
              },
              child: Card(
                elevation: 8,
                color: question.opt3Color,
                child: ListTile(
                  leading:
                      Icon(Icons.keyboard_arrow_right, color: Colors.white),
                      trailing: isselected[index][2]? Icon(Icons.spellcheck, color: Colors.white) : null,
                  title: Text(
                    question.opt3,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                _controller.next();
                if (DASS21_Questions[index].type == 1) {
                  total_d += 3;
                } else if (DASS21_Questions[index].type == 2) {
                  total_a += 3;
                } else
                  total_s += 3;
                setState(() {
                  DASS21_Questions[index].answer = question.opt4;
                  DASS21_Questions[index].points = 3;
                  isselected[index][0] = false;
                  isselected[index][1] = false;
                  isselected[index][2] = false;
                  isselected[index][3] = true;
                });
              },
              child: Card(
                elevation: 8,
                color: question.opt4Color,
                child: ListTile(
                  leading:
                      Icon(Icons.keyboard_arrow_right, color: Colors.white),
                      trailing: isselected[index][3]? Icon(Icons.spellcheck, color: Colors.white) : null,
                  title: Text(
                    question.opt4,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
            Container(
              height: 30,
              width: 100,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: LinearProgressIndicator(
                  value: index/20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget summary() {
    _getResult();
    return Center(
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.only(top: 300),
          child: Column(
            children: <Widget>[
              Text("Result", style: TextStyle(fontSize: 30)),
              Text(
                "Depression = " + result_d,
                style: TextStyle(fontSize: 20),
              ),
              Text("Anxiety = " + result_a, style: TextStyle(fontSize: 20)),
              Text("Stress = " + result_s, style: TextStyle(fontSize: 20)),
              RaisedButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => BACEPage()));
                },
                color: Colors.teal,
                child: Text(
                  "Next",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}