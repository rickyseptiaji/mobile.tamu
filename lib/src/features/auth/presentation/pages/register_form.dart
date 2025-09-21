import 'package:buku_tamu/src/features/auth/presentation/bloc/register_bloc.dart';
import 'package:buku_tamu/src/features/auth/presentation/bloc/register_event.dart';
import 'package:buku_tamu/src/features/auth/presentation/bloc/register_state.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String? selectedEmployeeId;
  String _countryCode = '+62';
  bool isPasswordVisible = false;
  void togglePasswordVisibility() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }
  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("Register sukses")));
        }
      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: Column(
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
                email(),
                SizedBox(height: 24),
                fullName(),
                SizedBox(height: 24),
                company(),
                SizedBox(height: 24),
                phone(),
                SizedBox(height: 24),
                password(),
                SizedBox(height: 24),
                submitButton(),
                SizedBox(height: 10),
                navigate(),
              ],
            ),
          );
        },
      ),
    );
  }

  RichText navigate() {
    return RichText(
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
    );
  }

  ElevatedButton submitButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          context.read<RegisterBloc>().add(
                SubmitRegisterEvent(
                  email: _emailController.text,
                  password: _passwordController.text,
                  fullName: _fullNameController.text,
                  companyName: _companyController.text,
                  countryCode: _countryCode,
                  phone: '$_countryCode${_phoneController.text}',
                ),
              );
              context.push('/login');
        }
      },
      child: Text('Register'),
    );
  }

  TextFormField password() {
    return TextFormField(
      obscureText: !isPasswordVisible,
      controller: _passwordController,
      decoration: InputDecoration(
        suffixIcon: IconButton(onPressed: togglePasswordVisibility, icon: Icon(
          isPasswordVisible ? Icons.visibility : Icons.visibility_off,
        )),
        filled: true,
        fillColor: const Color(0xFFEDF5F4).withValues(alpha: 0.8),
        labelText: 'Password',
        border: OutlineInputBorder(),
      ),
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

  TextFormField company() {
    return TextFormField(
      controller: _companyController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFEDF5F4).withValues(alpha: 0.8),
        labelText: 'Nama Perusahaan',
        border: OutlineInputBorder(),
      ),
    );
  }

  TextFormField fullName() {
    return TextFormField(
      controller: _fullNameController,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        
        filled: true,
        fillColor: const Color(0xFFEDF5F4).withValues(alpha: 0.8),
        labelText: 'Nama Lengkap',
        border: OutlineInputBorder(),
      ),
    );
  }

  TextFormField email() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFEDF5F4).withValues(alpha: 0.8),
        labelText: 'Email',
        border: OutlineInputBorder(),
      ),
    );
  }
}
