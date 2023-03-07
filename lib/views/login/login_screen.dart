
import 'package:face_to_face_voting/theme/app_theme.dart';
import 'package:face_to_face_voting/theme/text_style.dart';
import 'package:face_to_face_voting/utils/spacing.dart';
import 'package:face_to_face_voting/widgets/button.dart';
import 'package:face_to_face_voting/widgets/text.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../blocs/profile/profile_bloc.dart';
import '../../utils/validators.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _showPassword = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.theme;
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return Scaffold(
            key: _scaffoldKey,
            body: Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Center(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    const Center(
                      child: CustomText.titleLarge("Welcome Back",
                          fontWeight: 600),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: TextFormField(
                        style: CustomTextStyle.bodyLarge(
                            letterSpacing: 0.1,
                            color: theme.colorScheme.onBackground,
                            fontWeight: 500),
                        decoration: InputDecoration(
                          hintText: "Email адрес",
                          hintStyle: CustomTextStyle.titleSmall(
                              letterSpacing: 0.1,
                              color: theme.colorScheme.onBackground,
                              fontWeight: 500),
                          border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                              borderSide: BorderSide.none),
                          enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                              borderSide: BorderSide.none),
                          focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                              borderSide: BorderSide.none),
                          filled: true,
                          fillColor: AppTheme.theme.colorScheme.surface,
                          prefixIcon: const Icon(
                            MdiIcons.emailOutline,
                            size: 22,
                          ),
                          isDense: true,
                          contentPadding: const EdgeInsets.all(0),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        textCapitalization: TextCapitalization.sentences,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: TextFormField(
                        autofocus: false,
                        obscureText: !_showPassword,
                        style: CustomTextStyle.bodyLarge(
                            letterSpacing: 0.1,
                            color: theme.colorScheme.onBackground,
                            fontWeight: 500),
                        decoration: InputDecoration(
                          hintStyle: CustomTextStyle.titleSmall(
                              letterSpacing: 0.1,
                              color: theme.colorScheme.onBackground,
                              fontWeight: 500),
                          hintText: "Пароль",
                          border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                              borderSide: BorderSide.none),
                          enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                              borderSide: BorderSide.none),
                          focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                              borderSide: BorderSide.none),
                          filled: true,
                          fillColor: theme.colorScheme.surface,
                          prefixIcon: const Icon(
                            MdiIcons.lockOutline,
                            size: 22,
                          ),
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                _showPassword = !_showPassword;
                              });
                            },
                            child: Icon(
                              _showPassword
                                  ? MdiIcons.eyeOutline
                                  : MdiIcons.eyeOffOutline,
                              size: 22,
                            ),
                          ),
                          isDense: true,
                          contentPadding: const EdgeInsets.all(0),
                        ),
                        textCapitalization: TextCapitalization.sentences,
                      ),
                    ),
                    Spacing.height(20),
                    Container(
                      alignment: Alignment.centerRight,
                      child: CustomButton.text(
                        padding: Spacing.zero,
                        onPressed: () {},
                        child: CustomText.bodyMedium(
                          "Забыли пароль?",
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ),
                    Spacing.height(20),
                    CustomButton.block(
                      elevation: 0,
                      borderRadiusAll: 4,
                      onPressed: () {
                        // BlocProvider.of<ProfileBloc>(context)
                        //     .add(const ProfileEvent.login(_e
                      },
                      child: CustomText.bodyMedium(
                        "Войти",
                        fontWeight: 600,
                        color: theme.colorScheme.onPrimary,
                      ),
                    ),
                    Spacing.height(20),
                    Center(
                      child: CustomButton.text(
                        elevation: 0,
                        borderRadiusAll: 4,
                        onPressed: () {},
                        child: CustomText.bodyMedium(
                          "Зарегистрироваться",
                          decoration: TextDecoration.underline,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }

  void showSnack(String message) {
    _scaffoldKey.currentState?.showSnackBar(SnackBar(
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomText.bodySmall(message),
      ),
      backgroundColor: AppTheme.theme.colorScheme.primary,
    ));
  }

  void loginUser() {
    final String email = _emailController.text;
    final String password = _passwordController.text;

    if (email.isEmpty) {
      showSnack("Пожалуйста, введите email");
      return;
    } else if (!StringValidator.isEmail(email)) {
      showSnack("Пожалуйста, введите корректный email");
      return;
    } else if (password.isEmpty) {
      showSnack("Пожалуйста, введите пароль");
      return;
    }
  }
}
