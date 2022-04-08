import 'dart:async';

import 'package:face_to_face_voting/theme/app_theme.dart';
import 'package:face_to_face_voting/utils/spacing.dart';
import 'package:face_to_face_voting/widgets/text.dart';
import 'package:flutter/material.dart';

class QuizQuestionScreen extends StatefulWidget {
  const QuizQuestionScreen({Key? key}) : super(key: key);

  @override
  _QuizQuestionScreenState createState() => _QuizQuestionScreenState();
}

class _QuizQuestionScreenState extends State<QuizQuestionScreen> {
  @override
  void initState() {
    super.initState();
  }

  int? _selectedOption = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            padding: Spacing.fromLTRB(16, 42, 16, 0),
            child: Column(
              children: <Widget>[
                CustomText.titleMedium("Отчётно выборочная конференция ИИТ",
                    color: AppTheme.theme.colorScheme.onBackground,
                    fontWeight: 700),
                CustomText.bodySmall("Идёт голосование",
                    color: AppTheme.theme.colorScheme.onBackground,
                    fontWeight: 500)
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: Spacing.fromLTRB(48, 0, 48, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  CustomText.titleLarge(
                    "Утвердить протоколы счётной комиссии?",
                    letterSpacing: 0.2,
                    wordSpacing: 0.5,
                    color: AppTheme.theme.colorScheme.onBackground,
                    fontWeight: 600,
                    textAlign: TextAlign.center,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      questionOption(option: "За", index: 0),
                      questionOption(option: "Против", index: 1),
                      questionOption(option: "Воздержусь", index: 2),
                      // questionOption(option: "Carburetor", index: 3),
                    ],
                  ),
                  const SizedBox(height: 50),
                  CustomText.bodySmall(
                    "Голосование завершится автоматически, когда все участники проголосуют. Если вы не успеете завершить голосование, ваш голос автоматически отправится как \"воздержусь\".",
                    color: AppTheme.theme.colorScheme.onBackground,
                    muted: true,
                    textAlign: TextAlign.justify,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget questionOption({required String option, int? index}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedOption = index;
        });
      },
      child: Container(
        decoration: BoxDecoration(
            color: _selectedOption == index
                ? AppTheme.theme.colorScheme
                    .primary //_getColorBySelectedOption(option)
                : Colors.transparent,
            border: Border.all(
                color: _selectedOption == index
                    ? AppTheme.theme.colorScheme
                        .primary //_getColorBySelectedOption(option)
                    : AppTheme.theme.colorScheme.onBackground),
            borderRadius: const BorderRadius.all(Radius.circular(4))),
        padding: Spacing.fromLTRB(0, 12, 0, 12),
        margin: Spacing.fromLTRB(48, 0, 48, 16),
        child: Center(
          child: CustomText.bodyLarge(option,
              color: _selectedOption == index
                  ? AppTheme.theme.colorScheme.onPrimary
                  : AppTheme.theme.colorScheme.onBackground,
              fontWeight: 600),
        ),
      ),
    );
  }
}
