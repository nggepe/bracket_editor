import 'package:flutter/material.dart';
import '../gp_editor_action.dart';
import '../gp_editor_controller.dart';

class GPEditortext extends StatelessWidget {
  /// `onChange` is the callback method that you can use for your text change.
  final Function(String) onChange;

  /// `textWidget` is the call back `Widget`, you can use it as the callback. It will change depend on text change.
  /// so you can use it on your state management
  final Function(Widget) textWidget;

  ///this parameter is to set you primary output of your rich text, you can store `Color` object here.
  final Color txtColor;

  ///this package depend on the `textfield`. So, it's the important one you have to set.
  final TextEditingController controller;

  ///it is a `Widget` that you can use as a textfield, but it can give you RichText callback
  GPEditortext(
      {this.onChange,
      this.textWidget,
      this.txtColor,
      @required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 10),
            child: Row(
              children: [
                IconButton(
                    icon: Icon(Icons.format_italic),
                    onPressed: () {
                      Map<String, dynamic> italic =
                          GPEditorAction.italic(this.controller);

                      this.controller.text = italic['text'];
                      controller.selection = TextSelection(
                          baseOffset: italic['start'],
                          extentOffset: italic['end']);
                      // controller.selection = TextSelection.fromPosition(
                      //     TextPosition(
                      //         offset: italic['start'],
                      //         affinity: TextAffinity.downstream));
                      if (this.textWidget != null)
                        this.textWidget(GPEditor(
                                text: this.controller.text,
                                color: this.txtColor)
                            .convert);
                    }),
                IconButton(
                    icon: Icon(Icons.format_bold),
                    onPressed: () {
                      Map<String, dynamic> bold =
                          GPEditorAction.bold(this.controller);

                      this.controller.text = bold['text'];
                      controller.selection = TextSelection.fromPosition(
                          TextPosition(
                              offset: bold['start'],
                              affinity: TextAffinity.downstream));
                      if (this.textWidget != null)
                        this.textWidget(GPEditor(
                                text: this.controller.text,
                                color: this.txtColor)
                            .convert);
                    })
              ],
            ),
          ),
          Container(
            height: 100,
            child: TextField(
              controller: this.controller,
              onChanged: (value) {
                // print(this.textWidget);
                this.onChange(this.controller.text);
                if (this.textWidget != null)
                  this.textWidget(
                      GPEditor(text: this.controller.text, color: this.txtColor)
                          .convert);
              },
              maxLines: null,
            ),
          ),
        ],
      ),
    );
  }
}
