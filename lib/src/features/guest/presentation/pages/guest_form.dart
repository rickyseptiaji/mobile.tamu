import 'package:buku_tamu/src/features/guest/presentation/bloc/guest_bloc.dart';
import 'package:buku_tamu/src/features/guest/presentation/bloc/guest_event.dart';
import 'package:buku_tamu/src/features/guest/presentation/bloc/guest_state.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GuestForm extends StatefulWidget {
  final List<Map<String, dynamic>> employees;
  const GuestForm({super.key, required this.employees});

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
void initState() {
  super.initState();
  if (widget.employees.isNotEmpty) {
    selectedEmployeeId = widget.employees.first['id'].toString();
  } else {
    selectedEmployeeId = null;
  }
}

  @override
  Widget build(BuildContext context) {
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
          companyName(),
          const SizedBox(height: 16),
          fullName(),
          const SizedBox(height: 16),
          email(),
          const SizedBox(height: 16),
          phone(),
          const SizedBox(height: 16),
          toEmployee(widget),
          const SizedBox(height: 16),
          description(),
          const SizedBox(height: 24),
          submitButton(),
        ],
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

  Widget submitButton() {
    return BlocBuilder<GuestBloc, GuestState>(
      builder: (context, state) {
        final isLoading = state is FormSubmitting;

        return ElevatedButton.icon(
          onPressed: isLoading
              ? null
              : () {
                  if (_formKey.currentState!.validate()) {
                    context.read<GuestBloc>().add(
                      SubmitGuestEvent(
                        {
                          'company': _companyController.text,
                          'fullName': _fullNameController.text,
                          'email': _emailController.text,
                          'phone': '$_countryCode${_phoneController.text}',
                          'description': _descriptionController.text,
                          'toEmployeeId': selectedEmployeeId,
                          'timestamp': DateTime.now(),
                        },
                      ),
                    );
                  }
                },
          icon: const Icon(Icons.send),
          label: isLoading
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
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
        );
      },
    );
  }

  TextFormField description() {
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

  Row phone() {
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

  TextFormField email() {
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

  TextFormField fullName() {
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

  TextFormField companyName() {
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
