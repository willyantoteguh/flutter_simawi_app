import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/theme/color/color_name.dart';
import '../../common/theme/text/base_text.dart';

class CustomPasswordTextfield extends StatefulWidget {
  final TextStyle? fillTextStyle;
  final String hintText;
  final TextEditingController? controller;
  final bool? isTextArea;
  void Function(String)? onChanged;
  void Function(String)? onSubmit;
  String? Function(String?)? validator;
  final EdgeInsets? contentPadding;
  final Color? borderColor;

  CustomPasswordTextfield({
    super.key,
    this.fillTextStyle,
    required this.hintText,
    this.controller,
    this.isTextArea = false,
    this.onChanged,
    this.onSubmit,
    this.validator,
    this.contentPadding,
    this.borderColor,
  });

  @override
  State<CustomPasswordTextfield> createState() =>
      _CustomPasswordTextfieldState();
}

class _CustomPasswordTextfieldState extends State<CustomPasswordTextfield> {
  bool isSecure = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        obscureText: isSecure,
        obscuringCharacter: '*',
        controller: widget.controller,
        validator: widget.validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onTapOutside: (event) => FocusManager.instance.primaryFocus!.unfocus(),
        onChanged: widget.onChanged,
        onFieldSubmitted: widget.onSubmit,
        // k style: widget.fillTextStyle ??
        style: BaseText.mainText12.copyWith(
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: BaseText.subText12.copyWith(
              fontWeight: FontWeight.w300,
              color: ColorName.activeTextColor,
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13.r),
                borderSide: BorderSide(
                  color: Colors.white.withOpacity(0.06),
                )),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13.r),
                borderSide: BorderSide(
                  color: (widget.borderColor) ?? Colors.white.withOpacity(0.06),
                )),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13.r),
                borderSide: BorderSide(
                  color: Colors.white.withOpacity(0.06),
                )),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13.r),
                borderSide: const BorderSide(color: Colors.red)),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 16.w, vertical: 13.h),
            // hoverColor: ColorName.mainColor,
            // focusColor: ColorName.mainColor,
            fillColor: ColorName.accentColor,
            filled: true,
            suffixIcon: Container(
              width: 18,
              height: 18,
              margin: const EdgeInsets.only(top: 11, bottom: 11, right: 16),
              alignment: Alignment.center,
              child: Transform.scale(
                scale: 1.0,
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      isSecure = !isSecure;
                    });
                    debugPrint(isSecure.toString());
                  },
                  padding: const EdgeInsets.all(0),
                  icon: Icon(
                    (!isSecure)
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: ColorName.activeTextColor,
                    // size: 18,
                  ),
                ),
              ),
            ))
        // onFieldSubmitted: onFieldSubmitted,
        );
  }
}
