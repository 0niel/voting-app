import 'package:face_to_face_voting/blocs/events/events_cubit.dart';
import 'package:face_to_face_voting/theme/app_theme.dart';
import 'package:face_to_face_voting/theme/text_style.dart';
import 'package:face_to_face_voting/utils/spacing.dart';
import 'package:face_to_face_voting/views/home.dart';
import 'package:face_to_face_voting/widgets/button.dart';
import 'package:face_to_face_voting/widgets/container.dart';
import 'package:face_to_face_voting/widgets/text.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/profile/profile_cubit.dart';
import '../../utils/validators.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _showPassword = false;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordRepeatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        state.maybeWhen(
          error: (message) {
            showSnack(message);
          },
          success: (user, prefs, jwt, avatar, _) {
            BlocProvider.of<EventsCubit>(context).started();
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                  (route) => false);
            });
          },
          orElse: () {},
        );
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: theme.colorScheme.background,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              color: theme.colorScheme.onBackground,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: SafeArea(
            child: Container(
              margin: Spacing.top(Spacing.safeAreaTop(context) + 48),
              child: ListView(
                shrinkWrap: true,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Image.asset('assets/logo2018.png',
                        width: 99, height: 99),
                  ),
                  const Center(
                    child: CustomText.headlineSmall("Регистрация",
                        fontWeight: 700),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 48, right: 48, top: 20),
                    child: CustomText.bodyLarge(
                      "",
                      softWrap: true,
                      fontWeight: 500,
                      height: 1.2,
                      color: AppTheme.theme.colorScheme.onBackground
                          .withAlpha(200),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 24, right: 24),
                    child: CustomText.bodySmall(
                      "Введённое вами ФИО будет отображаться у модераторов доступа",
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 24, right: 24, top: 36),
                    child: CustomContainer(
                      paddingAll: 0,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: _nameController,
                            style: CustomTextStyle.bodyLarge(
                                fontWeight: 600, letterSpacing: 0.2),
                            decoration: InputDecoration(
                              hintStyle: CustomTextStyle.bodyLarge(
                                  fontWeight: 500,
                                  letterSpacing: 0,
                                  color: AppTheme.theme.colorScheme.onBackground
                                      .withAlpha(180)),
                              hintText: "ФИО",
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              isDense: true,
                              contentPadding: const EdgeInsets.all(16),
                            ),
                            autofocus: false,
                            keyboardType: TextInputType.name,
                          ),
                          Divider(
                            color: AppTheme.theme.dividerColor,
                            height: 0.5,
                          ),
                          TextFormField(
                            controller: _emailController,
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
                          TextFormField(
                            controller: _passwordController,
                            style: CustomTextStyle.bodyLarge(
                                fontWeight: 600, letterSpacing: 0.2),
                            decoration: InputDecoration(
                              hintStyle: CustomTextStyle.bodyLarge(
                                  fontWeight: 500,
                                  letterSpacing: 0,
                                  color: AppTheme.theme.colorScheme.onBackground
                                      .withAlpha(180)),
                              hintText: "Пароль",
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              isDense: true,
                              contentPadding: const EdgeInsets.all(16),
                            ),
                            autofocus: false,
                            textInputAction: TextInputAction.search,
                            textCapitalization: TextCapitalization.sentences,
                            obscureText: _showPassword,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _passwordRepeatController,
                                  style: CustomTextStyle.bodyLarge(
                                      fontWeight: 600, letterSpacing: 0.2),
                                  decoration: InputDecoration(
                                    hintStyle: CustomTextStyle.bodyLarge(
                                        fontWeight: 500,
                                        letterSpacing: 0,
                                        color: AppTheme
                                            .theme.colorScheme.onBackground
                                            .withAlpha(180)),
                                    hintText: "Повторите пароль",
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    isDense: true,
                                    contentPadding: const EdgeInsets.all(16),
                                  ),
                                  autofocus: false,
                                  textInputAction: TextInputAction.search,
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  obscureText: _showPassword,
                                ),
                              ),
                              CustomButton.text(
                                onPressed: () {
                                  setState(() {
                                    _showPassword = !_showPassword;
                                  });
                                },
                                child: CustomText.bodyMedium(
                                  _showPassword ? "ПОКАЗАТь" : "СКРЫТЬ",
                                  letterSpacing: 0.5,
                                  color: AppTheme.theme.colorScheme.onBackground
                                      .withAlpha(140),
                                  fontWeight: 700,
                                ),
                              )
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
                        registerUser();
                      },
                      child: Center(
                        child: CustomText.bodyMedium(
                          "ЗАРЕГИСТРИРОВАТЬСЯ",
                          color: AppTheme.theme.colorScheme.onPrimary,
                          letterSpacing: 0.8,
                          fontWeight: 700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void showSnack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),
        content: CustomText.bodyMedium("Ошибка: $message", fontWeight: 700),
        backgroundColor: AppTheme.theme.colorScheme.error.withOpacity(0.8),
      ),
    );
  }

  void registerUser() {
    final String name = _nameController.text;
    final String email = _emailController.text;
    final String password = _passwordController.text;
    final String repeatPassword = _passwordRepeatController.text;

    if (email.isEmpty) {
      showSnack("Пожалуйста, введите email");
      return;
    } else if (!StringValidator.isEmail(email)) {
      showSnack("Пожалуйста, введите корректный email");
      return;
    } else if (password.isEmpty) {
      showSnack("Пожалуйста, введите пароль");
      return;
    } else if (password.length < 8) {
      showSnack("Пароль должен быть не менее 8 символов");
      return;
    } else if (password != repeatPassword) {
      showSnack("Пароли не совпадают");
      return;
    } else if (name.isEmpty) {
      showSnack("Пожалуйста, введите ваше ФИО");
      return;
    }

    BlocProvider.of<ProfileCubit>(context)
        .register(name: name, email: email, password: password);
  }
}
