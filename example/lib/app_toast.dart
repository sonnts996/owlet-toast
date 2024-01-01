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
  lottieController,
  animatedToast;
}

class AppToast {
  final OwletToast owletToast;

  AppToast({required this.owletToast});

  Future<R?> showInformation<R extends Object>(String message) {
    return owletToast.show(
        builder: (context, entry, child) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 3,
                        spreadRadius: 4)
                  ]),
              child: const Text("This is toast's message"),
            ),
        alignment: const Alignment(0, -0.7),
        transitionDelegate:
            const TranslateTransitionDelegate(direction: Alignment.topCenter),
        transitionDuration: const Duration(milliseconds: 500),
        holdDuration: const Duration(seconds: 1));
  }

  Future<R?> showError<R extends Object>(String message) {
    return owletToast.show(
        builder: (context, entry, child) => build(
              context,
              ToastType.error,
              message,
            ),
        alignment: const Alignment(0, -0.7),
        transitionDelegate:
            const ShakeTransitionDelegate(curve: Curves.elasticInOut),
        transitionDuration: const Duration(milliseconds: 500),
        holdDuration: const Duration(seconds: 1));
  }

  Future<R?> showWaring<R extends Object>(String message) {
    return owletToast.show(
        builder: (context, entry, child) => build(
              context,
              ToastType.warning,
              message,
            ),
        alignment: const Alignment(0, 0.8),
        transitionDelegate: const FadeTransitionDelegate(),
        transitionDuration: const Duration(milliseconds: 500),
        holdDuration: const Duration(seconds: 1));
  }

  Future<R?> showSuccess<R extends Object>(String message) {
    return owletToast.show(
        builder: (context, entry, child) => build(
              context,
              ToastType.success,
              message,
            ),
        alignment: const Alignment(0, -0.7),
        transitionDelegate: const FadeTransitionDelegate(),
        transitionDuration: const Duration(milliseconds: 200),
        holdDuration: const Duration(seconds: 2));
  }

  Future<R?> showLottieSuccess<R extends Object>(String message) {
    return owletToast.show(
        builder: (context, entry, child) => build(
              context,
              ToastType.lottieController,
              message,
            ),
        alignment: const Alignment(0, -0.7),
        transitionDelegate: const FadeTransitionDelegate(),
        transitionDuration: const Duration(seconds: 1),
        holdDuration: const Duration(seconds: 1));
  }

  Future<R?> showAnimated<R extends Object>(String message) {
    return owletToast.show(
        builder: (context, entry, child) => build(
              context,
              ToastType.animatedToast,
              message,
            ),
        alignment: const Alignment(0, -0.7),
        transitionDelegate: const FadeTransitionDelegate(),
        transitionDuration: const Duration(milliseconds: 200),
        holdDuration: const Duration(seconds: 2));
  }

  Widget build(BuildContext context, ToastType type, String message) {
    return switch (type) {
      ToastType.error => Toasty(
          icon: const Icon(
            Icons.error_outline_rounded,
            color: Colors.white,
          ),
          color: Colors.red,
          message: message,
        ),
      ToastType.information => Toasty(
          icon: const Icon(
            Icons.info_outlined,
            color: Colors.blue,
          ),
          color: Colors.white,
          message: message,
        ),
      ToastType.warning => Toasty(
          icon: const Icon(
            Icons.warning_amber_outlined,
            color: Colors.white,
          ),
          color: Colors.orange,
          message: message),
      ToastType.success => Toasty(
          icon: Lottie.asset(
            'assets/success_animations.json',
            height: 32,
            width: 32,
            repeat: false,
          ),
          color: Colors.white,
          message: message),
      ToastType.lottieController => LottieSuccessToast(
          delay: const Duration(milliseconds: 1),
          message: message,
        ),
      ToastType.animatedToast => AnimatedToast(message: message),
    };
  }
}

class Toasty extends StatelessWidget {
  const Toasty(
      {super.key,
      required this.icon,
      required this.color,
      required this.message});

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
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 3,
                spreadRadius: 4)
          ]),
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
