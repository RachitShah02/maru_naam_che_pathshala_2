import 'package:flutter/material.dart';
import 'package:maru_naam_che_pathshala_2/screens/intro/intro_screen.dart';
import 'package:maru_naam_che_pathshala_2/utils/utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool ani = false;
  @override
  void initState() {
    super.initState();
    statusBarColor();
    animate();
  }

  void animate() async {
    await Future.delayed(const Duration(milliseconds: 100));
    ani = true;
    setState(() {});
    await Future.delayed(const Duration(seconds: 2));
    Get.to(() =>
        const IntroScreen()); // TODO : Manage to IntroScreen or Login or Home
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedContainer(
          alignment: Alignment.center,
          duration: const Duration(seconds: 1),
          width: !ani ? 0 : 200,
          height: !ani ? 0 : 200,
          child: Image.asset(
            logo,
          ),
        ),
      ),
    );
  }
}
