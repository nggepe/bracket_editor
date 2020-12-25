import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bracket_editor/gp_editor_converter.dart';

class GPEditor {
  ///it is that you will convert to rich text, for default is ""
  final String text;

  ///your primary color for your rich text. default Colors.black
  final Color color;

  ///you can set the text and the color here. if you want to get the rich text, then call [convert] for example:
  ///```dart
  ///GPEditor(text:"**your text**", Color(0XFF000000)).convert;
  ///```
  GPEditor({this.text, this.color});

  ///Converting `text` to be `rich text` flutter, you can set the `color` and the `text` at the `constructor` of it's class.
  ///When you don't, it is okay. This getter has default value
  Widget get convert {
    return EditorConverter(text ?? "", color ?? Colors.black).rich;
  }
}

class GPTextObject {
  String text;
  Widget widget;
  GPTextObject({this.text, this.widget});
}
