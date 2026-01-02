import 'package:buku_tamu/injection_container.dart';
import 'package:buku_tamu/src/features/history/presentation/pages/all-guests/presentation/all_guest.dart';
import 'package:buku_tamu/src/features/history/presentation/bloc/all_history/all_history_bloc.dart';
import 'package:buku_tamu/src/features/history/presentation/bloc/all_history/all_history_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllGuestPage extends StatelessWidget {
  const AllGuestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AllHistoryBloc>(
          create: (_) => sl<AllHistoryBloc>()..add(AllHistoryFetch(limit: 10)),
          
        ),
      ],
      child: AllGuest(),
    );
  }
}
