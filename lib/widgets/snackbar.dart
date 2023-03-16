import 'package:face_to_face_voting/utils/spacing.dart';
import 'package:face_to_face_voting/widgets/text.dart';
import 'package:flutter/material.dart';

void showMessage(BuildContext context, String message,
        [bool isError = false]) =>
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: CustomText.bodyMedium(message),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: Spacing.all(16),
        margin: Spacing.all(16),
        behavior: SnackBarBehavior.floating,
        backgroundColor: isError
            ? Theme.of(context).colorScheme.error.withOpacity(0.8)
            : Theme.of(context).colorScheme.background,
        duration: const Duration(seconds: 3),
        showCloseIcon: true,
      ),
    );
