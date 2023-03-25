import 'package:face_to_face_voting/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:face_to_face_voting/widgets/text.dart';
import 'package:face_to_face_voting/theme/app_theme.dart';
import 'container.dart';

class VotesBanner extends StatelessWidget {
  const VotesBanner({Key? key, required this.votes}) : super(key: key);

  final Map<String, int> votes;

  double _computeMaxCardOnScreenWidth(BuildContext context, int votesCount) {
    final constraints = BoxConstraints(
      maxWidth: MediaQuery.of(context).size.width,
    );
    // Аналог Expanded в Row
    return constraints.maxWidth / 3 - 24;
  }

  double _computeMaxCardHeightByText(double width, String text) {
    final constraints = BoxConstraints(
      maxWidth: width,
    );

    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: AppTheme.theme.textTheme.labelSmall?.copyWith(
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    final numberTextPainter = TextPainter(
      text: TextSpan(
        text: '123',
        style: AppTheme.theme.textTheme.titleMedium?.copyWith(
          color: AppTheme.theme.colorScheme.primary,
          fontWeight: FontWeight.w700,
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(maxWidth: constraints.maxWidth);
    numberTextPainter.layout(maxWidth: constraints.maxWidth);

    return numberTextPainter.height + textPainter.height + 48;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _computeMaxCardHeightByText(
          _computeMaxCardOnScreenWidth(context, votes.length),
          // Поиск варианта ответа с с максимальной длиной текста
          votes.keys.reduce((value, element) =>
              value.length > element.length ? value : element)),
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
