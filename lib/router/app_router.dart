import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:psico_educativa_app/main.dart';
import 'package:psico_educativa_app/provider/auth_provider.dart';
import 'package:psico_educativa_app/router/app_router_notifier.dart';
import 'package:psico_educativa_app/screens/screens.dart';

final goRouterProvider = Provider((ref) {
  final goRouterNotifier = ref.read(goRouterNotifierProvider);
  return GoRouter(
      initialLocation: SignInScreen.routeName,
      /* initialLocation: '/games/keyboard_sign_page', */
      refreshListenable: goRouterNotifier,
      routes: [
        GoRoute(
          path: CheckOutStatusScreen.routeName,
          builder: (context, state) => const CheckOutStatusScreen(),
        ),
        GoRoute(
          path: SignInScreen.routeName,
          builder: (context, state) => SignInScreen(),
        ),
        GoRoute(
          path: RegisterScreen.routeName,
          builder: (context, state) => RegisterScreen(),
        ),
        GoRoute(
          path: ForgotPasswordScreen.routeName,
          builder: (context, state) => ForgotPasswordScreen(),
        ),
        GoRoute(
          path: VerificationCodeScreen.routeName,
          builder: (context, state) => const VerificationCodeScreen(),
        ),
        GoRoute(
          path: HomeScreen.routeName,
          builder: (context, state) => HomeScreen(),
        ),
        GoRoute(
          path: UserProfileScreen.routeName,
          builder: (context, state) => const UserProfileScreen(),
        ),
        GoRoute(
          path: NotificationsScreen.routeName,
          builder: (context, state) => const NotificationsScreen(),
        ),
        GoRoute(
          path: MapFindLocationScreen.routeName,
          builder: (context, state) => const MapFindLocationScreen(),
        ),
        GoRoute(
          path: '${CourseEnrollmentScreen.routeName}/:id_course',
          builder: (context, state) {
            final idCourse = state.pathParameters['id_course'];
            return CourseEnrollmentScreen(
              idCourse: int.parse(idCourse!),
            );
          },
        ),
        /* GoRoute(
          path: '${CourseEnrollment.routeName}/:id_course',
          builder: (context, state) {
            final idCourse = state.pathParameters['id_course'];
            return CourseEnrollment(
              idCourse: int.parse(idCourse!),
            );
          },
        ), */
      ],
      redirect: (context, state) {
        final login = SignInScreen.routeName;
        final register = RegisterScreen.routeName;
        final forgotPassword = ForgotPasswordScreen.routeName;
        final checkOutStatus = CheckOutStatusScreen.routeName;
        const verificationCodeScreen = VerificationCodeScreen.routeName;

        final publicRoutes = [
          login,
          register,
          forgotPassword,
          verificationCodeScreen
        ];

        final isGoingTo = state.matchedLocation;
        final authStatus = goRouterNotifier.authStatus;

        if (isGoingTo == checkOutStatus && authStatus == AuthStatus.checking)
          return null;

        if (authStatus == AuthStatus.noAuthenticated) {
          if (publicRoutes.contains(isGoingTo)) {
            return null;
          }
        }
        // Si el usuario está autenticado
        if (authStatus == AuthStatus.authenticated) {
          // Si está intentando acceder a una ruta pública o `CheckOutStatusScreen`, redirigir al HomeScreen.

          if (publicRoutes.contains(isGoingTo) || isGoingTo == checkOutStatus) {
            return HomeScreen.routeName;
          }
        }
        return null;
      });
});
