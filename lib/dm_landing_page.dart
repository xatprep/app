import 'dart:convert';
import 'package:flutter/material.dart';
import 'exam_message.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dm_landing_page.dart';

class DMLandingPage extends StatefulWidget {
  @override
  _DMLandingPageState createState() => _DMLandingPageState();
}

class _DMLandingPageState extends State<DMLandingPage> {
  @override
  Widget build(BuildContext context) {
    final ExamMessage args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Screen"),
        backgroundColor: Color(0xff2B3F9F),
      ),
      body: new Container(
        color: Color(0xffD1CCCC),
        child: new Center(
          child: Text(args.id),
        ),
      ),
//      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}