import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_simawi_app/common/constants/local_images.dart';
import 'package:flutter_simawi_app/presentation/profile/user_management_screen.dart';
import 'package:flutter_simawi_app/presentation/widgets/custom_appbar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../common/theme/color/color_name.dart';
import '../../common/theme/text/base_text.dart';
import '../widgets/tile_menu.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.whiteColor,
      appBar: customAppBar(
        context,
        label: "My Profile",
      ),
      body: Container(
        margin: EdgeInsets.all(12.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Stack(
                  children: [
                    Image.asset(
                      LocalImages.profileImage,
                      fit: BoxFit.cover,
                      height: 106.w,
                      width: 106.w,
                    ),
                    Positioned(
                        bottom: 2,
                        right: 1,
                        child: SvgPicture.asset(LocalImages.editIcon))
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                "John Doe",
                style: BaseText.blackText18
                    .copyWith(fontWeight: BaseText.semiBold),
              ),
              SizedBox(height: 28.h),
              tileMenu(icon: Icons.person_outline, label: "Profile"),
              SizedBox(height: 14.h),
              tileMenu(
                onTap: () => context.go('/d/user-table'),
                icon: Icons.people_alt_outlined,
                label: "User Management",
              ),
              SizedBox(height: 14.h),
              tileMenu(
                icon: CupertinoIcons.settings,
                label: "Settings",
              ),
              SizedBox(height: 14.h),
              tileMenu(
                icon: Icons.help_outline_sharp,
                label: "Help",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
