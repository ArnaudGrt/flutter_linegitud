import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:linegitud/controllers/home.dart';
import 'package:linegitud/controllers/new_line.dart';
import 'package:linegitud/models/user.dart';

class NewLine extends StatelessWidget {
  NewLine({super.key});

  final NewLineController controller = Get.find();
  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(Get.context!);

    return Scaffold(
        body: SingleChildScrollView(
            child: Form(
                key: controller.formKey,
                child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "De qui ?",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        Obx(() => DropdownButtonHideUnderline(
                                child: Padding(
                              padding: const EdgeInsets.only(top: 8, bottom: 8),
                              child: DropdownButtonFormField(
                                itemHeight: 64,
                                validator: (value) {
                                  if (value == null) {
                                    return "L'émetteur doit être renseigné !";
                                  }

                                  return null;
                                },
                                hint: const Text(
                                  "Émetteur",
                                  style: TextStyle(color: Colors.black),
                                ),
                                items: controller.users.value
                                    .map((user) => DropdownMenuItem<CleanUser>(
                                        enabled:
                                            controller.lineRecipient.value !=
                                                user.name,
                                        value: user,
                                        child: Padding(
                                          padding: const EdgeInsets.all(0),
                                          child: Row(
                                            children: [
                                              Stack(
                                                children: [
                                                  CircleAvatar(
                                                      radius: 16,
                                                      backgroundImage:
                                                          NetworkImage(
                                                              user.avatar)),
                                                  CircleAvatar(
                                                    radius: 16,
                                                    backgroundColor: controller
                                                                .lineRecipient
                                                                .value !=
                                                            user.name
                                                        ? Colors.transparent
                                                        : const Color.fromRGBO(
                                                            0, 0, 0, 0.75),
                                                  )
                                                ],
                                              ),
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8),
                                                  child: Text(
                                                    user.name,
                                                    style: TextStyle(
                                                      color: controller
                                                                  .lineRecipient
                                                                  .value !=
                                                              user.name
                                                          ? Colors.black
                                                          : Colors.grey,
                                                    ),
                                                  ))
                                            ],
                                          ),
                                        )))
                                    .toList(),
                                onChanged: (value) {
                                  controller.lineSender.value = value?.name;
                                },
                                icon: const Icon(FontAwesomeIcons.angleDown,
                                    color: Colors.black),
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    prefixIcon: Icon(
                                        FontAwesomeIcons.circleQuestion,
                                        color: theme.colorScheme.primary),
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(4),
                                        borderSide: BorderSide(
                                            color: theme.colorScheme.error,
                                            width: 0.4)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(4),
                                        borderSide: BorderSide(
                                            color: theme.colorScheme.primary,
                                            width: 0.4)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(4),
                                        borderSide: BorderSide(
                                            color: theme.colorScheme.primary,
                                            width: 0.4)),
                                    focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(4),
                                        borderSide: BorderSide(
                                            color: theme.colorScheme.error,
                                            width: 0.4)),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(4),
                                        borderSide: BorderSide(
                                            color: theme.colorScheme.primary,
                                            width: 0.4))),
                              ),
                            ))),
                        const Text(
                          "Pour qui ?",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        Obx(() => DropdownButtonHideUnderline(
                                child: Padding(
                              padding: const EdgeInsets.only(top: 8, bottom: 8),
                              child: DropdownButtonFormField(
                                itemHeight: 64,
                                validator: (value) {
                                  if (value == null) {
                                    return 'Le destinataire doit être renseigné !';
                                  }

                                  return null;
                                },
                                hint: const Text(
                                  "Destinataire",
                                  style: TextStyle(color: Colors.black),
                                ),
                                items: controller.users.value
                                    .map((user) => DropdownMenuItem<CleanUser>(
                                        enabled: controller.lineSender.value !=
                                            user.name,
                                        value: user,
                                        child: Padding(
                                          padding: const EdgeInsets.all(0),
                                          child: Row(
                                            children: [
                                              Stack(
                                                children: [
                                                  CircleAvatar(
                                                      radius: 16,
                                                      backgroundImage:
                                                          NetworkImage(
                                                              user.avatar)),
                                                  CircleAvatar(
                                                    radius: 16,
                                                    backgroundColor: controller
                                                                .lineSender
                                                                .value !=
                                                            user.name
                                                        ? Colors.transparent
                                                        : const Color.fromRGBO(
                                                            0, 0, 0, 0.75),
                                                  )
                                                ],
                                              ),
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8),
                                                  child: Text(
                                                    user.name,
                                                    style: TextStyle(
                                                      color: controller
                                                                  .lineSender
                                                                  .value !=
                                                              user.name
                                                          ? Colors.black
                                                          : Colors.grey,
                                                    ),
                                                  ))
                                            ],
                                          ),
                                        )))
                                    .toList(),
                                onChanged: (value) {
                                  controller.lineRecipient.value = value?.name;
                                },
                                icon: const Icon(FontAwesomeIcons.angleDown,
                                    color: Colors.black),
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    prefixIcon: Icon(
                                        FontAwesomeIcons.circleQuestion,
                                        color: theme.colorScheme.primary),
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(4),
                                        borderSide: BorderSide(
                                            color: theme.colorScheme.error,
                                            width: 0.4)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(4),
                                        borderSide: BorderSide(
                                            color: theme.colorScheme.primary,
                                            width: 0.4)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(4),
                                        borderSide: BorderSide(
                                            color: theme.colorScheme.primary,
                                            width: 0.4)),
                                    focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(4),
                                        borderSide: BorderSide(
                                            color: theme.colorScheme.error,
                                            width: 0.4)),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(4),
                                        borderSide: BorderSide(
                                            color: theme.colorScheme.primary,
                                            width: 0.4))),
                              ),
                            ))),
                        const Text(
                          "La raison ?",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 8),
                            child: TextFormField(
                              maxLines: 5,
                              maxLength: 350,
                              onTapOutside: (event) {
                                return FocusScope.of(context).unfocus();
                              },
                              onChanged: (value) {
                                controller.lineReason.value = value.toString();
                              },
                              validator: (value) {
                                if (value == "" || value == null) {
                                  return 'Une raison VALABLE doit être renseignée !';
                                }

                                return null;
                              },
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  prefixIcon: Icon(FontAwesomeIcons.commentDots,
                                      color: theme.colorScheme.primary),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: BorderSide(
                                          color: theme.colorScheme.error,
                                          width: 0.4)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: BorderSide(
                                          color: theme.colorScheme.primary,
                                          width: 0.4)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: BorderSide(
                                          color: theme.colorScheme.primary,
                                          width: 0.4)),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: BorderSide(
                                          color: theme.colorScheme.error,
                                          width: 0.4)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: BorderSide(
                                          color: theme.colorScheme.primary,
                                          width: 0.4))),
                            )),
                        Obx(() => controller.isLoading.value
                            ? loaderSubmit()
                            : formSubmit())
                      ],
                    )))));
  }

  Widget formSubmit() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: FilledButton.icon(
              onPressed: () async {
                if (controller.formKey.currentState!.validate()) {
                  final result = await controller.createLine();

                  if (result.success) {
                    Get.dialog(successDialog(result.success, null),
                        barrierDismissible: false);
                    return;
                  }

                  Get.dialog(successDialog(result.success, result.error),
                      barrierDismissible: false);
                  return;
                }
              },
              label: const Text("Envoyer"),
              icon: const Icon(
                FontAwesomeIcons.arrowRight,
                size: 16,
              ),
              iconAlignment: IconAlignment.end,
            )),
        Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: ElevatedButton.icon(
                onPressed: () {
                  controller.formKey.currentState!.reset();
                },
                label: const Text("Réinitialiser")))
      ],
    );
  }

  Widget loaderSubmit() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(),
      ],
    );
  }

  Widget successDialog(bool success, String? errorText) {
    return AlertDialog(
        icon: success
            ? const Icon(FontAwesomeIcons.circleCheck,
                color: Colors.lime, size: 48)
            : const Icon(FontAwesomeIcons.circleExclamation,
                color: Colors.red, size: 48),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: success
                    ? const Text(
                        "Le trait a correctement été ajouté à la personne concernée !",
                        style: TextStyle(fontSize: 14),
                        textAlign: TextAlign.center,
                      )
                    : Text(
                        errorText ?? "",
                        style: const TextStyle(fontSize: 14),
                        textAlign: TextAlign.center,
                      ))
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();

              if (success) {
                homeController.selectMenu(0);
              }
            },
            child: const Text('Fermer'),
          ),
        ],
        actionsPadding: const EdgeInsets.only(bottom: 4, right: 12));
  }
}
