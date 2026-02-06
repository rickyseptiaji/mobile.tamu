import 'package:buku_tamu/src/features/history/presentation/bloc/home_history/home_history_bloc.dart';
import 'package:buku_tamu/src/features/history/presentation/bloc/home_history/home_history_event.dart';
import 'package:buku_tamu/src/features/history/presentation/widgets/home_history_section.dart';
import 'package:buku_tamu/src/presentation/widgets/headershome.dart';
import 'package:buku_tamu/src/presentation/widgets/sectionform.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    context.read<HomeHistoryBloc>().add(HomeHistoryFetch());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const HeadersHome(),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(24),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(80)),
              ),

              child: Column(children: [SectionForm(), HomeHistorySection()]),
            ),
          ),
        ],
      ),
    );
  }
}
