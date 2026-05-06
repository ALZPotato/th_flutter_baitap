import 'package:flutter/material.dart';
import '../controllers/crud_services.dart';

class AddContactPage extends StatefulWidget {
  const AddContactPage({super.key});
  @override
  State<AddContactPage> createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Contact")),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextFormField(controller: _nameController, decoration: const InputDecoration(labelText: "Name")),
            TextFormField(controller: _phoneController, decoration: const InputDecoration(labelText: "Phone")),
            TextFormField(controller: _emailController, decoration: const InputDecoration(labelText: "Email")),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                CRUDService().addNewContacts(_nameController.text, _phoneController.text, _emailController.text);
                Navigator.pop(context);
              },
              child: const Text("Create")
            )
          ],
        ),
      ),
    );
  }
}