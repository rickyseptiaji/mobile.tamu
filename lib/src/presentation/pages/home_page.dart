import 'package:buku_tamu/src/features/history/presentation/bloc/home_history/home_history_event.dart';
import 'package:buku_tamu/src/features/history/presentation/bloc/home_history/home_history_bloc.dart';
import 'package:buku_tamu/src/presentation/pages/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buku_tamu/injection_container.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeHistoryBloc>(
          create: (_) => sl<HomeHistoryBloc>()..add(HomeHistoryFetch()),
        ),
      ],
      child: HomeView(),
    );
  }
}
