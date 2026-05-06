import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/auth_services.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(height: 90),
              Text("Sign Up", style: GoogleFonts.sora(fontSize: 40, fontWeight: FontWeight.w700)),
              const SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width * .9,
                child: TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(border: OutlineInputBorder(), labelText: "Email"),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width * .9,
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(border: OutlineInputBorder(), labelText: "Password"),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width * .9,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    AuthService().createAccountWithEmail(_emailController.text, _passwordController.text).then((value) {
                      if (value == "Account Created") {
                        Navigator.pushReplacementNamed(context, "/home");
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));
                      }
                    });
                  },
                  child: const Text("Sign Up"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}