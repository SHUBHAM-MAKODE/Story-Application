import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:app27/CategoryPage.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnimatedSplashScreen(
      splash: Center(child: LottieBuilder.asset('assets/anim.json')),
      nextScreen: CategoryPage(),
      splashIconSize: 500,
      duration: 2400,
    ));
  }
}
