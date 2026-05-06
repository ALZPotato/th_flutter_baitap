import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../controllers/auth_services.dart';
import '../controllers/crud_services.dart';
import 'update_contact.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  TextEditingController _searchController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contacts"),
        actions: [
          IconButton(onPressed: () {
            AuthService().logout();
            Navigator.pushReplacementNamed(context, "/login");
          }, icon: const Icon(Icons.logout))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, "/add"),
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _searchController,
              onChanged: (value) => setState(() {}),
              decoration: const InputDecoration(
                hintText: "Search",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder()
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: CRUDService().getContacts(searchQuery: _searchController.text),
              builder: (context, snapshot) {
                if (snapshot.hasError) return const Text("Error");
                if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
                
                return ListView(
                  children: snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                    return ListTile(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateContactPage(
                        docID: document.id, name: data['name'], phone: data['phone'], email: data['email']
                      ))),
                      leading: CircleAvatar(child: Text(data['name'][0])),
                      title: Text(data['name']),
                      subtitle: Text(data['phone']),
                      trailing: IconButton(icon: const Icon(Icons.call), onPressed: () {}),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}