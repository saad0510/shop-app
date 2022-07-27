import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class TextTestScreen extends StatefulWidget {
  const TextTestScreen({Key? key}) : super(key: key);

  @override
  State<TextTestScreen> createState() => _TextTestScreenState();
}

class _TextTestScreenState extends State<TextTestScreen> {
  bool showGeneralText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Text Test"),
        actions: [
          Switch(
            value: showGeneralText,
            onChanged: (val) => setState(() => showGeneralText = val),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(children: showGeneralText ? generalTexts : appTexts),
      ),
    );
  }

  late final headlines = [
    Text(
      "${MediaQuery.of(context).size.width.round()}x${MediaQuery.of(context).size.height.round()}",
      textAlign: TextAlign.center,
      style: Get.textTheme.headline1,
    ),
    Text(
      "This is Headline1",
      textAlign: TextAlign.center,
      style: Get.textTheme.headline1,
    ),
    Text(
      "This is Headline2",
      textAlign: TextAlign.center,
      style: Get.textTheme.headline2,
    ),
    Text(
      "This is Headline3",
      textAlign: TextAlign.center,
      style: Get.textTheme.headline3,
    ),
    Text(
      "This is Headline4",
      textAlign: TextAlign.center,
      style: Get.textTheme.headline4,
    ),
    Text(
      "This is Headline5",
      textAlign: TextAlign.center,
      style: Get.textTheme.headline5,
    ),
    Text(
      "This is Headline6",
      textAlign: TextAlign.center,
      style: Get.textTheme.headline6,
    ),
  ];
  final subtitles = [
    Text(
      "This is Subtitle1",
      textAlign: TextAlign.center,
      style: Get.textTheme.subtitle1,
    ),
    Text(
      "This is Subtitle2",
      textAlign: TextAlign.center,
      style: Get.textTheme.subtitle2,
    ),
  ];
  final bodyTexts = [
    Text(
      "This is BodyText1",
      textAlign: TextAlign.center,
      style: Get.textTheme.bodyText1,
    ),
    Text(
      "This is BodyText2",
      textAlign: TextAlign.center,
      style: Get.textTheme.bodyText2,
    ),
  ];
  final titles = [
    Text(
      "This is TitleLarge",
      textAlign: TextAlign.center,
      style: Get.textTheme.titleLarge,
    ),
    Text(
      "This is TitleMedium",
      textAlign: TextAlign.center,
      style: Get.textTheme.titleMedium,
    ),
    Text(
      "This is TitleSmall",
      textAlign: TextAlign.center,
      style: Get.textTheme.titleSmall,
    ),
  ];
  final bodySemantic = [
    Text(
      "This is BodyLarge",
      textAlign: TextAlign.center,
      style: Get.textTheme.bodyLarge,
    ),
    Text(
      "This is BodyMedium",
      textAlign: TextAlign.center,
      style: Get.textTheme.bodyMedium,
    ),
    Text(
      "This is BodySmall",
      textAlign: TextAlign.center,
      style: Get.textTheme.bodySmall,
    ),
  ];

  late final generalTexts = [
    const Divider(thickness: 10, height: 50),
    ...headlines,
    const Divider(thickness: 10, height: 50),
    ...bodyTexts,
    const Divider(thickness: 10, height: 50),
    ...subtitles,
    const Divider(thickness: 10, height: 50),
    ...titles,
    const Divider(thickness: 10, height: 50),
    ...bodySemantic,
    const Divider(thickness: 10, height: 50),
    const Text(
      "This is Default Text",
      textAlign: TextAlign.center,
    ),
    const Divider(thickness: 10, height: 50),
  ];

  late final appTexts = [
    const Divider(thickness: 10, height: 50),
    Text(
      "TOKOTO",
      textAlign: TextAlign.center,
      style: Get.textTheme.headline1,
    ),
    const Divider(thickness: 10, height: 50),
    Text(
      "Register Account",
      textAlign: TextAlign.center,
      style: Get.textTheme.headline2,
    ),
    const Divider(thickness: 10, height: 50),
    Text(
      "Cashback 20%",
      textAlign: TextAlign.center,
      style: Get.textTheme.headline3,
    ),
    const Divider(thickness: 10, height: 50),
    Text(
      "Special for you",
      textAlign: TextAlign.center,
      style: Get.textTheme.headline4,
    ),
    const Divider(thickness: 10, height: 50),
    Text(
      "Your Cart",
      textAlign: TextAlign.center,
      style: Get.textTheme.headline5,
    ),
    const Divider(thickness: 10, height: 50),
    Text(
      "Sign Up",
      textAlign: TextAlign.center,
      style: Get.textTheme.headline6,
    ),
    const Divider(thickness: 10, height: 50),
    Text(
      "Welcome to Tokoto! Let's shop",
      textAlign: TextAlign.center,
      style: Get.textTheme.subtitle1,
    ),
    const Divider(thickness: 10, height: 50),
    Text(
      "Enter your email",
      textAlign: TextAlign.center,
      style: Get.textTheme.subtitle2,
    ),
    const Divider(thickness: 10, height: 50),
  ];

//
}
