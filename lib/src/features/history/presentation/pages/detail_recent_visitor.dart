import 'package:buku_tamu/src/features/history/presentation/bloc/home_history/home_history_bloc.dart';
import 'package:buku_tamu/src/features/history/presentation/bloc/home_history/home_history_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailRecentVisitor extends StatelessWidget {
  const DetailRecentVisitor({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Recent Visitor')),
      body: BlocBuilder<HomeHistoryBloc, HomeHistoryState>(
        builder: (context, state) {
          if (state.status == HomeHistoryStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == HomeHistoryStatus.success &&
              state.selectedHistory != null) {
            final history = state.selectedHistory!;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      spreadRadius: 2,
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nama:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      history.user.fullName,
                      style: TextStyle(fontSize: 16),
                    ),

                    SizedBox(height: 16),
                    Text(
                      'Kepada:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      history.user.fullName,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Deskripsi:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      history.history.description,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Tanggal:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      history.history.createdAt.toLocal().toString(),
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
