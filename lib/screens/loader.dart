import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: Center(
            child: CircularProgressIndicator(
              color: theme.colorScheme.tertiaryContainer,
            ),
          ))
        ],
      ),
    );
  }
}
