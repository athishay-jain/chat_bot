import 'dart:convert';

import 'package:chat_bot/Data/offline/Database/dbhelper.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';

import '../model/chat_model.dart';

class ApiHelper {
  List<Map<String, dynamic>> responseData = [];
  Set<Map<String, dynamic>> allChats = {};
  Dbhelper dbhelper = Dbhelper.getInstances();

  void feathData() async {
    responseData = await dbhelper.getData();
    for (Map<String, dynamic>eachData in responseData) {
      allChats.add({
        "role": "user",
        "parts": [
          {
            "text": eachData[Dbhelper.table_question]
          }
        ]
      });
      allChats.add({
        "role": "model",
        "parts": [
          {
            "text": eachData[Dbhelper.table_response]
          }
        ]
      });
    }
  }

  void addData({required String question, required String response}) {
    dbhelper.addResponse(question: question, response: response);
  }

  Future<dynamic> getApi({required String question}) async {

    feathData();
    print(responseData);
    String url =
        "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=AIzaSyCVo3m1oshBMbkzuD8DzhUVotOC48I-LAM";

    http.Response res = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body:responseData.isNotEmpty? jsonEncode({
        "contents": [responseData],
      }):jsonEncode({
        "contents":[
          {
            "parts": [
              {"text": "$question"},
            ],
          },
        ],
      })
    );
    if (res.statusCode == 200) {
      dynamic data = jsonDecode(res.body);
      print(data["candidates"][0]["content"]['parts'][0]["text"]);
      addData(question: question, response: data["candidates"][0]["content"]['parts'][0]["text"]);
      return ResponseDataModel.fromMap(data);
    } else {
      return null;
    }
  }
}
