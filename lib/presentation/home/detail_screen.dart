import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final String label;

  const DetailScreen({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail - $label"),
      ),
      body: Center(
        child: Text("Detail $label Screen"),
      ),
    );
  }
}
