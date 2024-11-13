import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Paramètres",
          style: TextStyle(
            color: Colors.black
          ),  
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.black, 
          ),
          tooltip: "Retour",
          onPressed: () {
            Get.back();
          },
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            color: theme.colorScheme.primary,
            height: 4.0,
          )
        )
      ),
    );
  }
}