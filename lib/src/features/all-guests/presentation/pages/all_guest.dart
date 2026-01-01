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
          // 1️⃣ Loading
          if (state.status == AllHistoryStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          // 2️⃣ Failure
          if (state.status == AllHistoryStatus.failure) {
            return const Text('Failed to load history');
          }

          // 3️⃣ Empty
          if (state.histories.isEmpty) {
            return const Text('No history found');
          }

          return RefreshIndicator(
            onRefresh: () async {
              context.read<AllHistoryBloc>().add(AllHistoryFetch());
            },
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: state.histories.length,
              itemBuilder: (context, index) {
                final history = state.histories[index];
            
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                    title: Text(history.user?.fullName ?? 'Unknown'),
                    subtitle: Text(
                      'Visited on ${history.history.createdAt.toLocal().toString().split(' ')[0]}',
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
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
