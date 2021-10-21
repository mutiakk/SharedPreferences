import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_try/screen/homePage.dart';
import 'package:shared_try/screen/listPage.dart';
import 'package:shared_try/screen/loginPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool isUser= false;
  @override
  void initState() {
    _initCheck();
    super.initState();
  }
  void _initCheck()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if(prefs.getBool('isUser')!= null){
      setState(() {
        isUser=prefs.getBool('isUser')!;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class WidgetBottom extends StatefulWidget {
  const WidgetBottom({Key? key}) : super(key: key);

  @override
  _WidgetBottomState createState() => _WidgetBottomState();
}

class _WidgetBottomState extends State<WidgetBottom> {
  int pageIndex=0;
  List<Widget> pageList=<Widget>[
    HomePage(),
    UserList()
  ];

  void _onItemTapped(int index) {
    setState(() {
      pageIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageList[pageIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10)),
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            selectedItemColor: Colors.blueAccent,
            unselectedItemColor: Colors.grey,
            currentIndex: pageIndex,
            onTap: _onItemTapped,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            ],
          ),
      ),
    );
  }
}
class Mantab extends StatefulWidget {
  const Mantab({Key? key}) : super(key: key);

  @override
  _MantabState createState() => _MantabState();
}

class _MantabState extends State<Mantab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("YUHU"),
      ),
    );
  }
}

