import 'package:buku_tamu/injection_container.dart';
import 'package:buku_tamu/src/features/history/presentation/bloc/home_history/home_history_event.dart';
import 'package:buku_tamu/src/features/history/presentation/bloc/home_history/home_history_bloc.dart';
import 'package:buku_tamu/src/features/history/presentation/pages/detail_recent_visitor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailPage extends StatelessWidget {
  final String slug; 
   const DetailPage({super.key, required this.slug});

  @override
  Widget build(BuildContext context) {

    return BlocProvider<HomeHistoryBloc>(
      create: (_) => sl<HomeHistoryBloc>()
        ..add(LoadHistoryDetail(slug: slug)),
      child: DetailRecentVisitor(),
    );
  }
}

