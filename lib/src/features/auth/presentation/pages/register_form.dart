import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Column(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blueAccent,
              ),
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
            SizedBox(height: 20),
            Text(
              'Welcome Back',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Please enter your credentials to sign up',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 20),
          ],
        ),
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFEDF5F4).withValues(alpha: 0.8),
            labelText: 'Email',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 24),
        TextFormField(
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFEDF5F4).withValues(alpha: 0.8),
            labelText: 'Nama Lengkap',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 24),
        TextFormField(
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFEDF5F4).withValues(alpha: 0.8),
            labelText: 'Nama Perusahaan',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 24),
        Row(
          children: [
            // Flexible(
            //   flex: 1,
            //   child: TextFormField(
            //     readOnly: true,
            //     decoration: InputDecoration(
            //       labelText: 'Kode Negara',
            //       filled: true,
            //       fillColor: const Color(
            //         0xFFEDF5F4,
            //       ).withValues(alpha: 0.8),
            //       border: const OutlineInputBorder(),
            //       suffixIcon: CountryCodePicker(
            //         key: countryPickerKey,
            //         onChanged: (e) {
            //           setState(() {
            //             countryCode = e.dialCode ?? '+62';
            //           });
            //         },
            //         initialSelection: countryCode,
            //         favorite: ['+62', 'ID'],
            //         showCountryOnly: false,
            //         showOnlyCountryWhenClosed: false,
            //         alignLeft: false,
            //         padding: EdgeInsets.zero,
            //         textStyle: const TextStyle(fontSize: 14),
            //       ),
            //     ), 
            //     validator: (value) =>
            //         phoneController.text.isEmpty ? '' : null,
            //   ),
            // ),
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
        ),
        SizedBox(height: 24),
        TextFormField(
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFEDF5F4).withValues(alpha: 0.8),
            labelText: 'Password',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 24),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () {},
          child: Text('Register'),
        ),
        SizedBox(height: 10),
        RichText(
          text: TextSpan(
            text: 'Don\'t have an account? ',
            style: TextStyle(color: Colors.black),
            children: [
              TextSpan(
                text: 'Sign In',
                style: TextStyle(color: Colors.blue),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    // context.push('/login');
                  },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
