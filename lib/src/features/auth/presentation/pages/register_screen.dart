import 'package:buku_tamu/src/features/auth/presentation/bloc/register_bloc.dart';
import 'package:buku_tamu/src/features/auth/presentation/bloc/register_state.dart';
import 'package:buku_tamu/src/features/auth/presentation/pages/register_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Registration Successful')),
            );
            Navigator.of(context).pop();
          } else if (state is RegisterFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Registration Failed: ${state.error}')),
            );
          }
        },
        builder: (context, state) {
          return BlocBuilder<RegisterBloc, RegisterState>(
            builder: (context, state) {
              if (state is RegisterLoading) {
                return const Center(child: CircularProgressIndicator(),);
              }
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: RegisterForm(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
