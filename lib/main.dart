import 'package:buku_tamu/firebase_options.dart';
import 'package:buku_tamu/src/features/auth/presentation/bloc/auth_bloc.dart';
import './app.dart';
import 'package:buku_tamu/src/features/guest/presentation/bloc/guest_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection_container.dart' as di;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => di.sl<GuestBloc>()), BlocProvider(create: (_) => di.sl<AuthBloc>())],
      child: App(),
    );
  }
}
