import 'package:flutter/material.dart';
import 'package:maru_naam_che_pathshala_2/screens/login/pinlogin.dart';
import 'package:maru_naam_che_pathshala_2/screens/login/qrlogin.dart';
import 'package:maru_naam_che_pathshala_2/utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    statusBarColor(
      navigationBarColor: AppColors.primaryColor,
      statsBarBright: Brightness.light,
    );
    return Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Column(children: [
          const Spacer(
            flex: 2,
          ),
          Card(
            elevation: 15,
            shape: const CircleBorder(),
            color: Colors.transparent,
            shadowColor: Colors.pinkAccent,
            child: Image.asset(
              logo,
              width: 180,
              fit: BoxFit.fitWidth,
            ),
          ),
          HStack(
            [
              loginBtns(icon: Icons.qr_code, title: 'LOGIN WITH QR')
                  .onTap(() => Get.dialog(const QrCodeLoginScreen()))
                  .expand(),
              15.hs(),
              loginBtns(icon: Icons.numbers_rounded, title: 'LOGIN WITH MNP ID')
                  .onTap(() {
                Get.dialog(const PinLoinScreen());
              }).expand()
            ],
          ).paddingSymmetric(horizontal: 20).marginOnly(top: 30, bottom: 20),
          const Spacer(),
        ]));
  }

  Widget loginBtns({required IconData icon, required String title}) {
    return VStack([
      Icon(icon, size: 30, color: AppColors.primaryColor).centered(),
      10.vs(),
      title.text.color(AppColors.primaryColor).bold.sm.makeCentered()
    ]).box.white.roundedSM.p12.shadowSm.make();
  }
}
