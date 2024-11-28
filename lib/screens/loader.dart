import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Expanded(
              child: Center(
            child: CircularProgressIndicator(),
          ))
        ],
      ),
    );
  }
}
