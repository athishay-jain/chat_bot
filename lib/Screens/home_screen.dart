import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

List<Map<String, dynamic>> mesg = [
  {"u": "how are you", "ai": "i am fine what about you"},
  {
    "u": "ho is the founder of flutter ",
    "ai": "its not the funder the sister company google did it",
  },
  {
    "u": "do you know who is athishay",
    "ai": "i don't know who the person of you are speaking abut",
  },
];
List<String> tempSender = [];
List<String> tempReciver = [];
List<String> sender = [];
List<String> reciver = [];
TextEditingController textbox = TextEditingController();
List<Map<String, dynamic>> mes = mesg.reversed.toList();

String input = '**Hello** there, * point one, * point two';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color(0xfffafafa),
      appBar: AppBar(title: Text("ChatZ"), backgroundColor: Colors.white),
      body: ListView.builder(
        itemCount: sender.length,
        reverse: true,
        itemBuilder: (_, index) {
          print("on taped on the $index");
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  print("on taped on the $index");
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 250,right: 20),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    decoration: BoxDecoration(
                      color: Color(0xfff0f0f0),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        topLeft: Radius.circular(10),
                      ),
                    ),
                    child: Center(child: Text(sender.reversed.toList()[index])),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.black),
                    children: parseCustomMarkdown(reciver.reversed.toList()[index]),
                  ),
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: Container(
        height: 90,
margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        color: Colors.white,
        child: Row(
          children: [
            SizedBox(width: 20),
            InkWell(
              onTap: () {
                if (reciver.isEmpty) {
                  reciver.add(textbox.text);
                  textbox.clear();
                  setState(() {});
                }
                reciver[reciver.length - 1] = textbox.text;
                textbox.clear();
                setState(() {});
              },
              child: Icon(Icons.add_rounded, size: 30),
            ),
            SizedBox(width: 10),
            SizedBox(
              height: 45,
              width: 250,
              child: TextFormField(
                controller: textbox,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(width: 1, color: Color(0xff53de8d)),
                  ),

                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(width: 1, color: Colors.grey),
                  ),
                ),
              ),
            ),
            SizedBox(width: 20),
            InkWell(
              onTap: () {
                sender.add(textbox.text);
                reciver.add("loading...");
                getApi(qution: textbox.text);
                textbox.clear();
                setState(() {});
              },
              child: Icon(Icons.send, size: 30, color: Color(0xff53de8d)),
            ),
          ],
        ),
      ),
    );
  }

  void getApi({required String qution}) async {
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
      if (reciver.isEmpty) {
        reciver.add(data["candidates"][0]["content"]['parts'][0]["text"]);
        setState(() {});
      } else {
        reciver[reciver.length - 1] =
            data["candidates"][0]["content"]['parts'][0]["text"];
        textbox.clear();
        setState(() {});
      }
      print(res.body);
    }
  }

  List<TextSpan> parseCustomMarkdown(String input) {
    List<TextSpan> spans = [];

    // Handle bold (**text**)
    final boldRegex = RegExp(r'\*\*(.*?)\*\*');
    input = input.replaceAllMapped(boldRegex, (match) {
      spans.add(
        TextSpan(
          text: match.group(1),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      );
      return '\u0000'; // placeholder
    });

    // Handle points (* text)
    final pointRegex = RegExp(r'\* (.*?)(?=,|$)');
    input = input.replaceAllMapped(pointRegex, (match) {
      spans.add(TextSpan(text: '\n• ${match.group(1)}', style: TextStyle()));
      return '\u0000';
    });

    // Add remaining normal text
    for (var part in input.split('\u0000')) {
      if (part.trim().isNotEmpty) {
        spans.add(TextSpan(text: part));
      }
    }

    return spans;
  }
}
