import 'package:face_to_face_voting/theme/app_theme.dart';
import 'package:face_to_face_voting/utils/spacing.dart';
import 'package:face_to_face_voting/widgets/button.dart';
import 'package:face_to_face_voting/widgets/text.dart';
import 'package:flutter/material.dart';

class Failure extends StatelessWidget {
  const Failure({
    Key? key,
    required this.message,
    required this.onRetry,
    this.showImage = true,
  }) : super(key: key);

  final String? message;
  final VoidCallback? onRetry;
  final bool showImage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        showImage
            ? Container(
                margin: const EdgeInsets.only(bottom: 20),
                child:
                    Image.asset('assets/logo2018.png', width: 99, height: 99),
              )
            : const SizedBox(
                height: 20,
              ),
        const Center(
          child: CustomText.headlineSmall("Ошибка", fontWeight: 700),
        ),
        Container(
          margin: const EdgeInsets.only(left: 48, right: 48, top: 20),
          child: CustomText.bodyLarge(
            "Произошла ошибка при загрузке данных:\n${message ?? ''}",
            softWrap: true,
            fontWeight: 500,
            height: 1.2,
            color: AppTheme.theme.colorScheme.onBackground.withAlpha(200),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 24, right: 24, top: 36),
          child: CustomButton(
            elevation: 0,
            padding: Spacing.y(12),
            borderRadiusAll: 4,
            onPressed: () {
              onRetry?.call();
            },
            child: Center(
              child: CustomText.bodyMedium(
                "ПОВТОРИТЬ",
                color: AppTheme.theme.colorScheme.onPrimary,
                letterSpacing: 0.8,
                fontWeight: 700,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
