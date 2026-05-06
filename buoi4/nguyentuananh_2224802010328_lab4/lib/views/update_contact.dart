import 'package:flutter/material.dart';
import '../controllers/crud_services.dart';

class UpdateContactPage extends StatefulWidget {
  final String docID, name, phone, email;
  const UpdateContactPage({super.key, required this.docID, required this.name, required this.phone, required this.email});

  @override
  State<UpdateContactPage> createState() => _UpdateContactPageState();
}

class _UpdateContactPageState extends State<UpdateContactPage> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;

  @override
  void initState() {
    _nameController = TextEditingController(text: widget.name);
    _phoneController = TextEditingController(text: widget.phone);
    _emailController = TextEditingController(text: widget.email);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Update Contact")),
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
                CRUDService().updateContact(_nameController.text, _phoneController.text, _emailController.text, widget.docID);
                Navigator.pop(context);
              },
              child: const Text("Update")
            ),
            TextButton(
              onPressed: () {
                CRUDService().deleteContact(widget.docID);
                Navigator.pop(context);
              }, 
              child: const Text("Delete", style: TextStyle(color: Colors.red))
            )
          ],
        ),
      ),
    );
  }
}