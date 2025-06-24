import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/chat_model.dart';

class ApiHelper{
  Future<dynamic> getApi({required String qution}) async {

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
      return ResponseDataModel.fromMap(data);

    }
    else{
      return null;
    }
  }
}