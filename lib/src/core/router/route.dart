import 'package:buku_tamu/src/features/auth/presentation/pages/login_screen.dart';
import 'package:buku_tamu/src/features/auth/presentation/pages/register_screen.dart';
import 'package:buku_tamu/src/features/guest/presentation/pages/guest_screen.dart';
import 'package:buku_tamu/src/features/home/presentation/pages/detail_recent_visitor.dart';
import 'package:buku_tamu/src/features/home/presentation/pages/form_guest.dart';
import 'package:buku_tamu/src/shared/presentation/bottom_bar_navigation.dart';
import 'package:buku_tamu/src/shared/presentation/main_layout.dart';
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
