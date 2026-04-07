import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Screen4 extends StatelessWidget {
  const Screen4({super.key});

  @override
  Widget build(BuildContext context) {
    return const RegisterPage();
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  void _showRegisterSuccessDialog() {
    final fullName =
        '${firstNameController.text.trim()} ${lastNameController.text.trim()}'
            .trim();

    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Registration Successful'),
        content: Text(
          fullName.isEmpty
              ? 'Your account has been created successfully.'
              : 'Welcome, $fullName',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Form Application')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Image.asset(
              'assets/images/avatar.jpg',
              height: 100,
              width: 100,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: firstNameController,
              label: 'First Name',
            ),
            CustomTextField(
              controller: lastNameController,
              label: 'Last Name',
            ),
            const CustomTextField(
              label: 'Email',
              suffixText: '@example.com',
            ),
            const CustomTextField(
              label: 'Phone Number',
              prefixText: '+84 ',
              keyboardType: TextInputType.phone,
              maxLength: 10,
            ),
            const Divider(indent: 8, endIndent: 8),
            const CustomTextField(label: 'Username'),
            const CustomTextField(label: 'Password', obscureText: true),
            const CustomTextField(
              label: 'Confirm Password',
              obscureText: true,
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _showRegisterSuccessDialog,
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final String? prefixText;
  final String? suffixText;
  final TextInputType? keyboardType;
  final int? maxLength;
  final bool obscureText;

  const CustomTextField({
    super.key,
    required this.label,
    this.controller,
    this.prefixText,
    this.suffixText,
    this.keyboardType,
    this.maxLength,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        maxLength: maxLength,
        inputFormatters: keyboardType == TextInputType.phone
            ? [FilteringTextInputFormatter.digitsOnly]
            : null,
        decoration: InputDecoration(
          labelText: label,
          prefixText: prefixText,
          suffixText: suffixText,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
