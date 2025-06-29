import 'dart:convert';
import 'dart:ui';

import 'package:chat_bot/Custom%20widgets/botmessage.dart';
import 'package:chat_bot/Data/online/Bloc/response_bloc.dart';
import 'package:chat_bot/Data/online/Bloc/response_event.dart';
import 'package:chat_bot/Data/online/Bloc/response_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
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
final baseTextStyle = TextStyle(color: Color(0xffEAEAEA), fontFamily: "Exo2");

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
        foregroundColor: Colors.white,
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
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        top: 8,
                        right: 16,
                        bottom: 8,
                        left: 120,
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
                          style: TextStyle(
                            color: Color(0xffEAEAEA),
                            fontFamily: "Exo2",
                          ),
                        ),
                      ),
                    ),

                    Align(
                      alignment: Alignment(-1, 0),
                      child: Container(
                        margin: EdgeInsets.only(
                          top: 8,
                          bottom: 8,
                          right: 16,
                          left: 16,
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
                          border: Border.all(color: Colors.deepPurpleAccent),
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
                        child: reciver.reversed.toList()[index] == "Loading..."
                            ? Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Zentra is thinking",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xffEAEAEA),
                                      fontFamily: "Exo2",
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Lottie.asset("assets/lottie/loading.json"),
                                ],
                              )
                            : MarkdownBody(
                                data: reciver.reversed.toList()[index],
                                selectable: true,
                                styleSheet: MarkdownStyleSheet(
                                  a: baseTextStyle.copyWith(
                                    decoration: TextDecoration.underline,
                                  ),
                                  p: baseTextStyle,
                                  code: baseTextStyle.copyWith(
                                    backgroundColor: Colors.black12,
                                    fontFamily: 'Courier',
                                  ),
                                  codeblockDecoration: BoxDecoration(
                                    color: const Color(0xFF1F1F1F),
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                      color: Colors.deepPurpleAccent
                                          .withOpacity(0.3),
                                    ),
                                  ),
                                  h1: baseTextStyle.copyWith(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  h2: baseTextStyle.copyWith(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  h3: baseTextStyle.copyWith(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  h4: baseTextStyle.copyWith(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  h5: baseTextStyle.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  h6: baseTextStyle.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  em: baseTextStyle.copyWith(
                                    fontStyle: FontStyle.italic,
                                  ),
                                  strong: baseTextStyle.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  blockquote: baseTextStyle.copyWith(
                                    fontStyle: FontStyle.italic,
                                    color: Color(0xffCCCCCC),
                                  ),
                                  listBullet: baseTextStyle,
                                  listIndent: 24.0,
                                  listBulletPadding: EdgeInsets.only(right: 8),
                                  tableHead: baseTextStyle.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  tableBody: baseTextStyle,
                                  checkbox: baseTextStyle,
                                  horizontalRuleDecoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                        width: 1.0,
                                        color: Color(0xffEAEAEA),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                      ),
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
            return ListView.builder(
              controller: chatScrollController,
              itemCount: sender.length,
              reverse: true,
              itemBuilder: (_, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        top: 8,
                        right: 16,
                        bottom: 8,
                        left: 120,
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
                      child: Text(
                        sender.reversed.toList()[index],
                        style: TextStyle(
                          color: Color(0xffEAEAEA),
                          fontFamily: "Exo2",
                        ),
                        //    textAlign: TextAlign.end,
                      ),
                    ),
                    Align(
                      alignment: Alignment(-1, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: BotMessageWidget(
                              message: reciver.reversed.toList()[index],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          }
          return Center(
            child: Text(
              "Welcome To Zentra",
              style: TextStyle(
                color: Color(0xffEAEAEA),
                fontFamily: "Exo2",
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 20, left: 15, right: 15),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
            child: Container(
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
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
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
                    Expanded(
                      child: TextFormField(
                        maxLines: null,
                        expands: false,
                        controller: textbox,
                        onChanged: (value) {
                          setState(() {});
                        },
                        onTap: () {
                          chatScrollController.animateTo(
                            chatScrollController.position.minScrollExtent,
                            duration: Duration(seconds: 1),
                            curve: Curves.easeOut,
                          );
                        },
                        style: TextStyle(
                          color: Color(0xffEAEAEA),
                          fontFamily: "Exo2",
                        ),
                        //   maxLines: null,
                        //   expands: false,
                        minLines: 1,
                        decoration: InputDecoration(
                          hint: Text(
                            "Ask anything",
                            style: TextStyle(
                              color: Color(0xffEAEAEA),
                              fontFamily: "Exo2",
                            ),
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
                    SizedBox(width: 10),
                    InkWell(
                      onTap: textbox.text.isEmpty
                          ? null
                          : () {
                              sender.add(textbox.text);
                              reciver.add("Loading...");
                              context.read<ResponseBloc>().add(
                                GetResponseEvent(question: textbox.text),
                              );
                              textbox.clear();
                              FocusScope.of(context).unfocus();
                            },
                      child: Icon(
                        Icons.send,
                        size: 30,
                        color: textbox.text.isEmpty
                            ? Colors.grey
                            : Color(0xff3fdee9),
                      ),
                    ),
                    SizedBox(width: 15),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      drawer: Drawer(
        backgroundColor: Color(0xff06111a),
        width: 250,
        child: Column(
          children: [
            SizedBox(height: 50),
            Text(
              "Chats history",
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
                fontFamily: "Exo2",
              ),
            ),
            SizedBox(height: 20),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(maximumSize: Size(180, 100)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "New Chat",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: "Exo2",
                    ),
                  ),
                  SizedBox(width: 5),
                  Icon(Icons.add_circle_rounded, color: Colors.white, size: 23),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (_, index) {
                  return ListTile(
                    title: Text(
                      "Testing Chat with overflow",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: "Exo2",
                      ),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.clip,
                      maxLines: 1,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
