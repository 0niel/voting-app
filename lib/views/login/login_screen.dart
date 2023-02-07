import 'package:face_to_face_voting/service_locator.dart';
import 'package:face_to_face_voting/theme/app_theme.dart';
import 'package:face_to_face_voting/utils/spacing.dart';
import 'package:face_to_face_voting/views/home.dart';
import 'package:face_to_face_voting/widgets/button.dart';
import 'package:face_to_face_voting/widgets/text.dart';
import 'package:flutter/material.dart';

import 'package:appwrite/appwrite.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final Account account = Account(getIt<Client>());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: Spacing.top(Spacing.safeAreaTop(context) + 48),
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: Image.asset('assets/logo2018.png', width: 99, height: 99),
            ),
            const Center(
              child: CustomText.headlineSmall("Вход", fontWeight: 700),
            ),
            Container(
              margin: const EdgeInsets.only(left: 48, right: 48, top: 20),
              child: CustomText.bodyLarge(
                "Введите ваши данные от Личного Кабинета Студента МИРЭА, чтобы продолжить",
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
                  Future result = account.createOAuth2Session(
                    provider: 'mirea',
                  );

                  result.then((response) {
                    print(response);
                  }).catchError((error) {
                    print(error.response);
                  });
                },
                child: Center(
                  child: CustomText.bodyMedium("ВОЙТИ",
                      color: AppTheme.theme.colorScheme.onPrimary,
                      letterSpacing: 0.8,
                      fontWeight: 700),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
