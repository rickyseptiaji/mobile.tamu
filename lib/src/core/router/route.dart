import 'package:buku_tamu/src/features/form_visitor/presentation/pages/form.dart';
import 'package:buku_tamu/src/features/history/presentation/pages/all-guests/presentation/all_guest_page.dart';
import 'package:buku_tamu/src/features/auth/presentation/pages/login_screen.dart';
import 'package:buku_tamu/src/features/auth/presentation/pages/register_screen.dart';
import 'package:buku_tamu/src/features/guest/presentation/pages/guest_scope.dart';
import 'package:buku_tamu/src/features/history/presentation/pages/detail.dart';
import 'package:buku_tamu/src/features/settings/presentation/pages/settings_screen.dart';
import 'package:buku_tamu/src/presentation/pages/home_page.dart';
import 'package:buku_tamu/src/shared/presentation/bottom_bar_navigation.dart';
import 'package:buku_tamu/src/shared/presentation/main_layout.dart';
import 'package:buku_tamu/src/shared/presentation/splash_screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/splash',
  routes: [
    /// Splash
    GoRoute(path: '/splash', builder: (context, state) => const SplashScreen()),

    /// Guest (belum login)
    GoRoute(
      path: '/guest',
      builder: (context, state) =>
          MainLayout(title: 'Guest', child: const GuestScope()),
    ),

    /// Auth
    GoRoute(
      path: '/login',
      builder: (context, state) =>
          MainLayout(title: 'Login', child: const LoginScreen()),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) =>
          MainLayout(title: 'Register', child: const RegisterScreen()),
    ),

    /// =============================
    /// SHELL (SETELAH LOGIN)
    /// =============================
    ShellRoute(
      builder: (context, state, child) {
        return NavigationBar(child: child);
      },
      routes: [
        GoRoute(path: '/home', builder: (_, __) => const HomePage()),
        GoRoute(path: '/settings', builder: (_, __) => const SettingsScreen()),
      ],
    ),

    GoRoute(
      path: '/home/form-guest',
      builder: (context, state) => const FormPage(),
    ),

    GoRoute(
      path: '/home/all-guest',
      builder: (context, state) => const AllGuestPage(),
    ),
    GoRoute(
      path: '/guest/:slug',
      builder: (context, state) {
        final slug = state.pathParameters['slug']!;
        return DetailPage(slug: slug);
      },
    ),
  ],
);
