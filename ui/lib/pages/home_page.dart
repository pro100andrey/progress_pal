import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({required this.isWaiting, super.key});

  final bool isWaiting;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      centerTitle: false,
      title: const Text('Progress Pal'),
    ),
    body: const SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        spacing: 16,
      ),
    ),
  );
}
