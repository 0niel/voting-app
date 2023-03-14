import 'package:face_to_face_voting/blocs/events/events_cubit.dart';
import 'package:face_to_face_voting/theme/app_theme.dart';
import 'package:face_to_face_voting/utils/spacing.dart';
import 'package:face_to_face_voting/widgets/button.dart';
import 'package:face_to_face_voting/widgets/text.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../blocs/profile/profile_cubit.dart';
import '../home.dart';
import 'login_screen.dart';

class LoginHomeScreen extends StatelessWidget {
  const LoginHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
            left: 20, right: 20, top: Spacing.safeAreaTop(context) + 48),
        child: Center(child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            state.whenOrNull(
              success: (user, prefs, jwt, avatar, _) {
                BlocProvider.of<EventsCubit>(context).started();
                WidgetsBinding.instance.addPostFrameCallback(
                  (_) => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                  ),
                );
              },
            );

            return state.maybeMap(
                initial: (_) => const _Loading(),
                loading: (_) => const _Loading(),
                error: (_) => _Failure(message: _.message),
                success: (value) => const _Loading(),
                orElse: () => const _Login());
          },
        )),
      ),
    );
  }
}

class _Loading extends StatelessWidget {
  const _Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class _Failure extends StatelessWidget {
  const _Failure({Key? key, required this.message}) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(bottom: 20),
          child: Image.asset('assets/logo2018.png', width: 99, height: 99),
        ),
        const Center(
          child: CustomText.headlineSmall("Ошибка", fontWeight: 700),
        ),
        Container(
          margin: const EdgeInsets.only(left: 48, right: 48, top: 20),
          child: CustomText.bodyLarge(
            "Произошла ошибка при загрузке данных",
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
              BlocProvider.of<ProfileCubit>(context).login();
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

class _Login extends StatelessWidget {
  const _Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
            "Войдите, используя данные Личного Кабинета Студента МИРЭА, чтобы продолжить",
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
              BlocProvider.of<ProfileCubit>(context).login();
            },
            child: Center(
              child: CustomText.bodyMedium(
                "ВОЙТИ",
                color: AppTheme.theme.colorScheme.onPrimary,
                letterSpacing: 0.8,
                fontWeight: 700,
              ),
            ),
          ),
        ),
        Spacing.height(20),
        Padding(
          padding: const EdgeInsets.only(left: 24, right: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.center,
                child: CustomButton.text(
                  padding: Spacing.zero,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  child: CustomText.bodyMedium(
                    "Я не студент",
                    color: AppTheme.theme.colorScheme.primary,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                child: CustomButton.text(
                  padding: Spacing.zero,
                  onPressed: () {
                    launchUrlString("https://lk.mirea.ru/forgot.php");
                  },
                  child: CustomText.bodyMedium(
                    "Забыли пароль?",
                    color: AppTheme.theme.colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
