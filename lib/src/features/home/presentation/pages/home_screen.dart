import 'package:buku_tamu/src/core/helper/slug.dart';
import 'package:buku_tamu/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:buku_tamu/src/features/home/presentation/bloc/home_event.dart';
import 'package:buku_tamu/src/features/home/presentation/bloc/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(LoadGuestsEventUser());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // SECTION 1
          Container(
            height: 200,
            padding: const EdgeInsets.all(24),
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0x804C7380),
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(80),
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome to Buku Tamu',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Your guestbook app for managing visitors.',
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
              ],
            ),
          ),

          // SECTION 2
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(24),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(80)),
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Form',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: () {
                        context.push('/home/formguest');
                      },
                      child: const Text(
                        'Open Form',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Text(
                        'History',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          context.push('/home/all-guests');
                        },
                        child: const Text(
                          'View All',
                          style: TextStyle(color: Color(0xFF4C7380)),
                        ),
                      ),
                    ],
                  ),

                  // BlocBuilder untuk menampilkan data tamu
                  Expanded(
                    child: BlocBuilder<HomeBloc, HomeState>(
                      builder: (context, state) {
                        if (state is HomeLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is HomeLoaded) {
                          final guests = state.guest;
                          if (guests.isEmpty) {
                            return const Center(
                              child: Text('No visitors yet.'),
                            );
                          }
                          return ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: guests.length,
                            itemBuilder: (context, index) {
                              final guest = guests[index];
                              return Card(
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                child: ListTile(
                                  leading: const CircleAvatar(
                                    backgroundColor: Colors.blue,
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.white,
                                    ),
                                  ),
                                  title: Text(
                                    guest['users']?['fullName'] ?? 'No Name',
                                  ),
                                  subtitle: Text(
                                    'Visited on ${guest['createdAtString'] ?? 'Unknown'}',
                                  ),
                                  trailing: const Icon(Icons.arrow_forward_ios),
                                  onTap: () {
                                    final id = guest['id'];

                                    final slug = generateSlug(id);
                                    context.push(
                                      '/home/detail-recent-visitor/$slug',
                                    );
                                  },
                                ),
                              );
                            },
                          );
                        } else if (state is HomeError) {
                          return Center(child: Text('Error: ${state.error}'));
                        }
                        return const Center(child: Text('Loading visitors...'));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
