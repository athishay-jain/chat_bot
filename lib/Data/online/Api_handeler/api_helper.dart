import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/chat_model.dart';

class ApiHelper {
  // Maintain full chat history
  List<Map<String, dynamic>> allChats = [];
ApiHelper._();
 static ApiHelper getApiHelper () => ApiHelper._();
  Future<dynamic> getApi({required String question}) async {
    // Add the user's message to the chat history
    allChats.add({
      "role": "user",
      "parts": [
        {"text": question}
      ]
    });

    print("Chat history being sent: $allChats");

    String url =
        "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=AIzaSyCVo3m1oshBMbkzuD8DzhUVotOC48I-LAM";

    Map<String, dynamic> allChatData = {
      "system_instruction": {
        "parts": [
          {
            "text":
            "You are Zentra, an AI assistant. The user's name is Athishay. Remember user facts from the conversation and respond helpfully."
          }
        ]
      },
      "contents": allChats,
    };

    // FIX: Add headers!
    http.Response res = await http.post(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(allChatData),
    );

    if (res.statusCode == 200) {
      dynamic data = jsonDecode(res.body);

      // Extract model reply safely
      String replyText = data["candidates"][0]["content"]["parts"][0]["text"];

      // Add model's reply to chat history
      allChats.add({
        "role": "model",
        "parts": [
          {"text": replyText}
        ]
      });

      print("Model response: $replyText");

      return ResponseDataModel.fromMap(data);
    } else {
      print("API Error: ${res.statusCode} - ${res.body}");
      return null;
    }
  }
}
