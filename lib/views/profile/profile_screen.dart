import 'package:face_to_face_voting/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/profile/profile_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  final String _aboutText =
      "\u2022 Отчётно-выборная Конференция Института тонких химических\n\u2022 Отчётно-выборная Конференция Института информационных технологий";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
        return state.maybeMap(
          success: (usrState) => ListView(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 24),
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      width: 140,
                      height: 140,
                      child: CircleAvatar(
                        radius: 50,
                        child: ClipOval(
                          child: usrState.avatar,
                        ),
                      ),
                    ),
                    CustomText.headlineSmall(usrState.user.name,
                        fontWeight: 700, letterSpacing: 0),
                    CustomText.titleSmall(
                      usrState.prefs.data['academicGroup'] ??
                          "неизвестная группа",
                      fontWeight: 600,
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Container(
                  margin: const EdgeInsets.only(left: 24, right: 24, top: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const CustomText.titleMedium(
                          "Пройденные отчётно-выборочные мероприятия",
                          letterSpacing: 0,
                          fontWeight: 700),
                      Container(
                        margin: const EdgeInsets.only(top: 8),
                        child: CustomText.titleSmall(_aboutText,
                            letterSpacing: 0.1, fontWeight: 500, height: 1.3),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          orElse: () => const Center(child: CircularProgressIndicator()),
        );
      }),
    );
  }
}
