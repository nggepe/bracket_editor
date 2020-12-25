import 'package:flutter/cupertino.dart';

class GPEditorAction {
  static Map<String, dynamic> italic(TextEditingController controller) {
    if (controller.selection.baseOffset <= controller.selection.extentOffset) {
      return {
        "start": controller.selection.baseOffset + 1,
        "end": controller.selection.extentOffset + 1,
        "text": controller.text.substring(0, controller.selection.baseOffset) +
            "*" +
            controller.text.substring(controller.selection.baseOffset,
                controller.selection.extentOffset) +
            "*" +
            controller.text.substring(
                controller.selection.extentOffset, controller.text.length)
      };
    } else {
      return {
        "start": controller.selection.extentOffset + 1,
        "end": controller.selection.baseOffset + 1,
        "text":
            controller.text.substring(0, controller.selection.extentOffset) +
                "*" +
                controller.text.substring(controller.selection.extentOffset,
                    controller.selection.baseOffset) +
                "*" +
                controller.text.substring(
                    controller.selection.baseOffset, controller.text.length)
      };
    }
  }

  static Map<String, dynamic> bold(TextEditingController controller) {
    if (controller.selection.baseOffset == controller.selection.extentOffset) {
      return {
        "start": controller.selection.baseOffset + 2,
        "end": controller.selection.extentOffset + 2,
        "text": controller.text.substring(0, controller.selection.baseOffset) +
            "**" +
            controller.text.substring(controller.selection.baseOffset,
                controller.selection.extentOffset) +
            "**" +
            controller.text.substring(
                controller.selection.extentOffset, controller.text.length)
      };
    } else if (controller.selection.baseOffset <
        controller.selection.extentOffset) {
      return {
        "start": controller.selection.baseOffset + 3,
        "end": controller.selection.extentOffset + 2,
        "text": controller.text.substring(0, controller.selection.baseOffset) +
            "**" +
            controller.text.substring(controller.selection.baseOffset,
                controller.selection.extentOffset) +
            "**" +
            controller.text.substring(
                controller.selection.extentOffset, controller.text.length)
      };
    } else {
      return {
        "start": controller.selection.extentOffset + 3,
        "end": controller.selection.baseOffset + 2,
        "text":
            controller.text.substring(0, controller.selection.extentOffset) +
                "**" +
                controller.text.substring(controller.selection.extentOffset,
                    controller.selection.baseOffset) +
                "**" +
                controller.text.substring(
                    controller.selection.baseOffset, controller.text.length)
      };
    }
  }
}
