import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hms_app/entities/auth/auth.dart';
import 'package:hms_app/entities/chat/chat.dart';
import 'package:hms_app/entities/current_user/current_user.dart';
import 'package:hms_app/entities/dashboard.dart';
import 'package:hms_app/entities/doctorsscreen/doctorscenter.dart';
import 'package:hms_app/entities/food/foodlist.dart';
import 'package:hms_app/entities/physical_activities/activities_screen.dart';
import 'package:hms_app/entities/profile/profile.dart';
import 'package:hms_app/entities/users/users.dart';
import 'package:hms_app/entities/users_info/personal_data.dart';
import 'package:hms_app/repositories/data_service.dart';

final DataService service = DataService();

class GoRouteGuarded extends GoRoute {
  GoRouteGuarded(
      {required super.path, super.builder, super.redirect, super.routes});

  @override
  GoRouterRedirect? get redirect {
    return (BuildContext context, GoRouterState state) async {
      if (!await service.checkAuth()) {

        return "/login";
      }
      if (!await service.isVerified()) {
        return "/verification";
      } 
      if(!await service.isFirstEntry()) {
        return "/personal-input";
      }
      return null;
    };
  }
}


// GoRouter configuration
final router = GoRouter(
  initialLocation: "/chat",
  routes: [
    ShellRoute(
      routes: [
        GoRoute(
          path: '/login',
          pageBuilder: (context, state) {
            return const NoTransitionPage(child: LoginScreen());
          },
        ),
        GoRoute(
          path: '/email-reset',
          pageBuilder: (context, state) {
            return const NoTransitionPage(child: EmailReset());
          },
        ),
        GoRoute(
          path: '/sms-reset',
          pageBuilder: (context, state) {
            return const NoTransitionPage(child: SmsReset());
          },
        ),
         GoRoute(
          name: "reset",
          path: '/reset',
          pageBuilder: (context, state) {
            return  NoTransitionPage(child: ResetScreen(from: state.uri.queryParameters["from"]!,));
          },
        ),
        GoRoute(
          path: '/onboarding',
          pageBuilder: (context, state) {
            return const NoTransitionPage(child: OnboardingScreen());
          },
        ),
        GoRoute(
          path: '/verification',
          pageBuilder: (context, state) {
            return const NoTransitionPage(child: VerificationScreen());
          },
        ),
        GoRoute(path: '/personal-input',
          pageBuilder: (context, state) {
            return const NoTransitionPage(child: PersonalInfoInputScreen());
          },
        )
      ],
      builder: (context, state, child) => AuthScreen(
        child: child,
      ),
    ),
    StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            DashboardScreen(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(routes: [
            GoRouteGuarded(
              path: '/profile',
              builder: (context, state) => const ProfileScreen(),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRouteGuarded(
                path: '/users',
                builder: (context, state) => const UsersPage(),
                routes: [
                  GoRouteGuarded(
                    path: ':userId',
                    builder: (context, state) => CurrentUserPage(
                      userId: state.pathParameters['userId']!,
                    ),
                  ),
                ]),
          ]),
          StatefulShellBranch(routes: [
            GoRouteGuarded(
              path: '/chat',
              builder: (context, state) => const ChatScreen(),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRouteGuarded(
              path: '/activity',
              builder: (context, state) => const ActivitiesScreen(),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRouteGuarded(
              path: '/food',
              builder: (context, state) => const FoodTable(),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRouteGuarded(
              path: '/info',
              builder: (context, state) => const PersonalData(),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRouteGuarded(
              path: '/center',
              builder: (context, state) => const DoctorCenter(),
            ),
          ]),
        ]),
  ],
);
