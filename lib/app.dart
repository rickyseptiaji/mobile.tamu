import 'package:flutter/material.dart';
import 'package:buku_tamu/src/core/router/route.dart';

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4C7380)),
      ),
      routerConfig: router,
    );
  }
}
