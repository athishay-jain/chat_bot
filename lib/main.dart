import 'dart:convert';

import 'package:chat_bot/Screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home:HomeScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
TextEditingController tex = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getApi();
  }

  String respose = '';

  void getApi({String qution = 'hello'}) async {

    String url =
        "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=AIzaSyCVo3m1oshBMbkzuD8DzhUVotOC48I-LAM";
    http.Response res = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "contents": [
          {
            "parts": [
              {"text": "$qution"},
            ],
          },
        ],
      }),
    );
    if (res.statusCode == 200) {
      dynamic data = jsonDecode(res.body);
      print(data["candidates"][0]["content"]['parts'][0]["text"]);
      respose = data["candidates"][0]["content"]['parts'][0]["text"];
      print(res.body);
      setState(() {});
    }
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "adhalwdd awudbalwdb wadjiwadbifvbf dw dawoD wdu owddaiwodbwa",
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Container(
                margin: EdgeInsets.only(left: 200),
                height: 50,
                width: 210,
                decoration: BoxDecoration(
                  color: Color(0xfff0f0f0),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    topLeft: Radius.circular(10),
                  ),
                ),
              ),
            ),

            TextField(controller: tex,),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: (){
              tex.clear();
              getApi(qution: tex.text);
            }, child: Text("Enter")),
            SizedBox(height: 20,),
            Text('$respose'),
          ],
        ),
      ),
      /*bottomNavigationBar:Container(
        width:300,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
          *//*SizedBox(
              height: 30,
              width: 200,
              child: TextField(controller: tex,)),*//*
        SizedBox(width:  5,),
            ElevatedButton(onPressed: (){
              tex.clear();
              getApi(qution: tex.text);
            }, child: Text("Enter")),
          ],
        ),
      ) */// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
