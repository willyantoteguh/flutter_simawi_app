import 'dart:ui';

import 'package:flutter/material.dart';

import '../../common/theme/color/color_name.dart';
import '../../common/theme/text/base_text.dart';

class PrimaryButton extends StatelessWidget {
  double height;
  double? width;
  String title;
  Color? color;
  Widget? icon;
  TextStyle? textStyle;

  void Function()? onPressed;

  PrimaryButton({
    Key? key,
    required this.height,
    this.width,
    required this.title,
    this.color,
    this.icon,
    this.textStyle,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: ColorName.mainColor,
          ),
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: textStyle ??
                      BaseText.whiteText14
                          .copyWith(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
