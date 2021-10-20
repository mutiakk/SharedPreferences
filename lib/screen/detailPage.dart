import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  Map<String, dynamic> data;
  DetailPage({Key? key, required this.data});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: SafeArea(
            child: Column(
              children: [
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.0),
                    image: DecorationImage(
                      image: NetworkImage(
                          widget.data['mantap'].avatar),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(widget.data['mantap'].firstName+" "+ widget.data['mantap'].lastName,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                ),
                Text(widget.data['mantap'].email),
              ],
            ),
          ),
        ));
  }
}
