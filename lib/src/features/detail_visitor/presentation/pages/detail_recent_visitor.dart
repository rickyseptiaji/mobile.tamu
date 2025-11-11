import 'package:buku_tamu/src/features/detail_visitor/presentation/bloc/detail_visitor_bloc.dart';
import 'package:buku_tamu/src/features/detail_visitor/presentation/bloc/detail_visitor_event.dart';
import 'package:buku_tamu/src/features/detail_visitor/presentation/bloc/detail_visitor_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailRecentVisitor extends StatelessWidget {
  final String slug;
  const DetailRecentVisitor({super.key, required this.slug});

  @override
  Widget build(BuildContext context) {
    context.read<DetailVisitorBloc>().add(LoadDetailVisitor(slug));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Recent Visitor'),
        centerTitle: true,
      ),
      body: BlocBuilder<DetailVisitorBloc, DetailVisitorState>(
        builder: (context, state) {
          if (state is DetailVisitorLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is DetailVisitorError) {
            return Center(child: Text(state.error));
          }

          if (state is DetailVisitorLoaded) {
            final data = state.data;
            if (data == null) {
              return const Center(child: Text('data tidak ditemukan'));
            }
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
                      data['user']['fullName'] ?? '',
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
                      data['employee']['fullName'] ?? '',
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
                      data['description'] ?? '',
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
                    Text(data['formattedDate'] ?? '', style: TextStyle(fontSize: 16)),
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
