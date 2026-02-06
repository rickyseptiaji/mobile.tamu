import 'package:buku_tamu/src/features/history/presentation/bloc/home_history/home_history_event.dart';
import 'package:buku_tamu/src/features/history/presentation/bloc/home_history/home_history_bloc.dart';
import 'package:buku_tamu/src/presentation/pages/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../injection_container.dart' as di;
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.sl<HomeHistoryBloc>()
        ..add(HomeHistoryFetch()),
      child: const HomeView(),
    );
  }
}
