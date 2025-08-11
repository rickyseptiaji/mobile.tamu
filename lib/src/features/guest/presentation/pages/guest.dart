import 'package:buku_tamu/src/features/guest/presentation/bloc/guest_bloc.dart';
import 'package:buku_tamu/src/features/guest/presentation/bloc/guest_event.dart';
import 'package:buku_tamu/src/features/guest/presentation/bloc/guest_state.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GuestScreen extends StatefulWidget {
  const GuestScreen({super.key});

  @override
  State<GuestScreen> createState() => _GuestScreenState();
}

class _GuestScreenState extends State<GuestScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String countryCode = '+62';
  String? selectedTo;
  final List<String> toList = ['Budi Santoso', 'Siti Aminah'];
  Key countryPickerKey = UniqueKey();

  void resetForm() {
    setState(() {
      companyController.clear();
      nameController.clear();
      emailController.clear();
      phoneController.clear();
      descriptionController.clear();

      selectedTo = null;
      countryCode = '+62';
      countryPickerKey = UniqueKey();

      formKey.currentState?.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<GuestBloc, GuestState>(
        listener: (context, state) {
          if (state is GuestSuccessState) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Data berhasil dikirim')),
              );
              resetForm();
            });
          } else if (state is GuestFailureState) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.error)));
            });
          }
        },

        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Isi Form Tamu',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),

                  TextFormField(
                    controller: companyController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFEDF5F4),
                      labelText: 'Asal Perusahaan',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
                  ),
                  const SizedBox(height: 16),

                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFEDF5F4).withValues(alpha: 0.8),
                      labelText: 'Nama Lengkap',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
                  ),
                  const SizedBox(height: 16),

                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFEDF5F4).withValues(alpha: 0.8),
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                        value!.contains('@') ? null : 'Email tidak valid',
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: TextFormField(
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: 'Kode Negara',
                            filled: true,
                            fillColor: const Color(
                              0xFFEDF5F4,
                            ).withValues(alpha: 0.8),
                            border: const OutlineInputBorder(),
                            suffixIcon: CountryCodePicker(
                              key: countryPickerKey,
                              onChanged: (e) {
                                setState(() {
                                  countryCode = e.dialCode ?? '+62';
                                });
                              },
                              initialSelection: countryCode,
                              favorite: ['+62', 'ID'],
                              showCountryOnly: false,
                              showOnlyCountryWhenClosed: false,
                              alignLeft: false,
                              padding: EdgeInsets.zero,
                              textStyle: const TextStyle(fontSize: 14),
                            ),
                          ),
                          validator: (value) =>
                              phoneController.text.isEmpty ? '' : null,
                        ),
                      ),

                      const SizedBox(width: 16),
                      Flexible(
                        flex: 2,
                        child: TextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xFFEDF5F4).withValues(alpha: 0.8),
                            labelText: 'No Telp',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) => value!.isEmpty
                              ? 'Nomor telepon wajib diisi'
                              : null,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFEDF5F4).withValues(alpha: 0.8),
                      labelText: 'Kepada',
                      border: OutlineInputBorder(),
                    ),
                    items: toList
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (value) => setState(() => selectedTo = value),
                    value: selectedTo,
                    validator: (value) =>
                        value == null ? 'Pilih salah satu tujuan' : null,
                  ),
                  const SizedBox(height: 16),

                  TextFormField(
                    controller: descriptionController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFEDF5F4).withValues(alpha: 0.8),
                      labelText: 'Keterangan',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                        value!.isEmpty ? 'Nomor telepon wajib diisi' : null,
                  ),
                  const SizedBox(height: 24),

                  ElevatedButton.icon(
                    onPressed: state is GuestLoadingState
                        ? null
                        : () {
                            if (formKey.currentState!.validate()) {
                              context.read<GuestBloc>().add(
                                GuestSubmitEvent(
                                  company: companyController.text,
                                  name: nameController.text,
                                  email: emailController.text,
                                  countryCode: countryCode,
                                  phone: phoneController.text,
                                  to: selectedTo!,
                                  description: descriptionController.text,
                                ),
                              );
                            }
                          },
                    icon: const Icon(Icons.send),
                    label: state is GuestLoadingState
                        ? SizedBox(
                            height: 20,
                            width: 20,
                            child: const CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : const Text('Kirim'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
