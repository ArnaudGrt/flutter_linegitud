import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:linegitud/controllers/new_line.dart';
import 'package:linegitud/models/user.dart';

class NewLine extends StatelessWidget {
  NewLine({super.key});

  final NewLineController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(Get.context!);

    return Scaffold(
        body: Form(
            key: controller.formKey,
            child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "De qui ?",
                      textAlign: TextAlign.left,
                    ),
                    Obx(() => DropdownButtonHideUnderline(
                            child: Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 8),
                          child: DropdownButtonFormField(
                            hint: const Text("test"),
                            items: controller.users.value
                                .map((user) => DropdownMenuItem<CleanUser>(
                                    value: user,
                                    child: Padding(
                                      padding: const EdgeInsets.all(0),
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                              radius: 16,
                                              backgroundImage:
                                                  NetworkImage(user.avatar)),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 8),
                                            child: Text(user.name),
                                          )
                                        ],
                                      ),
                                    )))
                                .toList(),
                            onChanged: (value) => value,
                            icon: const Icon(FontAwesomeIcons.angleDown,
                                color: Colors.black),
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                    FontAwesomeIcons.circleQuestion,
                                    color: theme.colorScheme.primary),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: const BorderSide(
                                        color: Colors.red, width: 0.4)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: const BorderSide(
                                        color: Colors.green, width: 0.4)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: const BorderSide(
                                        color: Colors.blue, width: 0.4)),
                                disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: const BorderSide(
                                        color: Colors.cyan, width: 0.4)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: const BorderSide(
                                        color: Colors.purple, width: 0.4)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: const BorderSide(
                                        color: Colors.orange, width: 0.4))),
                          ),
                        ))),
                    const Text("Pour qui ?"),
                  ],
                ))));
  }
}
