import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    const stH = TextStyle(color: Colors.white, fontWeight: FontWeight.bold);
    const st = TextStyle(color: Colors.white);
    const double sizeIcon = 48.0;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Error Page", style: stH),
        elevation: 0,
        backgroundColor: Colors.black,
      ),
      body: const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error, color: Colors.red, size: sizeIcon),
            Text("Error the route was not found", style: st),
          ],
        ),
      ),
    );
  }
}
