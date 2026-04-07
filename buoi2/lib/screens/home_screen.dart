import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lab 2')),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Màn hình 1'),
            onTap: () => Navigator.pushNamed(context, '/screen1'),
          ),
          ListTile(
            title: const Text('Màn hình 2'),
            onTap: () => Navigator.pushNamed(context, '/screen2'),
          ),
          ListTile(
            title: const Text('Màn hình 3'),
            onTap: () => Navigator.pushNamed(context, '/screen3'),
          ),
          ListTile(
            title: const Text('Màn hình 4'),
            onTap: () => Navigator.pushNamed(context, '/screen4'),
          ),
        ],
      ),
    );
  }
}
