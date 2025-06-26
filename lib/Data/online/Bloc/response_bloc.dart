import 'dart:convert';

import 'package:chat_bot/Data/offline/Database/dbhelper.dart';
import 'package:chat_bot/Data/online/Api_handeler/api_helper.dart';
import 'package:chat_bot/Data/online/Bloc/response_event.dart';
import 'package:chat_bot/Data/online/Bloc/response_state.dart';
import 'package:chat_bot/Data/online/model/chat_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class ResponseBloc extends Bloc<ResponseEvent,ResponseState>{
  ResponseBloc() : super(ResponseInitialState()){
    on<GetResponseEvent>((state,emit)async{
      emit(ResponseLoadingState());
ApiHelper api= ApiHelper();
ResponseDataModel data = await api.getApi(question: state.question);
if(data!=null){
  String aiResponse = data.candidates[0].content.parts[0].text;
  emit(ResponseLoadedState(response: aiResponse));
}
    });
  }

}
