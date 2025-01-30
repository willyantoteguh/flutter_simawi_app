import 'package:flutter/material.dart';
import 'package:flutter_simawi_app/presentation/profile/profile_screen.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/home/dashboard_screen.dart';
import '../../presentation/home/detail_screen.dart';
import '../../presentation/home/home_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _sheeletNavigatorAKey = GlobalKey<NavigatorState>(debugLabel: 'shellA');
final _sheeletNavigatorBKey = GlobalKey<NavigatorState>(debugLabel: 'shellB');

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
                        child:
                            HomeScreen(label: "A", detailsPath: "/a/details"),
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
                  pageBuilder: (context, state) => const NoTransitionPage(
                        child: ProfileScreen(),
                      ),
                  routes: [
                    GoRoute(
                        path: 'details',
                        builder: (context, state) =>
                            const DetailScreen(label: "B"))
                  ])
            ]),
          ],
        )
      ]);
}
