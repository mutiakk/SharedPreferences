import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
