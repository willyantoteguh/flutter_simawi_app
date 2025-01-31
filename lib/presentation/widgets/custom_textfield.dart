import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/theme/color/color_name.dart';
import '../../common/theme/text/base_text.dart';

class CustomTextField extends StatefulWidget {
  final TextStyle? fillTextStyle;
  final String hintText;
  final TextEditingController? controller;
  final bool? isTextArea;
  final bool readOnly;
  void Function(String)? onChanged;
  void Function(String)? onSubmit;
  String? Function(String?)? validator;
  final Color? borderColor;

  CustomTextField({
    super.key,
    this.fillTextStyle,
    required this.hintText,
    this.controller,
    this.isTextArea = false,
    this.readOnly = true,
    this.onChanged,
    this.onSubmit,
    this.validator,
    this.borderColor,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        enabled: widget.readOnly,
        controller: widget.controller,
        validator: widget.validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onTapOutside: (event) => FocusManager.instance.primaryFocus!.unfocus(),
        onChanged: widget.onChanged,
        onFieldSubmitted: widget.onSubmit,
        keyboardType:
            (widget.isTextArea == true) ? TextInputType.multiline : null,
        minLines: (widget.isTextArea == true) ? 3 : 1,
        maxLines: (widget.isTextArea == true) ? null : 1,
        style: widget.fillTextStyle ??
            BaseText.mainText12.copyWith(
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
          disabledBorder: OutlineInputBorder(
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
        )
        // onFieldSubmitted: onFieldSubmitted,
        );
  }
}
