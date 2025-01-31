import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:linegitud/controllers/history.dart';
import 'package:linegitud/controllers/users.dart';
import 'package:linegitud/models/db.dart';
import 'package:linegitud/models/user.dart';
import 'package:linegitud/utils/options.dart';

class Users extends StatelessWidget {
  Users({super.key});

  final UsersController controller = Get.find();
  final HistoryController historyController = Get.find();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
        appBar: AppBar(
            backgroundColor: theme.colorScheme.surfaceContainerLowest,
            iconTheme:
                IconThemeData(color: theme.colorScheme.tertiaryContainer),
            title: Text("Utilisateurs".toUpperCase(),
                style: TextStyle(
                    color: theme.colorScheme.tertiary,
                    fontSize: 18,
                    fontWeight: FontWeight.w500)),
            leading: IconButton(
              highlightColor: theme.colorScheme.onTertiary,
              icon: const Icon(Icons.arrow_back_rounded),
              tooltip: "Retour",
              onPressed: () {
                Get.back();
              },
            ),
            bottom: PreferredSize(
                preferredSize: const Size.fromHeight(4.0),
                child: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: <Color>[
                        Color(0xFF48C6A9),
                        Color(0xFF529FCB),
                        Color(0xFFF36D6C),
                        Color(0xFFF8AE35),
                      ],
                          stops: <double>[
                        0.0,
                        4.3,
                        7.6,
                        1.0
                      ])),
                  height: 4.0,
                ))),
        body: Padding(
            padding: const EdgeInsets.all(12),
            child: SingleChildScrollView(
              child: Column(children: [
                searchUser(context),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: Divider(
                    height: 12,
                    color: theme.colorScheme.inverseSurface,
                  ),
                ),
                userSection(context)
              ]),
            )));
  }

  Widget searchUser(context) {
    var theme = Theme.of(context);

    return Form(
      key: controller.searchFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Rechercher un utilisateur",
            textAlign: TextAlign.left,
            style: TextStyle(
                color: theme.colorScheme.inverseSurface,
                fontWeight: FontWeight.bold,
                fontSize: 14),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: TextFormField(
                maxLength: 20,
                onTapOutside: (event) {
                  return FocusScope.of(context).unfocus();
                },
                onChanged: (value) {
                  controller.userSearchValue.value = value;
                },
                validator: (value) {
                  if (value == "" || value == null) {
                    return 'Une valeur doit être renseignée...';
                  }

                  return null;
                },
                style: TextStyle(color: theme.colorScheme.onSurface),
                cursorColor: theme.colorScheme.tertiaryContainer,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: theme.colorScheme.onInverseSurface,
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide(
                            color: theme.colorScheme.error, width: 0.4)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide(
                            color: theme.colorScheme.tertiaryContainer,
                            width: 0.4)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide(
                            color: theme.colorScheme.tertiaryContainer,
                            width: 0.4)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide(
                            color: theme.colorScheme.error, width: 0.4)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide(
                            color: theme.colorScheme.tertiaryContainer,
                            width: 0.4)),
                    suffixIcon: IconButton(
                        onPressed: () async {
                          if (controller.searchFormKey.currentState!
                              .validate()) {
                            controller.deleteUserResult.value =
                                Options<DbResult>();

                            final result = await controller.searchUser();
                            controller.searchResultValue.value
                                .setSome(result.success);
                            controller.searchResultValue.refresh();

                            if (result.success) {
                              controller.searchResultUser.value = result.user;
                            } else {
                              controller.searchResultUser.value =
                                  CleanUser(name: "", avatar: "");
                            }
                          }
                        },
                        icon: Icon(
                          FontAwesomeIcons.magnifyingGlass,
                          size: 18,
                          color: theme.colorScheme.inverseSurface,
                        ))),
              )),
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Obx(() => controller.searchResultValue.value.match(
                  onNone: () => const SizedBox.shrink(),
                  onLoading: () => const SizedBox.shrink(),
                  onSome: (value) {
                    return value
                        ? Text(
                            "1 utilisateur a été trouvé !",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: theme.colorScheme.primaryContainer),
                          )
                        : Text(
                            "Aucun utilisateur n'a été trouvé...",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: theme.colorScheme.error),
                          );
                  }))
            ]),
          ),
          Obx(() => controller.searchResultValue.value.match(
              onLoading: () => const SizedBox.shrink(),
              onNone: () => const SizedBox.shrink(),
              onSome: (value) => value
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton.icon(
                            style: ButtonStyle(
                                overlayColor: WidgetStatePropertyAll<Color>(
                                    theme.colorScheme.tertiaryContainer),
                                backgroundColor: WidgetStatePropertyAll<Color>(
                                    theme.colorScheme.tertiary)),
                            onPressed: () {
                              controller.formMode.value = "update";
                              controller.formMode.refresh();
                              controller.nameController.text =
                                  controller.searchResultUser.value.name;
                              controller.userName.value =
                                  controller.searchResultUser.value.name;
                              controller.avatarController.text =
                                  controller.searchResultUser.value.avatar;
                            },
                            label: Text(
                              "Modifier",
                              style: TextStyle(
                                  color: theme.colorScheme.onInverseSurface),
                            )),
                        ElevatedButton.icon(
                            style: ButtonStyle(
                                overlayColor: WidgetStatePropertyAll<Color>(
                                    theme.colorScheme.error),
                                backgroundColor: WidgetStatePropertyAll<Color>(
                                    theme.colorScheme.errorContainer)),
                            onPressed: () {
                              if (controller.searchResultUser.value.name !=
                                  "") {
                                Get.dialog(deleteDialog(theme),
                                    barrierDismissible: false);
                              }
                            },
                            label: Text(
                              "Supprimer",
                              style: TextStyle(
                                  color: theme.colorScheme.onInverseSurface),
                            )),
                      ],
                    )
                  : const SizedBox.shrink())),
          Obx(() => controller.deleteUserResult.value.match(
              onNone: () => const SizedBox.shrink(),
              onLoading: () => const SizedBox.shrink(),
              onSome: (value) {
                return value.success
                    ? resultDisplay(theme, true,
                        "L'utilisateur a été supprimé avec succès !")
                    : resultDisplay(
                        theme,
                        false,
                        value.error ??
                            "L'utilisateur n'a pas pu être supprimé...");
              }))
        ],
      ),
    );
  }

  Widget userSection(context) {
    var theme = Theme.of(context);

    return Form(
      key: controller.userFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() => Text(
                controller.formMode.value == "create"
                    ? "Nouvel utilisateur"
                    : "Mettre un jour un utilisateur",
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: theme.colorScheme.inverseSurface,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              )),
          Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Obx(() => TextFormField(
                    controller: controller.nameController,
                    readOnly: controller.formMode.value == "update",
                    maxLength: 20,
                    onTapOutside: (event) {
                      return FocusScope.of(context).unfocus();
                    },
                    onChanged: (value) {
                      controller.userName.value = value;
                    },
                    validator: (value) {
                      if (value == "" || value == null) {
                        return 'Un nom doit être renseigné !';
                      }

                      return null;
                    },
                    style: TextStyle(
                        color: controller.formMode.value == 'create'
                            ? theme.colorScheme.onSurface
                            : theme.colorScheme.outlineVariant),
                    cursorColor: theme.colorScheme.tertiaryContainer,
                    decoration: InputDecoration(
                        hintText: "Prénom",
                        hintStyle: TextStyle(
                            color: controller.formMode.value == "create"
                                ? theme.colorScheme.inverseSurface
                                : theme.colorScheme.outlineVariant),
                        filled: true,
                        fillColor: theme.colorScheme.onInverseSurface,
                        prefixIcon: Icon(FontAwesomeIcons.userPen,
                            size: 18,
                            color: controller.formMode.value == 'create'
                                ? theme.colorScheme.tertiary
                                : theme.colorScheme.outlineVariant),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: BorderSide(
                                color: theme.colorScheme.error, width: 0.4)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: BorderSide(
                                color: theme.colorScheme.tertiaryContainer,
                                width: 0.4)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: BorderSide(
                                color: theme.colorScheme.tertiaryContainer,
                                width: 0.4)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: BorderSide(
                                color: theme.colorScheme.error, width: 0.4)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: BorderSide(
                                color: theme.colorScheme.tertiaryContainer,
                                width: 0.4))),
                  ))),
          Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: TextFormField(
                controller: controller.avatarController,
                onTapOutside: (event) {
                  return FocusScope.of(context).unfocus();
                },
                onChanged: (value) {
                  controller.userAvatar.value = value;
                },
                validator: (value) {
                  if (value == "" || value == null) {
                    return 'Un avatar doit être renseigné !';
                  }

                  return null;
                },
                style: TextStyle(color: theme.colorScheme.onSurface),
                cursorColor: theme.colorScheme.tertiaryContainer,
                decoration: InputDecoration(
                    hintText: "URL de l'avatar",
                    hintStyle:
                        TextStyle(color: theme.colorScheme.inverseSurface),
                    filled: true,
                    fillColor: theme.colorScheme.onInverseSurface,
                    prefixIcon: Icon(FontAwesomeIcons.image,
                        size: 18, color: theme.colorScheme.tertiary),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide(
                            color: theme.colorScheme.error, width: 0.4)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide(
                            color: theme.colorScheme.tertiaryContainer,
                            width: 0.4)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide(
                            color: theme.colorScheme.tertiaryContainer,
                            width: 0.4)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide(
                            color: theme.colorScheme.error, width: 0.4)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide(
                            color: theme.colorScheme.tertiaryContainer,
                            width: 0.4))),
              )),
          userFormSubmit(theme),
          Obx(() => controller.newUserResult.value.match(
              onNone: () => const SizedBox.shrink(),
              onLoading: () => const SizedBox.shrink(),
              onSome: (value) {
                return value.success
                    ? resultDisplay(
                        theme, true, "L'utilisateur a été créé avec succès !")
                    : resultDisplay(theme, false,
                        value.error ?? "L'utilisateur n'a pas pu être créé...");
              })),
          Obx(() => controller.updateUserResult.value.match(
              onNone: () => const SizedBox.shrink(),
              onLoading: () => const SizedBox.shrink(),
              onSome: (value) {
                return value.success
                    ? resultDisplay(theme, true,
                        "L'utilisateur a été mis à jour avec succès !")
                    : resultDisplay(
                        theme,
                        false,
                        value.error ??
                            "L'utilisateur n'a pas pu être mis à jour...");
              })),
        ],
      ),
    );
  }

  Widget userFormSubmit(theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: ElevatedButton.icon(
                style: ButtonStyle(
                    overlayColor: WidgetStatePropertyAll<Color>(
                        theme.colorScheme.surfaceContainerHighest),
                    backgroundColor: WidgetStatePropertyAll<Color>(
                        theme.colorScheme.onInverseSurface)),
                onPressed: () {
                  if (controller.formMode.value == 'update') {
                    return;
                  }

                  controller.userFormKey.currentState!.reset();
                  controller.newUserResult.value = Options<DbResult>();
                  controller.reset();
                },
                label: Obx(() => Text(
                      "Réinitialiser",
                      style: TextStyle(
                          color: controller.formMode.value == 'create'
                              ? theme.colorScheme.onSurface
                              : theme.colorScheme.outlineVariant),
                    )))),
        Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: FilledButton.icon(
              style: ButtonStyle(
                  overlayColor: WidgetStatePropertyAll<Color>(
                      theme.colorScheme.tertiaryContainer),
                  backgroundColor: WidgetStatePropertyAll<Color>(
                      theme.colorScheme.tertiary)),
              onPressed: () async {
                if (controller.userFormKey.currentState!.validate()) {
                  if (controller.formMode.value == 'update') {
                    final result = await controller.updateUser();
                    controller.updateUserResult.value.setSome(result);
                    controller.updateUserResult.refresh();

                    if (result.success) {
                      controller.reset();
                    }

                    return;
                  }

                  final result = await controller.createUser();
                  controller.newUserResult.value.setSome(result);
                  controller.newUserResult.refresh();
                }
              },
              label: Text(
                "Enregistrer",
                style: TextStyle(color: theme.colorScheme.onInverseSurface),
              ),
              icon: Icon(
                FontAwesomeIcons.arrowRight,
                color: theme.colorScheme.onInverseSurface,
                size: 16,
              ),
              iconAlignment: IconAlignment.end,
            )),
      ],
    );
  }

  Widget deleteDialog(theme) {
    final dialogText =
        "Êtes-vous sûr de vouloir supprimer l'utilisateur ${controller.searchResultUser.value.name} ?";

    return AlertDialog(
        contentPadding: const EdgeInsets.only(top: 16, left: 12, right: 12),
        backgroundColor: theme.colorScheme.onInverseSurface,
        icon: Icon(FontAwesomeIcons.circleQuestion,
            color: theme.colorScheme.tertiary, size: 48),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: Text(
              dialogText,
              style:
                  TextStyle(fontSize: 14, color: theme.colorScheme.onSurface),
              textAlign: TextAlign.center,
            ))
          ],
        ),
        actions: [
          TextButton(
            style: ButtonStyle(
              overlayColor: WidgetStatePropertyAll<Color>(
                  theme.colorScheme.surfaceContainerHighest),
            ),
            onPressed: () async {
              final result = await controller
                  .deleteUser(controller.searchResultUser.value.name);

              controller.deleteUserResult.value.setSome(result);
              controller.deleteUserResult.refresh();

              if (result.success) {
                controller.reset();
                historyController.initLinesHistory();
              }

              Get.back();
            },
            child: Text(
              'Oui',
              style: TextStyle(color: theme.colorScheme.primaryContainer),
            ),
          ),
          TextButton(
            style: ButtonStyle(
              overlayColor: WidgetStatePropertyAll<Color>(
                  theme.colorScheme.surfaceContainerHighest),
            ),
            onPressed: () {
              Get.back();
            },
            child: Text(
              'Non',
              style: TextStyle(color: theme.colorScheme.errorContainer),
            ),
          ),
        ],
        actionsPadding: const EdgeInsets.only(bottom: 4, right: 12));
  }

  Widget resultDisplay(theme, bool success, String text) {
    return Row(children: [
      Expanded(
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: success
                      ? theme.colorScheme.primaryContainer
                      : theme.colorScheme.errorContainer),
              child: Padding(
                  padding: const EdgeInsets.only(
                      top: 20, bottom: 20, left: 8, right: 4),
                  child: RichText(
                      text: TextSpan(children: [
                    WidgetSpan(
                        child: Icon(
                      success
                          ? FontAwesomeIcons.circleCheck
                          : FontAwesomeIcons.triangleExclamation,
                      size: 16,
                    )),
                    const WidgetSpan(
                        child: SizedBox(
                      width: 4,
                    )),
                    TextSpan(
                        text: text,
                        style: TextStyle(color: theme.colorScheme.onSurface))
                  ]))))),
    ]);
  }
}
