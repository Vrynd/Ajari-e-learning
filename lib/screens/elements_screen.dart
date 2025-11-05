import 'package:flutter/material.dart';

class ElementsScreen extends StatelessWidget {
  const ElementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Elements'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: const SafeArea(
        child: Center(
          child: Text('Elements placeholder', style: TextStyle(fontSize: 16)),
        ),
      ),
    );
  }
}
