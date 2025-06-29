import 'dart:convert';

import 'package:chat_bot/Data/online/Api_handeler/api_helper.dart';
import 'package:chat_bot/Data/online/Bloc/response_bloc.dart';
import 'package:chat_bot/Screens/home_screen.dart';
import 'package:chat_bot/Screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(BlocProvider(create: (context) => ResponseBloc(api: ApiHelper.getApiHelper()),child: MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home:SplashScreen(),
    );
  }
}