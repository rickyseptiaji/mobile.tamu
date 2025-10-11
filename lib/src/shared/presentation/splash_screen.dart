import 'package:buku_tamu/src/features/auth/presentation/bloc/login_bloc.dart';
import 'package:buku_tamu/src/features/auth/presentation/bloc/login_event.dart';
import 'package:buku_tamu/src/features/auth/presentation/bloc/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    context.read<LoginBloc>().add(CheckAuthEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginAuthenticated) {
          context.go( '/home');
        } else if (state is LoginUnauthenticated) {
         context.go('/login');
        }
      },
      child: Scaffold(body: Center(child: CircularProgressIndicator())),
    );
  }
}
