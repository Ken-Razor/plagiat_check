import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plagiatcheck/constant.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = ScrollController();
  double offset = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.addListener(onScroll);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  void onScroll() {
    setState(() {
      offset = (controller.hasClients) ? controller.offset : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: controller,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 20),
                    Text(
                      "Plagiarism Checker",
                      style: kTitleTextstyle,
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 1.0),
                      child: TextField(
                        keyboardType: TextInputType.multiline,
//                      maxLines: 15,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          fillColor: Colors.green,
                          hintText: "Input your word here..",
                        ),
                        maxLines: 15,
                      ),
                    ),
                    SizedBox(height: 20,),
                    Card(
                        color: Colors.lightGreen[600],
                        margin:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 75.0),
                        child: new InkWell(
                          child: Container(
                            width: 200.0,
                            height: 55.0,
                            child: ListTile(
                                title: Text(
                                  "Check Your Word",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: kBackgroundColor,
                                  ),
                                )),
                          ),
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
