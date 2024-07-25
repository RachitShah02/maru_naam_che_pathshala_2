import 'package:flutter/material.dart';
import 'package:maru_naam_che_pathshala_2/utils/utils.dart';

class PinLoinScreen extends StatefulWidget {
  const PinLoinScreen({super.key});

  @override
  State<PinLoinScreen> createState() => _PinLoinScreenState();
}

class _PinLoinScreenState extends State<PinLoinScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          alignment: Alignment.center,
          width: Get.width * 0.80,
          height: Get.height * 0.30,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Row(
                children: [
                  "Login With MNP ID #"
                      .text
                      .color(AppColors.primaryColor)
                      .xl
                      .bold
                      .make(),
                  const Spacer(),
                  CloseButton(
                    color: AppColors.primaryColor,
                  ),
                ],
              ),
              TextField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    floatingLabelStyle:
                        TextStyle(color: AppColors.primaryColor),
                    label: "ENTER MNP ID #".text.make(),
                    alignLabelWithHint: true),
              ),
              Divider(
                color: AppColors.primaryColor,
                thickness: 3,
              ),
              20.vs(),
              ElevatedButton.icon(
                onPressed: () {},
                label: "LOGIN".text.white.make().marginOnly(left: 10),
                icon: Visibility(
                  visible: false,
                  replacement: const Icon(
                    Icons.login,
                    color: Colors.white,
                  ),
                  child: const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  ).marginOnly(left: 10),
                ),
                iconAlignment: IconAlignment.end,
              )
            ],
          ),
        ),
      ),
    );
  }
}
