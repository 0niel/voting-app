import 'package:face_to_face_voting/blocs/events/events_cubit.dart';
import 'package:face_to_face_voting/blocs/participants/participants_cubit.dart';
import 'package:face_to_face_voting/theme/app_theme.dart';
import 'package:face_to_face_voting/utils/formatters.dart';
import 'package:face_to_face_voting/utils/spacing.dart';
import 'package:face_to_face_voting/views/qr_scanner/qr_scanner_screen.dart';
import 'package:face_to_face_voting/views/search_users/search_users_screen.dart';
import 'package:face_to_face_voting/widgets/text.dart';
import 'package:face_to_face_voting/widgets/user_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'button.dart';

class _ParticipantsBottomSheet extends StatelessWidget {
  const _ParticipantsBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          child: Column(
            children: [
              Padding(
                padding: Spacing.horizontal(16),
                child: Row(children: [
                  BlocBuilder<ParticipantsCubit, ParticipantsState>(
                    builder: (context, state) {
                      return state.maybeMap(
                        loaded: (state) => CustomText.titleMedium(
                          "Участники (${state.participants.length})",
                          fontWeight: 700,
                        ),
                        orElse: () => const CustomText.titleMedium(
                          "Участники",
                          fontWeight: 700,
                        ),
                      );
                    },
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      CustomButton.text(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => SearchUsersScreen(),
                            ),
                          );
                        },
                        backgroundColor: AppTheme.theme.colorScheme.primary,
                        padding: Spacing.symmetric(vertical: 8, horizontal: 16),
                        child: Row(
                          children: const [
                            Icon(
                              MdiIcons.accountSearch,
                            ),
                            SizedBox(width: 8),
                            CustomText.bodySmall(
                              "Поиск",
                              fontWeight: 700,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
              Expanded(
                child: Container(
                  margin: Spacing.top(16),
                  child: BlocBuilder<EventsCubit, EventsState>(
                    builder: (context, state) {
                      return state.maybeMap(
                        eventLoaded: (eventState) {
                          context
                              .read<ParticipantsCubit>()
                              .load(eventState.event.$id);
                          return BlocBuilder<ParticipantsCubit,
                              ParticipantsState>(
                            builder: (context, state) {
                              return state.maybeMap(
                                loaded: (state) {
                                  return ListView.separated(
                                    separatorBuilder: (context, index) =>
                                        const Divider(),
                                    shrinkWrap: true,
                                    itemCount: state.participants.length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        trailing: CustomButton.outlined(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 4,
                                          ),
                                          onPressed: () {
                                            ScannedBottomSheet.show(
                                                context,
                                                eventState.event,
                                                state.participants[index]
                                                    .userId);
                                          },
                                          borderColor: AppTheme
                                              .theme.colorScheme.primary,
                                          child: CustomText.bodySmall(
                                            'Открыть',
                                            color: AppTheme
                                                .theme.colorScheme.primary,
                                          ),
                                        ),
                                        title: CustomText.bodySmall(
                                          state.participants[index].userName,
                                          fontWeight: 700,
                                        ),
                                        subtitle: CustomText.bodySmall(
                                          "Был приглашён: ${StringFormatter.formatDateTime(state.participants[index].joined)}\n"
                                          "Роли: ${state.participants[index].roles.map((e) => e).join(", ")}",
                                          fontWeight: 500,
                                        ),
                                      );
                                    },
                                  );
                                },
                                orElse: () => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            },
                          );
                        },
                        orElse: () => Center(
                          child: Column(
                            children: const [
                              CustomText.bodySmall(
                                "Для просмотра участников необходимо дождаться, пока начнется мероприятие",
                                fontWeight: 500,
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class QuickActionBottomSheet {
  static void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext buildContext) {
        return Container(
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
                color: AppTheme.theme.colorScheme.background,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16))),
            child: Padding(
              padding: Spacing.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const CustomText.titleMedium("Быстрые действия",
                      fontWeight: 700),
                  Container(
                    margin: Spacing.top(16),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: [
                            Expanded(
                              child: QuickActionWidget(
                                iconData: Icons.qr_code,
                                actionText: 'Сканировать',
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => QrScannerScreen(),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Expanded(
                              child: QuickActionWidget(
                                iconData: Icons.people,
                                actionText: 'Участники',
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    builder: (BuildContext buildContext) {
                                      return const _ParticipantsBottomSheet();
                                    },
                                  );
                                },
                              ),
                            ),
                            // const Expanded(
                            //   child: QuickActionWidget(
                            //     iconData: MdiIcons.vote,
                            //     actionText: 'Голосование',
                            //   ),
                            // ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class QuickActionWidget extends StatelessWidget {
  final IconData iconData;
  final String actionText;
  final VoidCallback? onTap;

  const QuickActionWidget(
      {Key? key, required this.iconData, required this.actionText, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: Spacing.y(12),
      child: Column(
        children: <Widget>[
          ClipOval(
            child: Material(
              color: AppTheme.theme.colorScheme.primary.withAlpha(20),
              // button color
              child: InkWell(
                splashColor: AppTheme.theme.colorScheme.primary.withAlpha(100),
                highlightColor: Colors.transparent,
                onTap: onTap,
                child: SizedBox(
                  width: 52,
                  height: 52,
                  child: Icon(
                    iconData,
                    color: AppTheme.theme.colorScheme.primary,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: Spacing.top(4),
            child: CustomText.bodySmall(actionText, fontWeight: 600),
          )
        ],
      ),
    );
  }
}
