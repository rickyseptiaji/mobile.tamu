import 'package:buku_tamu/src/features/guest/presentation/bloc/guest_bloc.dart';
import 'package:buku_tamu/src/features/guest/presentation/bloc/guest_event.dart';
import 'package:buku_tamu/src/features/guest/presentation/bloc/guest_state.dart';
import 'package:buku_tamu/src/features/guest/presentation/pages/guest_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GuestScreen extends StatefulWidget {
  const GuestScreen({super.key});

  @override
  State<GuestScreen> createState() => _GuestScreenState();
}

class _GuestScreenState extends State<GuestScreen> {
  @override
  void initState() {
    super.initState();
    context.read<GuestBloc>().add(LoadEmployeesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<GuestBloc, GuestState>(
        listener: (context, state) {
         if (state is GuestError) {
           ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(content: Text(state.error), backgroundColor: Colors.red,),
           );
         }else if (state is GuestSuccess) {
           ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(content: Text(state.message), backgroundColor: Colors.green,),
           );
            context.read<GuestBloc>().add(LoadEmployeesEvent());
         }
        },
        child: BlocBuilder<GuestBloc, GuestState>(
          builder: (context, state) {
            if (state is EmployeesLoading) {
              return const Center(child: CircularProgressIndicator());
            }else if (state is GuestLoaded) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: GuestForm(employees: state.employees),
              );
            } else if (state is FormSubmitting) {
              return const Center(child: CircularProgressIndicator());
            }
            return const Center(child: Text('Terjadi kesalahan'));
          },
        ),
      ),
    );
  }
}
