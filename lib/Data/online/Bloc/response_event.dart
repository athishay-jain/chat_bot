abstract class ResponseEvent{}
class GetResponseEvent extends ResponseEvent{
  String question;
  GetResponseEvent({required this.question});
}