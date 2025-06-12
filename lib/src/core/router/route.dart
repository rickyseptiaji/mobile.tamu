import 'package:buku_tamu/src/features/auth/presentation/pages/LoginScreen.dart';
import 'package:buku_tamu/src/features/auth/presentation/pages/RegisterScreen.dart';
import 'package:buku_tamu/src/features/guest/presentation/pages/guest.dart';

import 'package:buku_tamu/src/shared/presentation/bottomBarNavigation.dart';
import 'package:buku_tamu/src/shared/presentation/mainLayout.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, state) =>
          MainLayout(title: 'Guest', child: GuestScreen()),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) =>
          MainLayout(title: 'Login', child: LoginScreen()),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) =>
          MainLayout(title: 'Register', child: RegisterScreen()),
    ),
    GoRoute(path: '/home', builder: (context, state) => NavigationBar()),
  ],
);
