import 'package:buku_tamu/injection_container.dart';
import 'package:buku_tamu/src/features/employee/domain/repository/employee_repository.dart';
import 'package:buku_tamu/src/features/employee/presentation/bloc/employee_bloc.dart';
import 'package:buku_tamu/src/features/guest/domain/repositories/guest_repository.dart';
import 'package:buku_tamu/src/features/guest/presentation/bloc/guest_bloc.dart';
import 'package:buku_tamu/src/features/guest/presentation/pages/guest_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GuestScope extends StatelessWidget {
  const GuestScope({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<GuestRepository>(
          create: (_) => sl<GuestRepository>(),
        ),
        RepositoryProvider<EmployeeRepository>(
          create: (_) => sl<EmployeeRepository>(),
        ),
      ],
      child: GuestBlocScope(),
    );
  }
}

class GuestBlocScope extends StatelessWidget {
  const GuestBlocScope({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => EmployeeCubit(
            context.read<EmployeeRepository>(),
          )..fetchEmployees(),
        ),
        BlocProvider(
          create: (_) => GuestBloc(
            context.read<GuestRepository>(),
          ),
        ),
      ],
      child: const GuestScreen(),
    );
  }
}
