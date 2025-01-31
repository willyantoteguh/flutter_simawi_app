import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/theme/color/color_name.dart';

Widget buildDivider() => Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: const Divider(
        color: ColorName.grey1Color,
        thickness: 0.2,
      ),
    );
