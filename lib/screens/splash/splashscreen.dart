import 'package:flutter/material.dart';
import 'package:maru_naam_che_pathshala_2/screens/intro/intro_screen.dart';
import 'package:maru_naam_che_pathshala_2/screens/login/login.dart';
import 'package:maru_naam_che_pathshala_2/screens/screens.dart';
import 'package:maru_naam_che_pathshala_2/utils/utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool progress = false;
  @override
  void initState() {
    super.initState();
    statusBarColor();
    if (box.read(Keys.isFirst) == null) {
      box.write(Keys.isFirst, false);
    }
    animate();
  }

  Future<String> checkLogin() async {
    return await ApiService.getData(endPoint: 'splash');
  }

  void animate() async {
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      progress = true;
    });
    Widget nextScreen = await determineNextScreen();
    await Future.delayed(const Duration(seconds: 2));
    Get.offAll(() => nextScreen, transition: Transition.leftToRight);
  }

  Future<Widget> determineNextScreen() async {
    final bool isFirstTime = box.read(Keys.isFirst) ?? true;
    if (isFirstTime) {
      return const IntroScreen();
    }
    final String loginStatus = await checkLogin();
    if (loginStatus != "[]") {
      return const DashBoardScreen();
    }
    return const LoginScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          alignment: Alignment.center,
          width: 200,
          height: 240,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                logo,
              ),
              10.vs(),
              Visibility(
                visible: progress,
                child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
