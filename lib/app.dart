import 'package:buku_tamu/src/core/helper/theme.dart';
import 'package:flutter/material.dart';
import 'package:buku_tamu/src/core/router/route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, bool>(
      builder: (context, isDark) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',

          theme: ThemeData(
            brightness: Brightness.light,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF4C7380),
              brightness: Brightness.light,
            ),
          ),

          darkTheme: ThemeData(
            brightness: Brightness.dark,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF4C7380),
              brightness: Brightness.dark,
            ),
          ),

          themeMode: isDark ? ThemeMode.dark : ThemeMode.light,

          routerConfig: router,
        );
      },
    );
  }
}
