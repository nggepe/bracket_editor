import 'package:flutter/material.dart';

class EditorConverter {
  /// String [text] is the text that you will convert to be rich text
  final String text;

  /// Primary color for your rich text, it can't depend on your theme, so you have to set it directly
  final Color primaryColor;

  ///It is the converter from `text` to be `rich text`.
  ///this converter work when you call the [rich] getter, for example
  ///```dart
  ///EditorConverter("**helo**", Color(0XFF000000)).rich;
  ///```
  EditorConverter(this.text, this.primaryColor);
  List<RegExp> _bracket = [
    RegExp(r"\*\*\*(.*?)\*\*\*",
        caseSensitive: false, dotAll: true, multiLine: true, unicode: true),
    RegExp(r"\*\*(.*?)\*\*",
        caseSensitive: false, dotAll: true, multiLine: true, unicode: true),
    RegExp(r"\*(.*?)\*",
        caseSensitive: false, dotAll: true, multiLine: true, unicode: true),
  ];
  List<RegExp> _bracketChild = [
    RegExp(r"\*\*\*"),
    RegExp(r"\*\*"),
    RegExp(r"\*")
  ];
  List<String> _bracketReplace = ["\*\*\*", "\*\*", "\*"];

  List<Map<String, dynamic>> _bracketStyle = [
    {"boldItalic": "boldItalic"},
    {"bold": "bold"},
    {"italic": "italic"},
  ];

  List _openBracket = [];
  List _closedBracket = [];

  List<String> get exploded {
    return text.split(" ");
  }

  Widget get rich {
    List<TextSpan> output = [];
    Map<String, dynamic> storedStyle = {};

    exploded.forEach((word) {
      String storedWord = word + " ";

      for (var i = 0; i < _bracket.length; i++) {
        storedWord = word.replaceAll(_bracketReplace[i], "") + " ";

        /// matching with bracket without bracket open
        if (_bracket[i].hasMatch(word) && _openBracket.isEmpty) {
          storedStyle.addAll(_bracketStyle[i]);
          _openBracket.add(i);
          _closedBracket.add(i);
        }

        /// word matching with bracket child && open bracket is empty
        else if (_bracketChild[i].hasMatch(word) && _openBracket.isEmpty) {
          storedStyle.addAll(_bracketStyle[i]);
          _openBracket.add(i);
        }

        /// word matching with  bracket child && open bracket is not empty
        else if (_bracketChild[i].hasMatch(word) && _openBracket.isNotEmpty) {
          _closedBracket.add(i);
        }
      }

      output.add(
          textSpan(storedWord, color: this.primaryColor, style: storedStyle));

      _closedBracket.forEach((closed) {
        _openBracket.removeWhere((open) => open == closed);
        storedStyle
            .removeWhere((key, value) => value == _bracketStyle[closed][key]);
      });
      _closedBracket = [];
    });
    return RichText(text: TextSpan(text: "", children: output));
  }

  TextSpan textSpan(String text, {Map<String, dynamic> style, Color color}) {
    // print("disini style");
    // print(style);
    if (style == null) style = {};
    if (style.isEmpty) {
      return TextSpan(
          text: text,
          style: TextStyle(
            color: color ?? Colors.black,
          ));
    } else {
      return TextSpan(
        text: text,
        style: TextStyle(
          color: color ?? Colors.black,
          fontWeight:
              style.containsKey("bold") || style.containsKey("boldItalic")
                  ? FontWeight.bold
                  : FontWeight.normal,
          fontStyle:
              style.containsKey("italic") || style.containsKey("boldItalic")
                  ? FontStyle.italic
                  : FontStyle.normal,
        ),
      );
    }
  }
}
