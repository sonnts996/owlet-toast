/*
 Created by Thanh Son on 11/10/2023.
 Copyright (c) 2023 . All rights reserved.
*/

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../app_toast.dart';

class LottieSuccessToast extends StatefulWidget {
  const LottieSuccessToast(
      {super.key, required this.delay, required this.message});

  final Duration delay;
  final String message;

  @override
  State<LottieSuccessToast> createState() => _LottieSuccessToastState();
}

class _LottieSuccessToastState extends State<LottieSuccessToast>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(vsync: this);

  @override
  void initState() {
    super.initState();
    Future.delayed(widget.delay, () {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Toasty(
        icon: Lottie.asset(
          'assets/success_animations.json',
          height: 32,
          width: 32,
          repeat: false,
          controller: _controller,
          onLoaded: (p0) {
            _controller.duration = p0.duration;
          },
        ),
        color: Colors.white,
        message: widget.message);
  }
}
