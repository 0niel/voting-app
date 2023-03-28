import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:face_to_face_voting/widgets/text.dart';
import 'package:face_to_face_voting/theme/app_theme.dart';
import 'container.dart';

class VotesBanner extends StatelessWidget {
  const VotesBanner({
    Key? key,
    required this.votes,
    required this.showOnlyVotersCount,
    required this.isFinished,
  }) : super(key: key);

  final Map<String, int> votes;
  final bool showOnlyVotersCount;
  final bool isFinished;

  double _computeMaxCardOnScreenWidth(BuildContext context, int votesCount) {
    final constraints = BoxConstraints(
      maxWidth: MediaQuery.of(context).size.width,
    );
    // Аналог Expanded в Row
    return constraints.maxWidth / 3 - 24;
  }

  double _computeMaxCardHeightByText(double width, List<String> text) {
    double maxTextHeight = 0.0;

    // Создаем ParagraphBuilder для каждой строки текста и определяем ее размер
    for (String t in text) {
      double textHeight = 0.0;

      ui.ParagraphBuilder paragraphBuilder = ui.ParagraphBuilder(
        ui.ParagraphStyle(textAlign: TextAlign.center, fontSize: 12),
      )
        ..pushStyle(ui.TextStyle(fontSize: 12))
        ..addText(t);

      ui.ParagraphConstraints paragraphConstraints =
          ui.ParagraphConstraints(width: width - 32);

      ui.Paragraph paragraph = paragraphBuilder.build()
        ..layout(paragraphConstraints);

      textHeight = paragraph.height;

      if (textHeight > maxTextHeight) {
        maxTextHeight = textHeight;
      }
    }

    return maxTextHeight + 56;
  }

  @override
  Widget build(BuildContext context) {
    if (!isFinished && showOnlyVotersCount) {
      return CustomContainer.bordered(
        width: _computeMaxCardOnScreenWidth(context, votes.length),
        borderRadiusAll: 4,
        margin: const EdgeInsets.only(left: 12, right: 12),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CustomText.titleMedium(
              votes.values.isNotEmpty
                  ? votes.values
                      .reduce((value, element) => value + element)
                      .toString()
                  : "0",
              color: AppTheme.theme.colorScheme.primary,
              fontWeight: 700,
            ),
            Container(
              margin: const EdgeInsets.only(top: 4),
              child: const CustomText.labelSmall(
                "Голосов",
                fontWeight: 600,
                letterSpacing: 0.2,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      );
    } else {
      return SizedBox(
        height: _computeMaxCardHeightByText(
              _computeMaxCardOnScreenWidth(context, votes.length),
              votes.keys.toList(),
            ) +
            10,
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: votes.entries
              .map(
                (e) => CustomContainer.bordered(
                  width: _computeMaxCardOnScreenWidth(context, votes.length),
                  borderRadiusAll: 4,
                  margin: const EdgeInsets.only(left: 12, right: 12),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      CustomText.titleMedium(
                        e.value.toString(),
                        color: AppTheme.theme.colorScheme.primary,
                        fontWeight: 700,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        child: CustomText.labelSmall(
                          e.key,
                          fontWeight: 600,
                          letterSpacing: 0.2,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      );
    }
  }
}
