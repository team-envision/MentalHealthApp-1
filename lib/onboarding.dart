import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:mental_health_app/question.dart';
import 'package:mental_health_app/quiz.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link/link.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Showup.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class Onboarding extends StatefulWidget {
  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  String assetPDFPath1 = "";
  String assetPDFPath2 = "";

  String assetPDFPath3 = "";

  SwiperController _controller = SwiperController();
  List<Question> SDRS_Questions = [
    Question(),
    Question(),
    Question(),
    Question(),
    Question()
  ];
  List<Color> randomizecolor = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.purple,
    Colors.pink,
    Colors.orange
  ];
  List<Color> randomizecolorlight = [
    Colors.blue[100],
    Colors.red[100],
    Colors.green[100],
    Colors.purple[100],
    Colors.pink[100],
    Colors.orange[100]
  ];

  int total = 0;
  bool consent = false;
  final snackBar = SnackBar(
    content: Text("Please give consent before you proceed"),
    duration: Duration(milliseconds: 800),
  );

  @override
  void initState() {
    super.initState();
    getFileFromAsset1("assets/Know the Team.pdf").then((f1) {
      setState(() {
        assetPDFPath1 = f1.path;
      });
    });
    getFileFromAsset2("assets/Get Help Now.pdf").then((f2) {
      setState(() {
        assetPDFPath2 = f2.path;
      });
    });
    getFileFromAsset3("assets/Consent Form.pdf").then((f3) {
      setState(() {
        assetPDFPath3 = f3.path;
      });
    });
  }

  Future<File> getFileFromAsset1(String asset) async {
    try {
      var data = await rootBundle.load(asset);
      var bytes = data.buffer.asUint8List();
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/Know the Team.pdf");

      File assetFile = await file.writeAsBytes(bytes);
      return assetFile;
    } catch (e) {
      throw Exception("Error opening asset file");
    }
  }

  Future<File> getFileFromAsset2(String asset) async {
    try {
      var data = await rootBundle.load(asset);
      var bytes = data.buffer.asUint8List();
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/Get Help Now.pdf");

      File assetFile = await file.writeAsBytes(bytes);
      return assetFile;
    } catch (e) {
      throw Exception("Error opening asset file");
    }
  }

  Future<File> getFileFromAsset3(String asset) async {
    try {
      var data = await rootBundle.load(asset);
      var bytes = data.buffer.asUint8List();
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/Consent Form.pdf");

      File assetFile = await file.writeAsBytes(bytes);
      return assetFile;
    } catch (e) {
      throw Exception("Error opening asset file");
    }
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, allowFontScaling: true);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Swiper(
        itemCount: consent?4:3,
        curve: Curves.easeInOutCubic,
        scrollDirection: Axis.horizontal,
        loop: false,
        viewportFraction: 0.95,
        scale: 0.8,
        controller: _controller,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return SingleChildScrollView(
              child: Center(
                child: SizedBox(
                  //height: MediaQuery.of(context).size.height*10,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 100.h,
                      ),
                      ShowUp(
                        delay: 500,
                        child: Container(
                            child: Image(
                          image: AssetImage('assets/Onboarding1.png'),
                          height: 500.h,
                        )),
                      ),
                      SizedBox(height: 50.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Text(
                          "Developed in liaison by Professionals",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: ScreenUtil()
                                  .setSp(75, allowFontScalingSelf: true),
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      SizedBox(height: 50.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Text(
                          "This app has been developed by Mental Health Professionals and is based on Scientific evidence and research. There is a team of eminent mental health professionals in the University who are available to help you.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: ScreenUtil()
                                  .setSp(55, allowFontScalingSelf: true),
                              //fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      SizedBox(height: 50.h),
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        color: Colors.blue[100],
                        disabledColor: Colors.blue[100],
                        disabledElevation: 5,
                        elevation: 5,
                        child: GestureDetector(
                          onTap: () async {
                            print("PDF poof");
                            if (assetPDFPath1 != null) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PdfViewPage(path: assetPDFPath1)));
                            }
                          },
                          child: Text(
                            "Know the Team",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: ScreenUtil()
                                    .setSp(55, allowFontScalingSelf: true),
                                //fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                color: Colors.blue[700]),
                          ),
                        ),
                        onPressed: () {},
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      InkWell(
                        onTap: () {
                          _controller.next();
                        },
                        child: Card(
                          elevation: 8,
                          color: randomizecolor[index % 6],
                          child: ListTile(
                            //leading: Icon(Icons.keyboard_arrow_right, color: Colors.white),
                            title: Text(
                              "Swipe left or Tap here to Navigate",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: ScreenUtil()
                                      .setSp(55, allowFontScalingSelf: true),
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 80.h,
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 50.h, horizontal: 10.w),
                          child: StepProgressIndicator(
                            totalSteps: 4,
                            height: 10.h,
                            currentStep: index + 1,
                            selectedColor: randomizecolor[index % 6],
                            unselectedColor: randomizecolorlight[index % 6],
                            customStep: (index, color) {
                              if (index == 1) {
                                return Icon(
                                  Icons.check_box_outline_blank,
                                  color: color,
                                  size: 50.w,
                                );
                              }
                              return Icon(
                                Icons.stop,
                                color: color,
                                size: 50.w,
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          if (index == 1) {
            return SingleChildScrollView(
              child: Center(
                child: SizedBox(
                  //height: MediaQuery.of(context).size.height*10,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 100.h,
                      ),
                      ShowUp(
                        delay: 500,
                        child: Container(
                            child: Image(
                          image: AssetImage('assets/Onboarding2.png'),
                          height: 500.h,
                        )),
                      ),
                      SizedBox(height: 50.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Text(
                          "It's OK to ask for Help!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: ScreenUtil()
                                  .setSp(70, allowFontScalingSelf: true),
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      SizedBox(height: 50.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Text(
                          "Going out and asking for help is a good thing. Don’t let others tell you otherwise. If you can’t seem to get help then you might be looking in the wrong place. Let professionals lend you a hand.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: ScreenUtil()
                                  .setSp(55, allowFontScalingSelf: true),
                              //fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        color: Colors.red[100],
                        disabledColor: Colors.blue[100],
                        disabledElevation: 5,
                        elevation: 5,
                        child: GestureDetector(
                          onTap: () async {
                            if (assetPDFPath2 != null) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PdfViewPage(path: assetPDFPath2)));
                            }
                          },
                          child: Text(
                            "I want help now!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: ScreenUtil()
                                    .setSp(55, allowFontScalingSelf: true),
                                //fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                color: Colors.red[700]),
                          ),
                        ),
                        onPressed: () {},
                      ),
                      SizedBox(height: 30.h),
                      InkWell(
                        onTap: () {
                          _controller.next();
                        },
                        child: Card(
                          elevation: 8,
                          color: Colors.pink[400],
                          child: ListTile(
                            leading: Icon(Icons.keyboard_arrow_right,
                                color: Colors.white),
                            title: Text(
                              "Next",
                              style: TextStyle(
                                  fontSize: ScreenUtil()
                                      .setSp(60, allowFontScalingSelf: true),
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 80.h,
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 50.h),
                          child: StepProgressIndicator(
                            totalSteps: 4,
                            height: 10.h,
                            currentStep: index + 1,
                            selectedColor: randomizecolor[index % 6],
                            unselectedColor: randomizecolorlight[index % 6],
                            customStep: (index, color) {
                              if (index == 2) {
                                return Icon(
                                  Icons.check_box_outline_blank,
                                  color: color,
                                  size: 50.w,
                                );
                              }
                              return Icon(
                                Icons.stop,
                                color: color,
                                size: 50.w,
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          if (index == 2) {
            return SingleChildScrollView(
              child: Center(
                child: SizedBox(
                  //height: MediaQuery.of(context).size.height*10,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 100.h,
                      ),
                      ShowUp(
                        delay: 500,
                        child: Container(
                            child: Image(
                          image: AssetImage('assets/Onboarding3.png'),
                          height: 500.h,
                        )),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Text(
                          "Disclaimer",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: ScreenUtil()
                                  .setSp(70, allowFontScalingSelf: true),
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              color: Colors.black),
                        ),
                      ),
                      SizedBox(height: 50.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Text(
                          "This is not an alternative to seeking professional help for any acute mental health condition. If you’re currently feeling extremely anxious, suicidal or depressed kindly visit the Emergency of SRM Medical College & Hospital. Help will be provided to you promptly for the same. Please go through the Consent form below.\n",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: ScreenUtil()
                                  .setSp(55, allowFontScalingSelf: true),
                              //fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        color: Colors.green[100],
                        disabledColor: Colors.blue[100],
                        disabledElevation: 5,
                        elevation: 5,
                        child: GestureDetector(
                          onTap: () async {
                            if (assetPDFPath3 != null) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PdfViewPage(path: assetPDFPath3)));
                            }
                          },
                          child: Text(
                            "Consent Form!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: ScreenUtil()
                                    .setSp(55, allowFontScalingSelf: true),
                                //fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                color: Colors.green[700]),
                          ),
                        ),
                        onPressed: () {},
                      ),
                      SizedBox(height: 10.h),
                      CheckboxListTile(
                        onChanged: (bool value) {
                          setState(() {
                            consent = !consent;
                          });
                        },
                        value: consent,
                        title: Text("I have read the form and I give Consent"),
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      SizedBox(height: 10.h),
                      InkWell(
                        onTap: consent
                            ? () {
                                // consent = true;
                                _controller.next();
                              }
                            : null,
                        child: Card(
                          elevation: 8,
                          color: consent?randomizecolor[index % 6]:Colors.grey,
                          child: ListTile(
                            leading:
                                Icon(Icons.navigate_next, color: Colors.white),
                            trailing:
                                Icon(Icons.done, color: Colors.transparent),
                            title: Text(
                              "Next",
                              // textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: ScreenUtil()
                                      .setSp(50, allowFontScalingSelf: true),
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 80.h,
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 30.h),
                          child: StepProgressIndicator(
                            totalSteps: 4,
                            height: 10.h,
                            currentStep: index + 1,
                            selectedColor: randomizecolor[index % 6],
                            unselectedColor: randomizecolorlight[index % 6],
                            customStep: (index, color) {
                              if (index == 3) {
                                return Icon(
                                  Icons.check_box_outline_blank,
                                  color: color,
                                  size: 50.w,
                                );
                              }
                              return Icon(
                                Icons.stop,
                                color: color,
                                size: 50.w,
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (index == 3) {
            return SingleChildScrollView(
              child: Center(
                child: SizedBox(
                  //height: MediaQuery.of(context).size.height*10,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 100.h,
                      ),
                      ShowUp(
                        delay: 500,
                        child: Container(
                            child: Image(
                          image: AssetImage('assets/Onboarding4.png'),
                          height: 500.h,
                        )),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Text(
                          "Privacy Note",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: ScreenUtil()
                                  .setSp(70, allowFontScalingSelf: true),
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              color: Colors.black),
                        ),
                      ),
                      SizedBox(height: 50.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Text(
                          "Worried about your privacy and/or identity being revealed? Rest assured. The application is anonymous and does not collect any information by which you could be identified (such as your name, e-mail, etc.). The information collected (age, course, etc.) is only to determine and analyse your mental health better. Your data and results are safe with us.\n",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: ScreenUtil()
                                  .setSp(55, allowFontScalingSelf: true),
                              //fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      SizedBox(height: 30.h),
                      InkWell(
                        onTap: () {
                          if (consent) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Quiz()));
                          } else {
                            Scaffold.of(context).showSnackBar(snackBar);
                            _controller.move(2);
                          }
                        },
                        child: Card(
                          elevation: 8,
                          color: randomizecolor[index % 6],
                          child: ListTile(
                            // trailing: Icon(Icons.accessibility_new, color: Colors.white),
                            title: Text(
                              "Start",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: ScreenUtil()
                                      .setSp(50, allowFontScalingSelf: true),
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 80.h,
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 30.h),
                          child: StepProgressIndicator(
                            totalSteps: 4,
                            height: 10.h,
                            currentStep: index + 1,
                            selectedColor: randomizecolor[index % 6],
                            unselectedColor: randomizecolorlight[index % 6],
                            customStep: (index, color) {
                              if (index == 4) {
                                return Icon(
                                  Icons.check_box_outline_blank,
                                  color: color,
                                  size: 50.w,
                                );
                              }
                              return Icon(
                                Icons.stop,
                                color: color,
                                size: 50.w,
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return null;
          }
        },
      ),
    );
  }
}

class PdfViewPage extends StatefulWidget {
  final String path;

  const PdfViewPage({Key key, this.path}) : super(key: key);
  @override
  _PdfViewPageState createState() => _PdfViewPageState();
}

class _PdfViewPageState extends State<PdfViewPage> {
  int _totalPages = 0;
  int _currentPage = 0;
  bool pdfReady = false;
  PDFViewController _pdfViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          PDFView(
            filePath: widget.path,
            autoSpacing: true,
            enableSwipe: true,
            pageSnap: true,
            swipeHorizontal: true,
            nightMode: false,
            onError: (e) {
              print(e);
            },
            onRender: (_pages) {
              setState(() {
                _totalPages = _pages;
                pdfReady = true;
              });
            },
            onViewCreated: (PDFViewController vc) {
              _pdfViewController = vc;
            },
            onPageChanged: (int page, int total) {
              setState(() {});
            },
            onPageError: (page, e) {},
          ),
          !pdfReady
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Offstage()
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          _currentPage > 0
              ? FloatingActionButton.extended(
                  backgroundColor: Colors.red,
                  label: Text("Go to ${_currentPage - 1}"),
                  onPressed: () {
                    _currentPage -= 1;
                    _pdfViewController.setPage(_currentPage);
                  },
                )
              : Offstage(),
          _currentPage + 1 < _totalPages
              ? FloatingActionButton.extended(
                  backgroundColor: Colors.green,
                  label: Text("Go to ${_currentPage + 1}"),
                  onPressed: () {
                    _currentPage += 1;
                    _pdfViewController.setPage(_currentPage);
                  },
                )
              : Offstage(),
        ],
      ),
    );
  }
}
