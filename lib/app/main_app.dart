import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_simawi_app/presentation/profile/profile_screen.dart';

import '../common/navigation/app_router.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 800),
        builder: (_, child) {
          return MaterialApp(
            // routerConfig: AppRouter().goRouter,
            debugShowCheckedModeBanner: false,
            home: const ProfileScreen(),
            theme: ThemeData.light(useMaterial3: false),
          );
        });
  }
}
