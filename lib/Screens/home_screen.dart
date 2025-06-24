import 'dart:convert';
import 'dart:ui';

import 'package:chat_bot/Data/online/Bloc/response_bloc.dart';
import 'package:chat_bot/Data/online/Bloc/response_event.dart';
import 'package:chat_bot/Data/online/Bloc/response_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import 'package:lottie/lottie.dart';

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
ScrollController chatScrollController = ScrollController();

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

@override
void dispose() {
  chatScrollController.dispose;
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chatScrollController.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      extendBody: true,
      backgroundColor: Color(0xff0D0D0D),
      appBar: AppBar(
        title: Image.asset("assets/images/logo_horizontal.jpg", scale: 4),
        backgroundColor: Color(0xff010717),
      ),
      body: BlocBuilder<ResponseBloc, ResponseState>(
        builder: (context, state) {
          if (state is ResponseLoadingState) {
            return ListView.builder(
              itemCount: sender.length,
              reverse: true,
              itemBuilder: (_, index) {
                print("on taped on the $index");
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        print("on taped on the $index");
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Spacer(),
                          Flexible(
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 16,
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xFF1B1F27),
                                    Color(0xFF0D0F12),
                                  ],
                                ),
                                border: Border.all(color: Colors.cyanAccent),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.cyanAccent.withAlpha(127),
                                    blurRadius: 15,
                                    spreadRadius: 1,
                                    offset: Offset(0, 0),
                                  ),
                                ],
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                  topLeft: Radius.circular(20),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  sender.reversed.toList()[index],
                                  style: TextStyle(color: Color(0xffEAEAEA),fontFamily: "Exo2"),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 16,
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Color(0xFF1B1F27), Color(0xFF0D0F12)],
                              ),
                              border: Border.all(
                                color: Colors.deepPurpleAccent,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.deepPurpleAccent.withAlpha(127),
                                  blurRadius: 15,
                                  spreadRadius: 1,
                                  offset: Offset(0, 0),
                                ),
                              ],
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                                topLeft: Radius.circular(20),
                              ),
                            ),
                            child: Center(
                              child: reciver.reversed.toList()[index] == "Loading..."
                                  ? Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Zentra is thinking",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xffEAEAEA),
                                        fontFamily: "Exo2"),
                                  ),
                                  Lottie.asset("assets/lottie/loading.json"),
                                ],
                              )
                                  : RichText(
                                text: TextSpan(
                                  style: TextStyle(color: Color(0xffEAEAEA),fontFamily: "Exo2"),
                                  children: parseCustomMarkdown(
                                    reciver.reversed.toList()[index],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                  ],
                );
              },
            );
          }
          if (state is ResponseLoadedState) {
            /*List<String> sender = state.questions;
          List<String> reciver = state.response;*/
            reciver[reciver.length - 1] = state.response;
            print(sender);
            print(reciver);
            return ListView.builder(
              controller: chatScrollController,
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
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Spacer(),
                          Flexible(
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 16,
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xFF1B1F27),
                                    Color(0xFF0D0F12),
                                  ],
                                ),
                                border: Border.all(color: Colors.cyanAccent),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.cyanAccent.withAlpha(127),
                                    blurRadius: 15,
                                    spreadRadius: 1,
                                    offset: Offset(0, 0),
                                  ),
                                ],
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                  topLeft: Radius.circular(20),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  sender.reversed.toList()[index],
                                  style: TextStyle(color: Color(0xffEAEAEA),fontFamily: "Exo2"),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 16,
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Color(0xFF1B1F27), Color(0xFF0D0F12)],
                              ),
                              border: Border.all(
                                color: Colors.deepPurpleAccent,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.deepPurpleAccent.withAlpha(127),
                                  blurRadius: 15,
                                  spreadRadius: 1,
                                  offset: Offset(0, 0),
                                ),
                              ],
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                                topLeft: Radius.circular(20),
                              ),
                            ),
                            child: Center(
                              child: RichText(
                                text: TextSpan(
                                  style: TextStyle(color: Color(0xffEAEAEA),fontFamily: "Exo2"),
                                  children: parseCustomMarkdown(
                                    reciver.reversed.toList()[index],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            );
          }
          return Center(
            child: Text(
              "Welcome To Chat Bot",
              style: TextStyle(color: Color(0xffEAEAEA),fontFamily: "Exo2",fontWeight: FontWeight.bold,fontSize: 30),
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom:20 ,left: 15,right: 15),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
            child: Container(
              height: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  width: 1,
                  color: Colors.white.withAlpha(100),
                ),
              ),
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              // color: Color(0xff010717),
              child: Row(
                children: [
                  SizedBox(width: 20),
                  InkWell(
                    onTap: () {},
                    child: Icon(
                      Icons.add_rounded,
                      size: 30,
                      color: Colors.deepPurpleAccent,
                    ),
                  ),
                  SizedBox(width: 10),
                  SizedBox(
                    height: 45,
                    width: 250,
                    child: TextFormField(
                      controller: textbox,
                      onTap: () {
                        if (chatScrollController.hasClients) {
                          final position =
                              chatScrollController.position.minScrollExtent;
                          chatScrollController.jumpTo(position);
                        }
                        chatScrollController.animateTo(
                          chatScrollController.position.minScrollExtent,
                          duration: Duration(seconds: 1),
                          curve: Curves.easeOut,
                        );
                      },
                      style: TextStyle(color: Color(0xffEAEAEA),fontFamily: "Exo2"),
                      decoration: InputDecoration(
                        hint: Text(
                          "Ask anything",
                          style: TextStyle(color: Color(0xffEAEAEA),fontFamily: "Exo2"),
                        ),
                        fillColor: Color(0xff09101b),
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.cyanAccent,
                          ),
                        ),

                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.cyanAccent.withAlpha(100),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  InkWell(
                    onTap: () {
                      sender.add(textbox.text);
                      reciver.add("Loading...");
                      context.read<ResponseBloc>().add(
                        GetResponseEvent(question: textbox.text),
                      );
                      textbox.clear();
                      FocusScope.of(context).unfocus();
                    },
                    child: CircleAvatar(
                      backgroundColor: Color(0xff06111a),
                      child: Icon(
                        Icons.send,
                        size: 30,
                        color: Color(0xff3fdee9),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
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
