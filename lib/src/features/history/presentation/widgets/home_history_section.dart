import 'package:buku_tamu/src/core/helper/slug.dart';
import 'package:buku_tamu/src/features/history/presentation/bloc/home_history/home_history_bloc.dart';
import 'package:buku_tamu/src/features/history/presentation/bloc/home_history/home_history_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeHistorySection extends StatelessWidget {
  const HomeHistorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeHistoryBloc, HomeHistoryState>(
      builder: (context, state) {
        // 1️⃣ Loading
        if (state.status == HomeHistoryStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        // 2️⃣ Failure
        if (state.status == HomeHistoryStatus.failure) {
          return const Text('Failed to load history');
        }

        // 3️⃣ Empty
        if (state.histories.isEmpty) {
          return const Text('No history found');
        }

        // 4️⃣ Success
        return Column(
          children: [
            Row(
              children: [
                const Text(
                  'History',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    context.push('/home/all-guest');
                  },
                  child: const Text(
                    'View All',
                    style: TextStyle(color: Color(0xFF4C7380)),
                  ),
                ),
              ],
            ),
            ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.histories.length,
              itemBuilder: (context, index) {
                final history = state.histories[index];

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                    title: Text(history.user?.fullName ?? 'Unknown'),
                    subtitle: Text(
                      'Visited on ${history.history.createdAt.toLocal().toString().split(' ')[0]}',
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      final slug = generateSlug(history.history.id);
                      context.push('/home/detail-recent-visitor/$slug');
                    },
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
