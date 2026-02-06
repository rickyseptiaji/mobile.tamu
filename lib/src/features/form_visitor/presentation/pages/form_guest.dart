import 'package:buku_tamu/src/features/employee/presentation/bloc/employee_bloc.dart';
import 'package:buku_tamu/src/features/employee/presentation/bloc/employee_state.dart';
import 'package:buku_tamu/src/features/form_visitor/presentation/bloc/form_bloc.dart';
import 'package:buku_tamu/src/features/form_visitor/presentation/bloc/form_event.dart';
import 'package:buku_tamu/src/features/form_visitor/presentation/bloc/form_state.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Form Guest')),
      body: BlocListener<FormVisitorBloc, FormVisitorState>(
        listener: (context, state) {
          if (state.status == FormVisitorStatus.success) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message ?? 'Success')));
            context.pop(true);
          } else if (state.status == FormVisitorStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error ?? 'Error occurred')),
            );
          }
        },
        child: SingleChildScrollView(
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
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocBuilder<EmployeeCubit, EmployeeState>(
                      builder: (context, state) {
                        if (state.status == EnumEmployeeState.loading) {
                          return Center(
                            child: const CircularProgressIndicator(),
                          );
                        }

                        if (state.status == EnumEmployeeState.error) {
                          return Text(
                            state.error ?? 'Gagal memuat employee',
                            style: const TextStyle(color: Colors.red),
                          );
                        }

                        return DropdownMenu<String>(
                          width: double.infinity,
                          enableFilter: true,
                          requestFocusOnTap: true,
                          inputDecorationTheme: InputDecorationTheme(
                            filled: true,
                            fillColor: const Color(
                              0xFFEDF5F4,
                            ).withValues(alpha: 0.5),
                            border: const OutlineInputBorder(),
                          ),
                          leadingIcon: const Icon(Icons.search),
                          label: const Text('Kepada'),
                          hintText: 'Pilih pegawai',
                          initialSelection: selectedEmployeeId,
                          dropdownMenuEntries: state.employees.map((employee) {
                            return DropdownMenuEntry(
                              value: employee.id.toString(),
                              label: employee.fullName,
                            );
                          }).toList(),
                          onSelected: (value) {
                            setState(() => selectedEmployeeId = value);
                          },
                        );
                      },
                    ),

                    const SizedBox(height: 16),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Deskripsi Tidak Boleh Kosong";
                        }
                        return null;
                      },
                      controller: descriptionController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFEDF5F4),
                        labelText: 'Description',
                        border: OutlineInputBorder(),
                      ),
                    ),

                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (!_formKey.currentState!.validate()) return;

                          if (selectedEmployeeId == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Silakan pilih pegawai'),
                              ),
                            );
                            return;
                          }

                          context.read<FormVisitorBloc>().add(
                            SubmitVisitorEvent(
                              employeeId: selectedEmployeeId!,
                              description: descriptionController.text,
                            ),
                          );
                        },
                        child: const Text('Submit'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
