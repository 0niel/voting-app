import 'package:face_to_face_voting/views/login/login_home_screen.dart';
import 'package:face_to_face_voting/widgets/button.dart';
import 'package:face_to_face_voting/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/user/user_cubit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<UserCubit, UserState>(builder: (context, state) {
          return state.maybeMap(
            success: (usrState) => RefreshIndicator(
              onRefresh: () async {
                context.read<UserCubit>().loadUser();
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 24, right: 24),
                child: ListView(
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
                          CustomText.headlineSmall(
                            usrState.user.name,
                            fontWeight: 700,
                            letterSpacing: 0,
                            color: Theme.of(context).primaryColor,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          CustomText.titleSmall(
                            usrState.prefs.data['academicGroup'] ??
                                "неизвестная группа",
                            fontWeight: 600,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 44,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const CustomText.titleMedium(
                          "Участник отчётно-выборочных мероприятий:",
                          letterSpacing: 0,
                          fontWeight: 700,
                        ),
                        if (usrState.events.isEmpty)
                          Container(
                            margin: const EdgeInsets.only(top: 8),
                            child: const CustomText.titleSmall(
                              "—",
                              letterSpacing: 0.1,
                              fontWeight: 500,
                              height: 1.3,
                            ),
                          ),
                        Container(
                          margin: const EdgeInsets.only(top: 8),
                          child: CustomText.titleSmall(
                              usrState.events.join("\n"),
                              letterSpacing: 0.1,
                              fontWeight: 500,
                              height: 1.3),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 48,
                    ),
                    CustomButton.rounded(
                      elevation: 0,
                      onPressed: () {
                        context.read<UserCubit>().logout();
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const LoginHomeScreen()));
                      },
                      child: const CustomText.titleSmall(
                        "Выйти",
                        color: Colors.white,
                        fontWeight: 700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            orElse: () => const Center(child: CircularProgressIndicator()),
          );
        }),
      ),
    );
  }
}
