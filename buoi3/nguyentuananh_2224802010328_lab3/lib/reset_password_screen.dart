import 'package:flutter/material.dart';
import 'api_service.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final api = ApiService();
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleReset() async {
    if (_formKey.currentState!.validate()) {
      setState(() => isLoading = true);

      String result = await api.resetPassword(
        emailController.text,
        newPasswordController.text,
      );

      setState(() => isLoading = false);

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(result == "Success" ? "Thành công" : "Thông báo"),
          content: Text(result == "Success" ? "Mật khẩu đã được cập nhật thành công!" : result),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                if (result == "Success") Navigator.pop(context);
              },
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Reset Password")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 30),
              Image.network(
                "https://cdn-icons-png.flaticon.com/512/3064/3064155.png",
                width: 100, height: 100,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "Email", border: OutlineInputBorder()),
                validator: (value) => (value == null || value.isEmpty) ? "Nhập email của bạn" : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: newPasswordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: "New Password", border: OutlineInputBorder()),
                validator: (value) => (value != null && value.length < 7) ? "Tối thiểu 7 ký tự" : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: "Confirm New Password", border: OutlineInputBorder()),
                validator: (value) => (value != newPasswordController.text) ? "Mật khẩu không khớp" : null,
              ),
              const SizedBox(height: 20),
              isLoading 
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    onPressed: _handleReset,
                    child: const Text("Reset Password"),
                  ),
              const SizedBox(height: 10),
              OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Back"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}