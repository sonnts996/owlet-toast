/*
 Created by Thanh Son on 11/10/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AnimatedToast extends StatefulWidget {
  const AnimatedToast({super.key, required this.message});

  final String message;

  @override
  State<AnimatedToast> createState() => _AnimatedToastState();
}

class _AnimatedToastState extends State<AnimatedToast>
    with TickerProviderStateMixin {
  bool shouldShownText = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 1), // lottie duration
      () {
        setState(() {
          shouldShownText = true;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(8),
      height: 48,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 3,
                spreadRadius: 4)
          ]),
      child: AnimatedSize(
        duration: const Duration(milliseconds: 350),
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/success_animations.json',
              height: 32,
              width: 32,
              repeat: false,
            ),
            if (shouldShownText)
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Text(
                  widget.message,
                  style: const TextStyle(color: Colors.black),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
