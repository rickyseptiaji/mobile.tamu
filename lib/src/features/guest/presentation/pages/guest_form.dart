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
    return MultiBlocListener(
      listeners: [
        BlocListener<GuestBloc, GuestState>(
          listenWhen: (previous, current) =>
              previous.error != current.error && current.error != null,
          listener: (context, state) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error ?? 'Terjadi kesalahan'),
                backgroundColor: Colors.red,
              ),
            );
          },
        ),
        BlocListener<GuestBloc, GuestState>(
          listenWhen: (previous, current) =>
              previous.success != current.success && current.success,
          listener: (context, state) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Data tamu berhasil dikirim'),
                backgroundColor: Colors.green,
              ),
            );
          },
        ),
      ],
      child: BlocBuilder<GuestBloc, GuestState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Isi Form Tamu',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              companyName(context, state),
              const SizedBox(height: 16),

              fullName(context, state),
              const SizedBox(height: 16),

              email(context, state),
              const SizedBox(height: 16),
              phone(context, state),

              const SizedBox(height: 16),
              toEmployee(context, state),
              const SizedBox(height: 16),

              description(context, state),
              const SizedBox(height: 24),

              submitButton(context, state),
            ],
          );
        },
      ),
    );
  }

  DropdownMenu<String> toEmployee(BuildContext context, GuestState state) {
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
      initialSelection: state.toEmployee.isEmpty ? null : state.toEmployee,
      label: const Text('Kepada'),
      hintText: 'Pilih pegawai',
      dropdownMenuEntries: state.employees
          .map(
            (e) => DropdownMenuEntry<String>(
              value: e['id'] as String,
              label: e['fullName'] as String,
            ),
          )
          .toList(),
      onSelected: (value) {
        BlocProvider.of<GuestBloc>(
          context,
        ).add(GuestToEmployeeChanged(value ?? ''));
      },
    );
  }

  ElevatedButton submitButton(context, GuestState state) {
    return ElevatedButton.icon(
      onPressed: () {
        if (!state.isLoading) {
          BlocProvider.of<GuestBloc>(context).add(GuestSubmitEvent());
        }
      },
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

  TextFormField description(BuildContext context, GuestState state) {
    return TextFormField(
      onChanged: (value) {
        context.read<GuestBloc>().add(GuestDescriptionChanged(value));
      },
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

  Row phone(BuildContext context, GuestState state) {
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
            onChanged: (value) {
              context.read<GuestBloc>().add(
                GuestPhoneChanged(state.countryCode, value),
              );
            },
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

  TextFormField email(BuildContext context, GuestState state) {
    return TextFormField(
      onChanged: (value) {
        context.read<GuestBloc>().add(GuestEmailChanged(value));
      },
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

  TextFormField fullName(BuildContext context, GuestState state) {
    return TextFormField(
      onChanged: (value) {
        context.read<GuestBloc>().add(GuestFullNameChanged(value));
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xFFEDF5F4).withValues(alpha: 0.8),
        labelText: 'Nama Lengkap',
        border: OutlineInputBorder(),
      ),
      validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
    );
  }

  TextFormField companyName(BuildContext context, GuestState state) {
    return TextFormField(
      onChanged: (value) {
        context.read<GuestBloc>().add(GuestCompanyChanged(value));
      },
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
