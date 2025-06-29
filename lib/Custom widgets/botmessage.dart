import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class BotMessageWidget extends StatefulWidget {
  final String message;

  const BotMessageWidget({Key? key, required this.message}) : super(key: key);

  @override
  _BotMessageWidgetState createState() => _BotMessageWidgetState();
}



class _BotMessageWidgetState extends State<BotMessageWidget> {
  bool _animationCompleted = false;
  final baseTextStyle = TextStyle(
    color: Color(0xffEAEAEA),
    fontFamily: "Exo2",
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient (
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
          ),
        ],
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      child: MarkdownBody(
        data: widget.message,
        selectable: true,
        styleSheet:MarkdownStyleSheet(
          a: baseTextStyle.copyWith(decoration: TextDecoration.underline),
          p: baseTextStyle,
          code: baseTextStyle.copyWith(
            backgroundColor: Colors.black12,
            fontFamily: 'Courier',
          ),
          codeblockDecoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.deepPurpleAccent.withAlpha(70)),
          ),
          h1: baseTextStyle.copyWith(fontSize: 24, fontWeight: FontWeight.bold),
          h2: baseTextStyle.copyWith(fontSize: 22, fontWeight: FontWeight.bold),
          h3: baseTextStyle.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
          h4: baseTextStyle.copyWith(fontSize: 18, fontWeight: FontWeight.w600),
          h5: baseTextStyle.copyWith(fontSize: 16, fontWeight: FontWeight.w600),
          h6: baseTextStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w500),
          em: baseTextStyle.copyWith(fontStyle: FontStyle.italic),
          strong: baseTextStyle.copyWith(fontWeight: FontWeight.bold),
          blockquote: baseTextStyle.copyWith(
            fontStyle: FontStyle.italic,
            color: Color(0xffCCCCCC),
          ),
          listBullet: baseTextStyle,
          listIndent: 24.0,
          listBulletPadding: EdgeInsets.only(right: 8),
          tableHead: baseTextStyle.copyWith(fontWeight: FontWeight.bold),
          tableBody: baseTextStyle,
          checkbox: baseTextStyle,
          horizontalRuleDecoration: BoxDecoration(
            border: Border(
              top: BorderSide(width: 1.0, color: Color(0xffEAEAEA)),
            ),
          ),
        ),
      )
    );
  }
}
