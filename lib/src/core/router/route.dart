import 'package:buku_tamu/src/features/auth/presentation/pages/login_screen.dart';
import 'package:buku_tamu/src/features/auth/presentation/pages/register_screen.dart';
import 'package:buku_tamu/src/features/guest/presentation/pages/guest_screen.dart';
import 'package:buku_tamu/src/features/home/presentation/pages/DetailRecentVisitor.dart';
import 'package:buku_tamu/src/features/home/presentation/pages/FormGuest.dart';
import 'package:buku_tamu/src/shared/presentation/bottomBarNavigation.dart';
import 'package:buku_tamu/src/shared/presentation/mainLayout.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, state) => MainLayout(
        title: 'Guest',
        child: const GuestScreen(),
      ),
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
    GoRoute(
      path: '/home/detail-recent-visitor',
      builder: (context, state) => DetailRecentVisitor(),
    ),
    GoRoute(path: '/home/formguest', builder: (context, state) => FormGuest()),
  ],
);
