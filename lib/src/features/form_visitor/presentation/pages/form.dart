import 'package:buku_tamu/injection_container.dart';
import 'package:buku_tamu/src/features/employee/presentation/bloc/employee_bloc.dart';
import 'package:buku_tamu/src/features/form_visitor/presentation/bloc/form_bloc.dart';
import 'package:buku_tamu/src/features/form_visitor/presentation/pages/form_guest.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormPage extends StatelessWidget {
  const FormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FormVisitorBloc>(
          create: (_) => sl<FormVisitorBloc>(),
        ),
        BlocProvider<EmployeeCubit>(
         create: (_) => sl<EmployeeCubit>()..fetchEmployees(),
        ),
      ],
      child: FormGuest(),
    );
  }
}

