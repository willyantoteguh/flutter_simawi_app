import 'package:flutter/material.dart';

import '../../common/theme/color/color_name.dart';
import '../../common/theme/text/base_text.dart';

customAppBar(BuildContext context, {required String label}) {
  return AppBar(
    leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: const Icon(Icons.arrow_back_ios, color: ColorName.mainColor)),
    title: Text(
      label,
      style: BaseText.mainText18.copyWith(
        fontWeight: BaseText.semiBold,
      ),
    ),
    centerTitle: true,
    backgroundColor: ColorName.whiteColor,
    elevation: 0,
    scrolledUnderElevation: 4,
    toolbarHeight: 75,
  );
}
