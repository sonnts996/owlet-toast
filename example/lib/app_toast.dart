/*
 Created by Thanh Son on 11/10/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'package:example/advance/animated_size_toast.dart';
import 'package:example/advance/lottie_controller_toast.dart';
import 'package:example/ulitities.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:owlet_toast/owlet_toast.dart';

enum ToastType {
  error,
  information,
  warning,
  success,
  lottie_controler,
  animated_toast;
}

class AppToast extends OwletToast<ToastType, String> {
  const AppToast({required super.overlayManager});

  Future<R?> showInformation<R extends Object>(String message) {
    return show(
        type: ToastType.information,
        data: message,
        alignment: const Alignment(0, -0.7),
        transitionDelegate: const TranslateTransitionDelegate(direction: Alignment.topCenter),
        transitionDuration: const Duration(milliseconds: 500),
        holdDuration: const Duration(seconds: 1));
  }

  Future<R?> showError<R extends Object>(String message) {
    return show(
        type: ToastType.error,
        data: message,
        alignment: const Alignment(0, -0.7),
        transitionDelegate: const ShakeTransitionDelegate(shakeCurve: Curves.elasticInOut),
        transitionDuration: const Duration(milliseconds: 500),
        holdDuration: const Duration(seconds: 1));
  }

  Future<R?> showWaring<R extends Object>(String message) {
    return show(
        type: ToastType.warning,
        data: message,
        alignment: const Alignment(0, 0.8),
        transitionDelegate: const FadeTransitionDelegate(),
        transitionDuration: const Duration(milliseconds: 500),
        holdDuration: const Duration(seconds: 1));
  }

  Future<R?> showSuccess<R extends Object>(String message) {
    return show(
        type: ToastType.success,
        data: message,
        alignment: const Alignment(0, -0.7),
        transitionDelegate: const FadeTransitionDelegate(),
        transitionDuration: const Duration(milliseconds: 200),
        holdDuration: const Duration(seconds: 2));
  }

  Future<R?> showLottieSuccess<R extends Object>(String message) {
    return show(
        type: ToastType.lottie_controler,
        data: message,
        alignment: const Alignment(0, -0.7),
        transitionDelegate: const FadeTransitionDelegate(),
        transitionDuration: const Duration(seconds: 1),
        holdDuration: const Duration(seconds: 1));
  }

  Future<R?> showAnimated<R extends Object>(String message) {
    return show(
        type: ToastType.animated_toast,
        data: message,
        alignment: const Alignment(0, -0.7),
        transitionDelegate: const FadeTransitionDelegate(),
        transitionDuration: const Duration(milliseconds: 200),
        holdDuration: const Duration(seconds: 2));
  }

  @override
  Widget buildToast(BuildContext context, ToastEntry<ToastType, String> entry) {
    return switch (entry.type) {
      ToastType.error => Toasty(
          icon: const Icon(
            Icons.error_outline_rounded,
            color: Colors.white,
          ),
          color: Colors.red,
          message: entry.data,
        ),
      ToastType.information => Toasty(
          icon: const Icon(
            Icons.info_outlined,
            color: Colors.blue,
          ),
          color: Colors.white,
          message: entry.data,
        ),
      ToastType.warning => Toasty(
          icon: const Icon(
            Icons.warning_amber_outlined,
            color: Colors.white,
          ),
          color: Colors.orange,
          message: entry.data),
      ToastType.success => Toasty(
          icon: Lottie.asset(
            'assets/success_animations.json',
            height: 32,
            width: 32,
            repeat: false,
          ),
          color: Colors.white,
          message: entry.data),
      ToastType.lottie_controler => LottieSuccessToast(
          delay: const Duration(milliseconds: 1),
          message: entry.data,
        ),
      ToastType.animated_toast => AnimatedToast(message: entry.data),
    };
  }
}

class Toasty extends StatelessWidget {
  const Toasty({super.key, required this.icon, required this.color, required this.message});

  final Widget icon;
  final Color color;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 3, spreadRadius: 4)]),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          icon,
          const SizedBox(width: 8),
          Text(
            message,
            style: TextStyle(color: color.textColor),
          ),
        ],
      ),
    );
  }
}

