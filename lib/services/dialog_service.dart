import 'package:client/dialogs/complaint_dialog.dart';
import 'package:client/dialogs/confirm_dialog.dart';
import 'package:client/dialogs/info_dialog.dart';
import 'package:client/dialogs/time_choice_dialog.dart';
import 'package:flutter/material.dart';

class DialogService {
  const DialogService();

  //TO DO: handle height properly
  Future<void> showInfoDialog(BuildContext context, String text, double height,
      {bool isScrollAlwaysVisible = false}) async {
    await showDialog(
        context: context,
        builder: (context) => InfoDialog(
              height: height,
              text: text,
              isScrollBarAlwaysVisible: isScrollAlwaysVisible,
            ));
  }

  Future<bool> showConfirmDialog(BuildContext context, String text) async {
    bool? response = await showDialog<bool>(
        context: context, builder: (context) => ConfirmDialog(text: text));
    if (response == null) {
      return false;
    }
    return response;
  }

  Future<String?> showComplaintDialog(BuildContext context) async {
    return showDialog<String?>(
        context: context, builder: (context) => const ComplaintDialog());
  }

  Future<int?> showTimeChoiceDialog(BuildContext context) async {
    return showDialog<int?>(
        context: context, builder: (context) => const TimeChoiceDialog());
  }
}
