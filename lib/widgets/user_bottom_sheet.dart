import 'package:appwrite/models.dart';
import 'package:face_to_face_voting/blocs/participants/participants_cubit.dart';
import 'package:face_to_face_voting/blocs/search_users/search_users_cubit.dart';
import 'package:face_to_face_voting/theme/app_theme.dart';
import 'package:face_to_face_voting/utils/spacing.dart';
import 'package:face_to_face_voting/widgets/button.dart';
import 'package:face_to_face_voting/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScannedBottomSheet extends StatelessWidget {
  static Future<void> show(
      BuildContext context, Document event, String userId) async {
    BlocProvider.of<SearchUsersCubit>(context).getUser(event, userId);
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      isScrollControlled: true,
      builder: (context) => ScannedBottomSheet(
        event: event,
        userId: userId,
      ),
    );
  }

  const ScannedBottomSheet(
      {Key? key, required this.event, required this.userId})
      : super(key: key);

  final String userId;
  final Document event;

  @override
  Widget build(BuildContext context) {
    final searchBloc = context.read<SearchUsersCubit>();
    final participantsBloc = context.read<ParticipantsCubit>();

    return Container(
      color: Colors.transparent,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: AppTheme.theme.colorScheme.background,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Padding(
          padding: Spacing.all(16),
          child: BlocBuilder<SearchUsersCubit, SearchUsersState>(
            builder: (context, state) {
              return state.maybeWhen(
                loading: () => const Center(child: CircularProgressIndicator()),
                loadedUser: (user, avatar) => Column(
                  children: [
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: avatar,
                      ),
                    ),
                    const SizedBox(height: 20),
                    CustomText.headlineSmall(user.key.name,
                        fontWeight: 700, textAlign: TextAlign.center),
                    const SizedBox(height: 20),
                    CustomText.titleSmall(
                        user.key.prefs.containsKey('academicGroup')
                            ? user.key.prefs['academicGroup']
                            : "У пользователя нет группы"),
                    const SizedBox(height: 20),
                    Container(
                      padding: Spacing.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: user.value
                              ? AppTheme.theme.colorScheme.primary
                              : AppTheme.theme.colorScheme.error,
                        ),
                      ),
                      child: CustomText.bodySmall(
                          user.value ? "Участник мероприятия" : "Не участник"),
                    ),
                    const SizedBox(height: 28),
                    user.value
                        ? CustomButton.rounded(
                            padding: Spacing.fromLTRB(24, 12, 24, 12),
                            elevation: 0,
                            backgroundColor: AppTheme.theme.colorScheme.error
                                .withOpacity(0.8),
                            borderRadiusAll: 8,
                            onPressed: () {
                              participantsBloc
                                  .removeParticipant(event.$id, userId)
                                  .then((value) {
                                searchBloc.getUser(event, userId);
                              });
                            },
                            child: const CustomText.bodyLarge(
                              "Удалить из участников",
                              color: Colors.white,
                              fontWeight: 700,
                            ),
                          )
                        : CustomButton.rounded(
                            padding: Spacing.fromLTRB(24, 12, 24, 12),
                            elevation: 0,
                            backgroundColor: AppTheme.theme.colorScheme.primary,
                            borderRadiusAll: 8,
                            onPressed: () {
                              participantsBloc
                                  .addParticipant(event.$id, userId)
                                  .then((value) {
                                searchBloc.getUser(event, userId);
                              });
                            },
                            child: const CustomText.bodyLarge(
                              "Добавить в участники",
                              color: Colors.white,
                              fontWeight: 700,
                            ),
                          ),
                  ],
                ),
                orElse: () => const Center(child: CircularProgressIndicator()),
              );
            },
          ),
        ),
      ),
    );
  }
}
