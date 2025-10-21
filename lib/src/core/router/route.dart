import 'package:buku_tamu/src/features/auth/presentation/pages/login_screen.dart';
import 'package:buku_tamu/src/features/auth/presentation/pages/register_screen.dart';
import 'package:buku_tamu/src/features/guest/presentation/pages/guest_screen.dart';
import 'package:buku_tamu/src/features/home/presentation/widgets/detail_recent_visitor.dart';
import 'package:buku_tamu/src/features/home/presentation/widgets/form_guest.dart';
import 'package:buku_tamu/src/shared/presentation/bottom_bar_navigation.dart';
import 'package:buku_tamu/src/shared/presentation/main_layout.dart';
import 'package:buku_tamu/src/shared/presentation/splash_screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/splash',
  routes: [
    /// Splash route untuk cek login pertama kali
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),

    /// Route guest (kalau user belum login)
    GoRoute(
      path: '/guest',
      builder: (context, state) => MainLayout(
        title: 'Guest',
        child: const GuestScreen(),
      ),
    ),

    /// Halaman auth
    GoRoute(
      path: '/login',
      builder: (context, state) => MainLayout(
        title: 'Login',
        child: const LoginScreen(),
      ),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => MainLayout(
        title: 'Register',
        child: const RegisterScreen(),
      ),
    ),

    /// Halaman utama setelah login
    GoRoute(
      path: '/home',
      builder: (context, state) => const NavigationBar(),
      routes: [
        GoRoute(
          path: 'detail-recent-visitor',
          builder: (context, state) => const DetailRecentVisitor(),
        ),
        GoRoute(
          path: 'formguest',
          builder: (context, state) => const FormGuest(),
        ),
      ],
    ),
  ],
);