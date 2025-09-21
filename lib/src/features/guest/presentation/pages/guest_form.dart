import 'package:buku_tamu/src/features/guest/presentation/bloc/guest_bloc.dart';
import 'package:buku_tamu/src/features/guest/presentation/bloc/guest_event.dart';
import 'package:buku_tamu/src/features/guest/presentation/bloc/guest_state.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GuestForm extends StatefulWidget {
  const GuestForm({super.key});

  @override
  State<GuestForm> createState() => _GuestFormState();
}

class _GuestFormState extends State<GuestForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? selectedEmployeeId;
  String _countryCode = '+62';

  @override
  Widget build(BuildContext context) {
    return BlocListener<GuestBloc, GuestState>(
      listener: (context, state) {
        if (state is GuestError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        } else if (state is GuestSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Tamu berhasil ditambahkan'),
              backgroundColor: Colors.green,
            ),
          );
        }
      },
      child: BlocBuilder<GuestBloc, GuestState>(
        builder: (context, state) {
          if (state is GuestLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GuestLoaded) {
            return Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Isi Form Tamu',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  companyName(state),
                  const SizedBox(height: 16),
                  fullName(state),
                  const SizedBox(height: 16),
                  email(state),
                  const SizedBox(height: 16),
                  phone(state),
                  const SizedBox(height: 16),
                  toEmployee(state),
                  const SizedBox(height: 16),
                  description(state),
                  const SizedBox(height: 24),
                  submitButton(state),
                ],
              ),
            );
          }
          return Center(child: const Text('Something went wrong'));
        },
      ),
    );
  }

  DropdownMenu<String> toEmployee(state) {
    return DropdownMenu<String>(
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Color(0xFFEDF5F4).withValues(alpha: 0.8),
        border: OutlineInputBorder(),
      ),
      width: MediaQuery.of(context).size.width,
      enableFilter: true,
      requestFocusOnTap: true,
      leadingIcon: const Icon(Icons.search),
      label: const Text('Kepada'),
      hintText: 'Pilih pegawai',
      initialSelection: state.employees.isNotEmpty
          ? state.employees[0]['id']
          : null,
      dropdownMenuEntries: state.employees
          .map<DropdownMenuEntry<String>>(
            (employee) => DropdownMenuEntry<String>(
              value: employee['id'],
              label: employee['fullName'],
            ),
          )
          .toList(),
      onSelected: (value) {
        setState(() {
          selectedEmployeeId = value;
        });
      },
    );
  }

  ElevatedButton submitButton(state) {
    return ElevatedButton.icon(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          context.read<GuestBloc>().add(
            SubmitGuestEvent(
              companyName: _companyController.text,
              fullName: _fullNameController.text,
              email: _emailController.text,
              countryCode: _countryCode,
              phone: '$_countryCode${_phoneController.text}',
              toEmployee: selectedEmployeeId ?? '',
              description: _descriptionController.text,
            ),
          );
        }
      },
      icon: const Icon(Icons.send),
      label: state is GuestLoading
          ? const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            )
          : const Text('Kirim'),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  TextFormField description(state) {
    return TextFormField(
      controller: _descriptionController,
      maxLines: 5,
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xFFEDF5F4).withValues(alpha: 0.8),
        labelText: 'Keterangan',
        border: OutlineInputBorder(),
      ),
      validator: (value) => value!.isEmpty ? 'Nomor telepon wajib diisi' : null,
    );
  }

  Row phone(state) {
    return Row(
      children: [
        Flexible(
          flex: 1,
          child: FormField<String>(
            validator: (value) {
              if (_countryCode.isEmpty) {
                return 'Kode negara wajib diisi';
              }
              return null;
            },
            builder: (field) {
              return InputDecorator(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFEDF5F4).withValues(alpha: 0.8),
                  labelText: 'Kode Negara',
                  border: const OutlineInputBorder(),
                  errorText: field.errorText,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                ),
                child: SizedBox(
                  height: 44,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: CountryCodePicker(
                      onChanged: (country) {
                        setState(() {
                          _countryCode = country.dialCode ?? '';
                        });
                        field.didChange(_countryCode);
                      },
                      initialSelection: _countryCode,
                      favorite: ['+62', 'ID'],
                      showCountryOnly: false,
                      showOnlyCountryWhenClosed: false,
                      alignLeft: false,
                      padding: EdgeInsets.zero,
                      textStyle: const TextStyle(fontSize: 14),
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        const SizedBox(width: 16),
        Flexible(
          flex: 2,
          child: TextFormField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              filled: true,
              fillColor: Color(0xFFEDF5F4).withValues(alpha: 0.8),
              labelText: 'No Telp',
              border: OutlineInputBorder(),
            ),
            validator: (value) =>
                value!.isEmpty ? 'Nomor telepon wajib diisi' : null,
          ),
        ),
      ],
    );
  }

  TextFormField email(state) {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xFFEDF5F4).withValues(alpha: 0.8),
        labelText: 'Email',
        border: OutlineInputBorder(),
      ),
      validator: (value) => value!.contains('@') ? null : 'Email tidak valid',
    );
  }

  TextFormField fullName(state) {
    return TextFormField(
      controller: _fullNameController,
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xFFEDF5F4).withValues(alpha: 0.8),
        labelText: 'Nama Lengkap',
        border: OutlineInputBorder(),
      ),
      validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
    );
  }

  TextFormField companyName(state) {
    return TextFormField(
      controller: _companyController,
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xFFEDF5F4),
        labelText: 'Asal Perusahaan',
        border: OutlineInputBorder(),
      ),
      validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
    );
  }
}
