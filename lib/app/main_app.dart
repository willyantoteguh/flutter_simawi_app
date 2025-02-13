import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_simawi_app/data/model/patient.dart';
import 'package:flutter_simawi_app/presentation/history/patient_history_screen.dart';
import 'package:flutter_simawi_app/presentation/home/home_screen.dart';
import 'package:flutter_simawi_app/presentation/profile/profile_screen.dart';
import 'package:flutter_simawi_app/presentation/profile/user_management_screen.dart';
import 'package:flutter_simawi_app/presentation/registration/patient_registration_screen.dart';
import 'package:flutter_simawi_app/presentation/registration/patient_screen.dart';

import '../common/navigation/app_router.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 800),
        builder: (context, child) {
          return MaterialApp.router(
            routerConfig: AppRouter().goRouter,
            debugShowCheckedModeBanner: false,
            theme: ThemeData.light(useMaterial3: true),
          );
        });
  }
}
