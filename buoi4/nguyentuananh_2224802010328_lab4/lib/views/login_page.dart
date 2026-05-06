import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/auth_services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
              Text("Login", style: GoogleFonts.sora(fontSize: 40, fontWeight: FontWeight.w700)),
              const SizedBox(height: 10),
              // Email Field
              SizedBox(
                width: MediaQuery.of(context).size.width * .9,
                child: TextFormField(
                  validator: (value) => value!.isEmpty ? "Email cannot be empty." : null,
                  controller: _emailController,
                  decoration: const InputDecoration(border: OutlineInputBorder(), labelText: "Email"),
                ),
              ),
              const SizedBox(height: 10),
              // Password Field
              SizedBox(
                width: MediaQuery.of(context).size.width * .9,
                child: TextFormField(
                  validator: (value) => value!.length < 8 ? "Password should have atleast 8 characters." : null,
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(border: OutlineInputBorder(), labelText: "Password"),
                ),
              ),
              const SizedBox(height: 30),
              // Login Button
              SizedBox(
                width: MediaQuery.of(context).size.width * .9,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      AuthService().loginWithEmail(_emailController.text, _passwordController.text).then((value) {
                        if (value == "Login Successful") {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Login Successful")));
                          Navigator.pushReplacementNamed(context, "/home");
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value), backgroundColor: Colors.red.shade400));
                        }
                      });
                    }
                  },
                  child: const Text("Login", style: TextStyle(fontSize: 16)),
                ),
              ),
              const SizedBox(height: 10),
              // Google Sign In
              SizedBox(
                width: MediaQuery.of(context).size.width * .9,
                height: 60,
                child: OutlinedButton(
                  onPressed: () {
                    AuthService().continueWithGoogle().then((value) {
                      if (value == "Google Login Successful") {
                        Navigator.pushReplacementNamed(context, "/home");
                      }
                    });
                  },
                  child: const Text("Continue with Google", style: TextStyle(fontSize: 16)),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have and account? "),
                  TextButton(onPressed: () => Navigator.pushNamed(context, "/signup"), child: const Text("Sign Up"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}