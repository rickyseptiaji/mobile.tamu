import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SectionForm extends StatelessWidget {
  const SectionForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: const Text(
            'Form',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 8),

        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            onPressed: () {
              context.push('/home/form-guest');
            },

            child: const Text('Open Form', style: TextStyle(fontSize: 16)),
          ),
        ),
      ],
    );
  }
}
