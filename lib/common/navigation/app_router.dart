import 'package:flutter/material.dart';
import 'package:flutter_simawi_app/presentation/history/patient_history_screen.dart';
import 'package:flutter_simawi_app/presentation/profile/profile_screen.dart';
import 'package:flutter_simawi_app/presentation/profile/user_management_screen.dart';
import 'package:flutter_simawi_app/presentation/registration/patient_registration_screen.dart';
import 'package:flutter_simawi_app/presentation/registration/patient_screen.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/home/dashboard_screen.dart';
import '../../presentation/home/detail_screen.dart';
import '../../presentation/home/home_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _sheeletNavigatorAKey = GlobalKey<NavigatorState>(debugLabel: 'shellA');
final _sheeletNavigatorBKey = GlobalKey<NavigatorState>(debugLabel: 'shellB');
final _sheeletNavigatorCKey = GlobalKey<NavigatorState>(debugLabel: 'shellC');
final _sheeletNavigatorDKey = GlobalKey<NavigatorState>(debugLabel: 'shellD');

class AppRouter {
  final goRouter = GoRouter(
      initialLocation: '/a',
      navigatorKey: _rootNavigatorKey,
      debugLogDiagnostics: true,
      routes: [
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return DashboardScreen(navigationShell: navigationShell);
          },
          branches: [
            StatefulShellBranch(navigatorKey: _sheeletNavigatorAKey, routes: [
              GoRoute(
                  path: '/a',
                  pageBuilder: (context, state) => const NoTransitionPage(
                        child: HomeScreen(
                            label: "Home", detailsPath: "/a/details"),
                      ),
                  routes: [
                    GoRoute(
                        path: 'details',
                        builder: (context, state) =>
                            const DetailScreen(label: "A"))
                  ])
            ]),
            StatefulShellBranch(navigatorKey: _sheeletNavigatorBKey, routes: [
              GoRoute(
                path: '/b',
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: PatientHistoryScreen()),
              )
            ]),
            StatefulShellBranch(navigatorKey: _sheeletNavigatorCKey, routes: [
              GoRoute(
                path: '/c',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: PatientScreen(),
                ),
                // routes: [
                //   GoRoute(
                //       path: 'details',
                //       builder: (context, state) => const PatientRegistration())
                // ],
              )
            ]),
            StatefulShellBranch(navigatorKey: _sheeletNavigatorDKey, routes: [
              GoRoute(
                  path: '/d',
                  pageBuilder: (context, state) => const NoTransitionPage(
                        child: ProfileScreen(),
                      ),
                  routes: [
                    GoRoute(
                        path: 'user-table',
                        builder: (context, state) =>
                            const UserManagementScreen())
                  ])
            ]),
          ],
        )
      ]);
}
