import 'dart:async';

import 'package:face_to_face_voting/theme/app_theme.dart';
import 'package:face_to_face_voting/utils/spacing.dart';
import 'package:face_to_face_voting/views/profile/profile_screen.dart';
import 'package:face_to_face_voting/views/qrcode/qrcode_screen.dart';
import 'package:face_to_face_voting/views/quiz/quiz_screen.dart';
import 'package:face_to_face_voting/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:screen_brightness/screen_brightness.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  final ValueNotifier<int> value = ValueNotifier<int>(30);
  int _currentScreen = 1;
  final _screens = const [
    QrCodeScreen(),
    QuizQuestionScreen(),
    ProfileScreen()
  ];

  int quizTimeSecond = 30;
  double remainingSecond = 30;

  Timer? _timer;

  Future<void> resetBrightness() async {
    try {
      return await ScreenBrightness().resetScreenBrightness();
    } catch (e) {
      return;
    }
  }

  Future<void> setBrightness(double brightness) async {
    try {
      await ScreenBrightness().setScreenBrightness(brightness);
    } catch (e) {
      return;
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null) _timer!.cancel();
  }

  void startTimer() {
    _timer = Timer.periodic(
      const Duration(milliseconds: 200),
      (Timer timer) => {
        setState(() {
          if (remainingSecond > 0.200) {
            remainingSecond = remainingSecond - 0.200;
          } else {
            remainingSecond = 0;
            timer.cancel();
          }
        })
      },
    );
  }

  void _changeCurrentScreen(int page) {
    if (page == 0) {
      setBrightness(1.0);
    } else {
      resetBrightness();
    }

    setState(() {
      _currentScreen = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          Expanded(
            child: _screens[_currentScreen],
          ),
          Container(
            color: AppTheme.theme.cardColor,
            padding: Spacing.fromLTRB(32, 16, 32, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                InkWell(
                  onTap: () => _changeCurrentScreen(0),
                  child: Icon(
                    MdiIcons.qrcode,
                    color: _currentScreen == 0
                        ? AppTheme.theme.colorScheme.primary
                        : AppTheme.theme.colorScheme.onBackground,
                    size: 26,
                  ),
                ),
                _currentScreen != 1
                    ? SizedBox(
                        width: 48,
                        height: 48,
                        child: InkWell(
                          onTap: () => _changeCurrentScreen(1),
                          child: Icon(
                            MdiIcons.vote,
                            color: AppTheme.theme.colorScheme.onBackground,
                            size: 26,
                          ),
                        ),
                      )
                    : Expanded(
                        child: Center(
                          child: buildTimer(),
                        ),
                      ),
                InkWell(
                  onTap: () => _changeCurrentScreen(2),
                  child: Icon(
                    MdiIcons.account,
                    color: _currentScreen == 2
                        ? AppTheme.theme.colorScheme.primary
                        : AppTheme.theme.colorScheme.onBackground,
                    size: 26,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildTimer() {
    return SizedBox(
      width: 48,
      height: 48,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          CircularProgressIndicator(
            valueColor: remainingSecond > 5
                ? AlwaysStoppedAnimation<Color>(
                    AppTheme.theme.colorScheme.primary,
                  )
                : AlwaysStoppedAnimation<Color>(
                    AppTheme.theme.errorColor,
                  ),
            value: (quizTimeSecond - remainingSecond) / quizTimeSecond,
          ),
          CustomText.bodyLarge(remainingSecond.ceil().toString(),
              color: AppTheme.theme.colorScheme.onBackground, fontWeight: 600)
        ],
      ),
    );
  }
}
