import 'package:flutter/material.dart';

import '../../common/theme/color/color_name.dart';
import '../../common/theme/text/base_text.dart';

ListTile tileMenu({
  required IconData icon,
  required String label,
  void Function()? onTap,
}) {
  return ListTile(
    onTap: onTap,
    leading: CircleAvatar(
      backgroundColor: ColorName.main2Color,
      maxRadius: 25,
      child: Center(
        // padding: EdgeInsets.all(4.w),
        child: Icon(
          icon,
          color: ColorName.mainColor,
        ),
      ),
    ),
    title: Text(label,
        style: BaseText.blackText14.copyWith(fontWeight: BaseText.regular)),
    trailing: const Icon(
      Icons.arrow_forward_ios,
      color: ColorName.main2Color,
    ),
  );
}
