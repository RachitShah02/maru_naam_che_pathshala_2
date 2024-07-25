import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maru_naam_che_pathshala_2/screens/dashboard/dashboard.dart';
import 'package:maru_naam_che_pathshala_2/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        home: const DashBoardScreen(),
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        theme: ThemeData(
          cardTheme: const CardTheme(color: Colors.white),
          fontFamily: GoogleFonts.poppins().fontFamily,
          primaryColor: AppColors.primaryColor,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
              titleTextStyle:
                  const TextStyle(color: Colors.white, fontSize: 18),
              backgroundColor: AppColors.primaryColor,
              iconTheme: const IconThemeData(color: Colors.white)),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                  backgroundColor:
                      WidgetStatePropertyAll(AppColors.primaryColor))),
        ));
  }
}
