abstract class ResponseState {}

class ResponseInitialState extends ResponseState {}

class ResponseLoadingState extends ResponseState {}

class ResponseLoadedState extends ResponseState {
 String response;


  ResponseLoadedState({required this.response,});
}

class ResponseErrorState extends ResponseState {
  String errorMessage;

  ResponseErrorState({required this.errorMessage});
}
