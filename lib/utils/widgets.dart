import 'package:flutter/material.dart';
import 'utils.dart';

Widget heroRoute(
    {required BuildContext context,
    required String heroTag,
    required IconData icon,
    required Widget pushTo,
    Color? barrierColor,
    double size = 55,
    Color? bgColor,
    Color? iconColor}) {
  Color btnBgColor = bgColor ?? AppColors.primaryColor;
  Color btnIconColor = iconColor ?? Colors.white;
  double w = size, h = size;
  barrierColor = barrierColor ?? Colors.black54;
  return Hero(
    tag: heroTag,
    createRectTween: (begin, end) => CustomRectTween(begin: begin!, end: end!),
    child: IconButton(
      color: btnIconColor,
      style: ButtonStyle(
          fixedSize: WidgetStatePropertyAll(Size(w, h)),
          backgroundColor: WidgetStatePropertyAll(btnBgColor)),
      icon: Icon(icon),
      onPressed: () =>
          heroPush(context: context, child: pushTo, barrierColor: barrierColor),
    ),
  );
}

Widget richText(
  BuildContext context, {
  required String firstText,
  required String secondText,
  TextStyle? fstyle,
  TextStyle? sstyle,
}) {
  fstyle = fstyle ?? DefaultTextStyle.of(context).style;
  sstyle = sstyle ?? DefaultTextStyle.of(context).style;
  return RichText(
    text: TextSpan(
      style: DefaultTextStyle.of(context).style, // Default style for the text
      children: [
        TextSpan(
          text: firstText,
          style: fstyle, // Style for the label
        ),
        TextSpan(text: secondText, style: sstyle),
      ],
    ),
  );
}

class MyTextStyle {
  static TextStyle bold() => const TextStyle(fontWeight: FontWeight.bold);
  static TextStyle w100() => const TextStyle(fontWeight: FontWeight.w100);
  static TextStyle w200() => const TextStyle(fontWeight: FontWeight.w200);
  static TextStyle w300() => const TextStyle(fontWeight: FontWeight.w300);
  static TextStyle w400() => const TextStyle(fontWeight: FontWeight.w400);
  static TextStyle w500() => const TextStyle(fontWeight: FontWeight.w500);
  static TextStyle w600() => const TextStyle(fontWeight: FontWeight.w600);
  static TextStyle w700() => const TextStyle(fontWeight: FontWeight.w700);
  static TextStyle w800() => const TextStyle(fontWeight: FontWeight.w800);
  static TextStyle w900() => const TextStyle(fontWeight: FontWeight.w900);
  static TextStyle size(double size) => TextStyle(fontSize: size);
  static TextStyle fontStyle(FontStyle style) => TextStyle(fontStyle: style);
  // Method to chain multiple styles
  static TextStyle combine(TextStyle baseStyle,
      {double? fontSize, FontWeight? fontWeight, FontStyle? fontStyle}) {
    return baseStyle.copyWith(
      fontSize: fontSize ?? baseStyle.fontSize,
      fontWeight: fontWeight ?? baseStyle.fontWeight,
      fontStyle: fontStyle ?? baseStyle.fontStyle,
    );
  }
}
