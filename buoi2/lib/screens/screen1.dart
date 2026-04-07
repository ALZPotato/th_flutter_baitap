import 'package:flutter/material.dart';

class Screen1 extends StatelessWidget {
  const Screen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Screen 1')),
      body: const LayoutApp()   
    );
  }
}

class LayoutApp extends StatelessWidget {
  const LayoutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('I\'m in a Column and I\'m centered, the below is a Row'),
          const SizedBox(height: 20),
        Row(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisAlignment: MainAxisAlignment.center, 
          children: [
              Container(width: 100, height: 100, color: Colors.red),
              const SizedBox(width: 10),
              Container(width: 100, height: 100, color: Colors.green),
              const SizedBox(width: 10),
              Container(width: 100, height: 100, color: Colors.blue),
          ],
        ),
        const SizedBox(height: 20),
        Stack(
          //alignment: Alignment.center,
          alignment: Alignment.topLeft,
          children: [
            Container(
              width: 150,
              height: 150,
              color: Colors.yellow,
            ),
            const Text(
              'Stack',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
      ),    
    );
  }
}
