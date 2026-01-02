import 'package:buku_tamu/src/features/history/presentation/bloc/all_history/all_history_bloc.dart';
import 'package:buku_tamu/src/features/history/presentation/bloc/all_history/all_history_event.dart';
import 'package:buku_tamu/src/features/history/presentation/bloc/all_history/all_history_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllGuest extends StatelessWidget {
  const AllGuest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Guests'), centerTitle: true),
      body: BlocBuilder<AllHistoryBloc, AllHistoryState>(
        builder: (context, state) {
          if (state.status == AllHistoryStatus.loading &&
              state.histories.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status == AllHistoryStatus.failure &&
              state.histories.isEmpty) {
            return const Center(child: Text('Failed to load history'));
          }

          return RefreshIndicator(
            onRefresh: () async {
              context.read<AllHistoryBloc>().add(AllHistoryFetch(limit: 10));
            },
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: state.hasReachedMax
                  ? state.histories.length
                  : state.histories.length + 1,
              itemBuilder: (context, index) {
                if (index == state.histories.length) {
                  context.read<AllHistoryBloc>().add(
                    AllHistoryLoadMore(limit: 10),
                  );

                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  );
                }

                final history = state.histories[index];

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                    title: Text(history.user.fullName),
                    subtitle: Text(
                      'Visited on ${history.history.createdAt.toLocal().toString().split(' ')[0]}',
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
