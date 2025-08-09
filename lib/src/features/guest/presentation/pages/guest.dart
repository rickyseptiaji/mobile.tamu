import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';

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

  String? selectedTo;
  final List<String> toList = [
    'HRD',
    'Finance',  
    'IT',
    'Marketing',
    'Sales',
    'Logistics',
  ];


  void submit() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
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
                  labelText: 'Company',
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
                  labelText: 'Name',
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
                    child: SizedBox(
                      height: 55,
                      child: InputDecorator(
                        decoration: InputDecoration(
                          labelText: 'Kode Negara',
                          filled: true,
                          isDense: true,
                          fillColor: const Color(
                            0xFFEDF5F4,
                          ).withValues(alpha: 0.8),
                          border: const OutlineInputBorder(),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: CountryCodePicker(
                            onChanged: (e) {
                              setState(() {});
                            },
                            initialSelection: '+62',
                            favorite: ['+62', 'ID'],
                            showCountryOnly: false,
                            showOnlyCountryWhenClosed: false,
                            alignLeft: false,
                            padding: EdgeInsets.zero,
                            textStyle: const TextStyle(fontSize: 14),
                          ),
                        ),
                      ),
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
                      validator: (value) =>
                          value!.isEmpty ? 'Nomor telepon wajib diisi' : null,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFEDF5F4).withValues(alpha: 0.8),
                  labelText: 'To',
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
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Nomor telepon wajib diisi' : null,
              ),
              const SizedBox(height: 24),

              ElevatedButton.icon(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    submit();
                  }
                },
                icon: const Icon(Icons.send),
                label: const Text('Submit'),
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
      ),
    );
  }
}
