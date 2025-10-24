import 'package:buku_tamu/src/features/form_visitor/presentation/bloc/form_bloc.dart';
import 'package:buku_tamu/src/features/form_visitor/presentation/bloc/form_event.dart';
import 'package:buku_tamu/src/features/guest/presentation/bloc/guest_bloc.dart';
import 'package:buku_tamu/src/features/guest/presentation/bloc/guest_event.dart';
import 'package:buku_tamu/src/features/guest/presentation/bloc/guest_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class FormGuest extends StatefulWidget {
  const FormGuest({super.key});

  @override
  State<FormGuest> createState() => _FormGuestState();
}

class _FormGuestState extends State<FormGuest> {
  String? selectedEmployeeId;
  final TextEditingController descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    context.read<GuestBloc>().add(LoadEmployeesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Form Guest'), centerTitle: true),
      body: BlocBuilder<GuestBloc, GuestState>(
        builder: (context, state) {
          if (state is EmployeesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GuestLoaded) {
            final employees = state.employees;
            if (employees.isNotEmpty) {
              selectedEmployeeId = employees.first['id'].toString();
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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'Form Guest',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Add your form fields here
                        DropdownMenu<String>(
                          inputDecorationTheme: InputDecorationTheme(
                            filled: true,
                            fillColor: const Color(
                              0xFFEDF5F4,
                            ).withValues(alpha: 0.5),
                            border: const OutlineInputBorder(),
                          ),
                          width: MediaQuery.of(context).size.width,
                          enableFilter: true,
                          requestFocusOnTap: true,
                          leadingIcon: const Icon(Icons.search),
                          label: const Text('Kepada'),
                          hintText: 'Pilih pegawai',
                          initialSelection: selectedEmployeeId,
                          dropdownMenuEntries: employees
                              .map<DropdownMenuEntry<String>>(
                                (employee) => DropdownMenuEntry<String>(
                                  value: employee['id'].toString(),
                                  label: employee['fullName'],
                                ),
                              )
                              .toList(),
                          onSelected: (value) {
                            setState(() {
                              selectedEmployeeId = value;
                            });
                          },
                        ),

                        const SizedBox(height: 16),
                        TextFormField(
                          controller: descriptionController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xFFEDF5F4),
                            labelText: 'Description',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<FormVisitorBloc>().add(
                                SubmitVisitorEvent(
                                  employeeId: selectedEmployeeId!,
                                  description: descriptionController.text,
                                ),
                              );
                              context.pop();
                            }
                          },
                          child: const Text('Submit'),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          }
          return const Center(child: Text('Terjadi kesalahan'));
        },
      ),
    );
  }
}
