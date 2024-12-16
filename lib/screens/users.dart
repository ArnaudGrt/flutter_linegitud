import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:linegitud/controllers/users.dart';
import 'package:linegitud/models/user.dart';
import 'package:linegitud/utils/options.dart';

class Users extends StatelessWidget {
  Users({super.key});

  final UsersController controller = Get.find();

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
    Rx<Options<bool>> searchResultValue = Rx(Options<bool>());

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
                            final result = await controller.searchUser();
                            searchResultValue.value.setSome(result.success);
                            searchResultValue.refresh();
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
              Obx(() => searchResultValue.value.match(
                  onNone: () => const SizedBox.shrink(),
                  onLoading: () => const SizedBox.shrink(),
                  onSome: (value) {
                    return value
                        ? Text(
                            "L'utilisateur recherché a bien été trouvé !",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: theme.colorScheme.primaryContainer),
                          )
                        : Text(
                            "L'utilisateur recherché n'a pas été trouvé...",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: theme.colorScheme.error),
                          );
                  }))
            ]),
          ),
          Obx(() => searchResultValue.value.match(
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
                            onPressed: () {},
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

                            },
                            label: Text(
                              "Supprimer",
                              style: TextStyle(
                                  color: theme.colorScheme.onInverseSurface),
                            )),
                      ],
                    )
                  : const SizedBox.shrink()))
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
          Text(
            "Nouvel utilisateur",
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
                onChanged: (value) {},
                validator: (value) {
                  if (value == "" || value == null) {
                    return 'Un nom doit être renseigné !';
                  }

                  return null;
                },
                style: TextStyle(color: theme.colorScheme.onSurface),
                cursorColor: theme.colorScheme.tertiaryContainer,
                decoration: InputDecoration(
                    hintText: "Prénom",
                    hintStyle:
                        TextStyle(color: theme.colorScheme.inverseSurface),
                    filled: true,
                    fillColor: theme.colorScheme.onInverseSurface,
                    prefixIcon: Icon(FontAwesomeIcons.userPen,
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
          Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: TextFormField(
                onTapOutside: (event) {
                  return FocusScope.of(context).unfocus();
                },
                onChanged: (value) {},
                validator: (value) {
                  if (value == "" || value == null) {
                    return 'Un avatar doit être renseignée !';
                  }

                  return null;
                },
                style: TextStyle(color: theme.colorScheme.onSurface),
                cursorColor: theme.colorScheme.tertiaryContainer,
                decoration: InputDecoration(
                    hintText: "Avatar",
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
          userFormSubmit(theme)
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
                  controller.userFormKey.currentState!.reset();
                },
                label: Text(
                  "Réinitialiser",
                  style: TextStyle(color: theme.colorScheme.onSurface),
                ))),
        Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: FilledButton.icon(
              style: ButtonStyle(
                  overlayColor: WidgetStatePropertyAll<Color>(
                      theme.colorScheme.tertiaryContainer),
                  backgroundColor: WidgetStatePropertyAll<Color>(
                      theme.colorScheme.tertiary)),
              onPressed: () async {},
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

  Widget successDialog(theme, CleanUser user) {
    final dialogText =
        "Êtes-vous sûr de vouloir supprimer l'utilisateur ${user.name}";

    return AlertDialog(
        contentPadding: const EdgeInsets.only(top: 16, left: 12, right: 12),
        backgroundColor: theme.colorScheme.onInverseSurface,
        icon: Icon(FontAwesomeIcons.circleQuestion,
            color: theme.colorScheme.primaryContainer, size: 48),
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
            onPressed: () {
              Get.back();
            },
            child: Text(
              'Fermer',
              style: TextStyle(color: theme.colorScheme.onSurface),
            ),
          ),
        ],
        actionsPadding: const EdgeInsets.only(bottom: 4, right: 12));
  }
}
