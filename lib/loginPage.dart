import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:shared_try/homePage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _passHide = true;

  //controller
  final emailControl = TextEditingController();
  final passControl = TextEditingController();

  @override
  void initState() {
    checkLogin();
    super.initState();
  }
  //hiding pass
  void _password() {
    setState(() {
      _passHide = !_passHide;
    });
  }

  //login
  void _login() async {
    if (emailControl.text.isNotEmpty && passControl.text.isNotEmpty) {
      var response = await http.post(Uri.parse("https://reqres.in/api/login"),
          body: ({"email": emailControl.text, "password": passControl.text}));
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        print("login token " + body["token"]);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Login Success')));
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("login", body['token']);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => HomePage()),
                (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Invalid Username and Password')));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Blank Value')));
    }

// if (emailControl.text.isNotEmpty && passControl.text.isNotEmpty) {
    //   SharedPreferences prefs= await SharedPreferences.getInstance();
    //   prefs.setBool('isUser', true);
    //
    //   Future.delayed(Duration(seconds: 2));
    //   if (emailControl.text == 'mancuy' && passControl.text == 'mancuy') {
    //     Navigator.pushReplacement(
    //         context, MaterialPageRoute(builder: (context) => HomePage()));
    //   }
    // }
  }

  void checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString("login");
    if (value != null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomePage()),
          (route) => false);
    }
  }

  void _loadDialog(String text) {
    showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
        child: Padding(
          padding: EdgeInsets.fromLTRB(25, 20, 25, 20),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              new CircularProgressIndicator(),
              new Padding(
                padding: EdgeInsets.all(20),
                child: Text(text),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width * 0.85,
          height: 450,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                    blurRadius: 7,
                    offset: Offset(0, 5),
                    spreadRadius: 5,
                    color: Colors.blueAccent.withOpacity(0.5))
              ]),
          child: Form(
            child: formSignIn(),
          ),
        ),
      ),
    );
  }

  Widget formSignIn() {
    return Column(
      children: [
        Image(
          image: AssetImage('asset/login.png'),
          width: 200,
          height: 200,
        ),
        TextFormField(
          keyboardType: TextInputType.text,
          controller: emailControl,
          decoration: InputDecoration(
            labelText: 'Name',
            icon: Icon(Icons.person),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.lightGreen, width: 2)),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        TextFormField(
          keyboardType: TextInputType.text,
          obscureText: _passHide,
          controller: passControl,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              labelText: 'Password',
              icon: Icon(Icons.lock),
              suffixIcon: GestureDetector(
                child: Icon(
                  _passHide ? Icons.visibility_off : Icons.visibility,
                  color: _passHide ? Colors.grey : Colors.blueAccent,
                ),
                onTap: () {
                  _password();
                },
              )),
        ),
        SizedBox(height: 20),
        RaisedButton(
          onPressed: () {
            _login();
          },
          color: Colors.blueAccent,
          child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Login',
                textAlign: TextAlign.center,
              )),
        ),
      ],
    );
  }
}
