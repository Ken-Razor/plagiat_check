import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:plagiatcheck/pages/homeScreen.dart';
import 'package:plagiatcheck/pages/notificationPage.dart';

class MyBottomNavigationBar extends StatefulWidget {
  static const String id = 'my_bottom';
  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar>
    with TickerProviderStateMixin {
  bool dialVisible = true;
  ScrollController scrollController;
  int _selectedIndex = 0;
//  static const TextStyle optionStyle =
//      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

//  @override
//  // ignore: must_call_super
//  void initState() {
//    _controller = new AnimationController(
//      vsync: this,
//      duration: const Duration(milliseconds: 500),
//    );
//  }
  @override
  void initState() {
    super.initState();

    scrollController = ScrollController()
      ..addListener(() {
        setDialVisible(scrollController.position.userScrollDirection ==
            ScrollDirection.forward);
      });
  }

  void setDialVisible(bool value) {
    setState(() {
      dialVisible = value;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image.asset(
              "assets/images/logo.png",
              fit: BoxFit.cover,
              height: 130.0,
              width: 70.0,
            ),
          ],
        ),
        backgroundColor: Colors.lightGreen[600],
        automaticallyImplyLeading: false,
        elevation: 0.0,
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NotificationPage()));
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(5),
              ),
              padding: EdgeInsets.all(5),
//              child: SvgPicture.asset(
////                "assets/icons/music.svg",
////                width: 35,
//            ),
            ),
          ),
        ],
      ),
      floatingActionButton: SpeedDial(
        // both default to 16
        marginRight: 18,
        marginBottom: 20,
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),
        // this is ignored if animatedIcon is non null
        // child: Icon(Icons.add),
        visible: dialVisible,
        // If true user is forced to close dial manually
        // by tapping main button and overlay is not rendered.
        closeManually: false,
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        onOpen: () => print('OPENING DIAL'),
        onClose: () => print('DIAL CLOSED'),
        tooltip: 'Speed Dial',
        heroTag: 'speed-dial-hero-tag',
        backgroundColor: Colors.lightGreen[600],
        foregroundColor: Colors.white,
        elevation: 8.0,
        shape: CircleBorder(),
        children: [
          SpeedDialChild(
              child: Icon(Icons.folder),
              backgroundColor: Colors.red,
              label: 'Upload From Phone Storage',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () => print('FIRST CHILD')
          ),
          SpeedDialChild(
            child: Icon(Icons.cloud),
            backgroundColor: Colors.blue,
            label: 'Upload From Google Drive',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () => print('SECOND CHILD'),
          ),
//          SpeedDialChild(
//            child: Icon(Icons.keyboard_voice),
//            backgroundColor: Colors.green,
//            label: 'Third',
//            labelStyle: TextStyle(fontSize: 18.0),
//            onTap: () => print('THIRD CHILD'),
//          ),
        ],
      ),
      body: DoubleBackToCloseApp(
        child: _widgetOptions.elementAt(_selectedIndex),
        snackBar:
            const SnackBar(content: Text('Klik once again to exit')),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            title: Text('Pro Member'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text('Account'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green[600],
        onTap: _onItemTapped,
      ),
    );
  }
}
