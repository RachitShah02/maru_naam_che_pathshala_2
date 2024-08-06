import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';

import 'utils.dart';

GetStorage get box => GetStorage();

class Space {
  final int size;
  Space({required this.size});
  Widget get h => SizedBox(
        width: size.toDouble(),
      );
  Widget get v => SizedBox(
        height: size.toDouble(),
      );
}

extension SpaceExtensions on int {
  Widget hs() => Space(size: this).h;

  Widget vs() => Space(size: this).v;
}

void statusBarColor(
    {Color barcolor = Colors.transparent,
    Color navigationBarColor = Colors.white,
    Brightness statsBarBright = Brightness.dark,
    Brightness navBarBright = Brightness.dark,
    Color navDividerColor = Colors.blueGrey}) {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: barcolor,
      systemNavigationBarColor: navigationBarColor,
      statusBarIconBrightness: statsBarBright,
      systemNavigationBarIconBrightness: navBarBright));
}

void heroPush(
    {required BuildContext context,
    required Widget child,
    Color? barrierColor}) {
  Navigator.push(
      context,
      HeroDialogRoute(
          cbarrierColor: barrierColor!,
          builder: (context) {
            return child;
          }));
}

class MyDate {
  static DateTime now = DateTime.now();
  static String currMonth() {
    return DateFormat.MMMM().format(now); // Gets the full month name
  }

  static String currYear() {
    return now.year.toString();
  }

  static String currDay() {
    return now.day.toString();
  }

  static String yesterday() {
    DateTime yesterday = now.subtract(const Duration(days: 1));
    return DateFormat('yyyy-MM-dd')
        .format(yesterday); // Formats the date as 'yyyy-MM-dd'
  }

  static String today() {
    return DateFormat('yyyy-MM-dd')
        .format(now); // Formats the date as 'yyyy-MM-dd'
  }
}

enum SnackBarType { danger, warning, success }

SnackbarController customSnackBar(
    {required String title,
    required String message,
    SnackBarType type = SnackBarType.danger,
    Function()? callback}) {
  Color txclr = type == SnackBarType.warning ? Colors.black : Colors.white;
  return Get.snackbar(
    "",
    "",
    backgroundColor: type == SnackBarType.danger ? Colors.red : Colors.green,
    titleText: title.text.color(txclr).make(),
    messageText: message.text.color(txclr).make(),
    snackbarStatus: (status) {
      if (status! == SnackbarStatus.CLOSED) {
        callback?.call();
      }
    },
  );
}

List<StudentModel> filterStudents() {
  final box = GetStorage();
  String? oldList = box.read(Keys.studentList);
  if (oldList == null || oldList.isEmpty) {
    return [];
  }
  List<StudentModel> studentList = studentModelListFromJson(oldList);
  List<StudentModel> filteredList = studentList.where((student) {
    return student.sid == box.read(Keys.sid);
  }).toList();
  return filteredList;
}

Future<void> launchurl(String url) async {
  if (!await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication)) {
    throw Exception('Could not launch $url');
  }
}

unFocus() => FocusManager.instance.primaryFocus?.unfocus();
String ddMMyyyy(String date) =>
    DateFormat('dd-MM-yyyy').format(DateTime.parse(date));
