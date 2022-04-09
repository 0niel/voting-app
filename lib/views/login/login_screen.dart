import 'package:face_to_face_voting/theme/app_theme.dart';
import 'package:face_to_face_voting/theme/text_style.dart';
import 'package:face_to_face_voting/utils/spacing.dart';
import 'package:face_to_face_voting/views/home.dart';
import 'package:face_to_face_voting/widgets/button.dart';
import 'package:face_to_face_voting/widgets/container.dart';
import 'package:face_to_face_voting/widgets/text.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

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
            Center(
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
              child: CustomContainer(
                paddingAll: 0,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      style: CustomTextStyle.bodyLarge(
                          fontWeight: 600, letterSpacing: 0.2),
                      decoration: InputDecoration(
                        hintStyle: CustomTextStyle.bodyLarge(
                            fontWeight: 500,
                            letterSpacing: 0,
                            color: AppTheme.theme.colorScheme.onBackground
                                .withAlpha(180)),
                        hintText: "Email",
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        isDense: true,
                        contentPadding: const EdgeInsets.all(16),
                      ),
                      autofocus: false,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    Divider(
                      color: AppTheme.theme.dividerColor,
                      height: 0.5,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: TextFormField(
                            style: CustomTextStyle.bodyLarge(
                                fontWeight: 600, letterSpacing: 0.2),
                            decoration: InputDecoration(
                              hintStyle: CustomTextStyle.bodyLarge(
                                  fontWeight: 500,
                                  letterSpacing: 0,
                                  color: AppTheme.theme.colorScheme.onBackground
                                      .withAlpha(180)),
                              hintText: "Ваш пароль",
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              isDense: true,
                              contentPadding: const EdgeInsets.all(16),
                            ),
                            autofocus: false,
                            textInputAction: TextInputAction.search,
                            textCapitalization: TextCapitalization.sentences,
                            obscureText: true,
                          ),
                        ),
                        CustomButton.text(
                            onPressed: () {},
                            child: CustomText.bodyMedium("ПОКАЗАТь",
                                letterSpacing: 0.5,
                                color: AppTheme.theme.colorScheme.onBackground
                                    .withAlpha(140),
                                fontWeight: 700))
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 24, right: 24, top: 36),
              child: CustomButton(
                elevation: 0,
                padding: Spacing.y(12),
                borderRadiusAll: 4,
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => const HomeScreen()));
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
