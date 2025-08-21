import 'package:buku_tamu/src/features/guest/presentation/bloc/guest_bloc.dart';
import 'package:buku_tamu/src/features/guest/presentation/bloc/guest_event.dart';
import 'package:buku_tamu/src/features/guest/presentation/bloc/guest_state.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GuestForm extends StatelessWidget {
  const GuestForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GuestBloc, GuestState>(
      listener: (context, state) {
        if (state.success) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Data berhasil dikirim')),
            );
          });
        } else if (state.error != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error ?? 'Terjadi kesalahan')),
            );
          });
        }
      },
      builder: (context, state) {
        return Column(
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
            phone(context, state),

            const SizedBox(height: 16),
            toEmployee(context, state),
            const SizedBox(height: 16),

            description(state),
            const SizedBox(height: 24),

            submitButton(state),
          ],
        );
      },
    );
  }

  ElevatedButton submitButton(GuestState state) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.send),
      label: state.isLoading
          ? SizedBox(
              height: 20,
              width: 20,
              child: const CircularProgressIndicator(color: Colors.white),
            )
          : const Text('Kirim'),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  TextFormField description(GuestState state) {
    return TextFormField(
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

  DropdownButtonFormField<String> toEmployee(context, GuestState state) {
    return DropdownButtonFormField<String>(
      value: state.toEmployee.isEmpty ? null : state.toEmployee,
      items: state.employees
          .map(
            (employee) =>
                DropdownMenuItem(value: employee, child: Text(employee)),
          )
          .toList(),
      onChanged: (v) =>
          context.read<GuestBloc>().add(GuestToEmployeeChanged(v ?? '')),
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xFFEDF5F4).withValues(alpha: 0.8),
        labelText: 'Kepada',
        border: OutlineInputBorder(),
      ),
      validator: (value) => value == null ? 'Pilih salah satu tujuan' : null,
    );
  }

  Row phone(context, GuestState state) {
    return Row(
      children: [
        Flexible(
          flex: 1,
          child: TextFormField(
            readOnly: true,
            decoration: InputDecoration(
              labelText: 'Kode Negara',
              filled: true,
              fillColor: const Color(0xFFEDF5F4).withValues(alpha: 0.8),
              border: const OutlineInputBorder(),
              suffixIcon: CountryCodePicker(
                onChanged: (c) => context.read<GuestBloc>().add(
                  GuestPhoneChanged(c.dialCode ?? '+62', state.phone),
                ),
                initialSelection: state.countryCode,
                favorite: ['+62', 'ID'],
                showCountryOnly: false,
                showOnlyCountryWhenClosed: false,
                alignLeft: false,
                padding: EdgeInsets.zero,
                textStyle: const TextStyle(fontSize: 14),
              ),
            ),
            validator: (value) =>
                value!.isEmpty ? 'Kode negara wajib diisi' : null,
          ),
        ),

        const SizedBox(width: 16),
        Flexible(
          flex: 2,
          child: TextFormField(
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

  TextFormField email(GuestState state) {
    return TextFormField(
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

  TextFormField fullName(GuestState state) {
    return TextFormField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xFFEDF5F4).withValues(alpha: 0.8),
        labelText: 'Nama Lengkap',
        border: OutlineInputBorder(),
      ),
      validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
    );
  }

  TextFormField companyName(GuestState state) {
    return TextFormField(
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
