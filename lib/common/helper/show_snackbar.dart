import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:music_app/core/configs/theme/app_color.dart';

void showNotifyMessage(BuildContext? context, String message, {String? debug, Color? color, bool isShowingMessage = false}) {
  if (isShowingMessage || context == null || !context.mounted) {
    if (kDebugMode) {
      print("showNotifyMessage $message");
    }
    return;
  }
  isShowingMessage = true;
  Widget messageUI = Container(
    decoration: BoxDecoration(color: color ?? AppColors.primary, borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(24), bottomRight: Radius.circular(24))),
    child: SafeArea(
        top: true,
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(debug == null ? message : "$message - $debug", style: const TextStyle(color: Colors.white, fontSize: 16), textAlign: TextAlign.center),
            ],
          ),
        )),
  );
  var timer = Timer(const Duration(seconds: 2), () {
    if (context.mounted) {
      Navigator.of(context).pop();
    }
  });
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    useRootNavigator: true,
    transitionDuration: const Duration(milliseconds: 250),
    barrierLabel: MaterialLocalizations.of(context).dialogLabel,
    barrierColor: Colors.black.withOpacity(0.1),
    pageBuilder: (context, _, __) {
      return messageUI;
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: CurvedAnimation(parent: animation, curve: Curves.easeOutCubic).drive(Tween<Offset>(begin: const Offset(0, -1.0), end: Offset.zero)),
        child: Column(
          children: [
            Material(
              color: Colors.transparent,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [messageUI],
              ),
            )
          ],
        ),
      );
    },
  ).then((value) => {
    if (timer.isActive) {timer.cancel()},
    isShowingMessage = false,
  });
}
