import 'package:face_to_face_voting/blocs/events/events_cubit.dart';
import 'package:face_to_face_voting/blocs/participants/participants_cubit.dart';
import 'package:face_to_face_voting/blocs/search_users/search_users_cubit.dart';
import 'package:face_to_face_voting/theme/text_style.dart';
import 'package:face_to_face_voting/utils/spacing.dart';
import 'package:face_to_face_voting/widgets/button.dart';
import 'package:face_to_face_voting/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class SearchUsersScreen extends StatelessWidget {
  SearchUsersScreen({Key? key}) : super(key: key);

  final FloatingSearchBarController _controller = FloatingSearchBarController();

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: CustomText.bodyMedium(message),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: Spacing.all(16),
        margin: Spacing.all(16),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Theme.of(context).colorScheme.background,
        duration: const Duration(seconds: 3),
        showCloseIcon: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final eventBloc = BlocProvider.of<EventsCubit>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: BlocListener<ParticipantsCubit, ParticipantsState>(
          listener: (context, state) {
            state.maybeWhen(
              orElse: () {},
              error: (message) {
                _showMessage(context, message);
              },
            );
          },
          child: Padding(
            padding: Spacing.all(16),
            child: FloatingSearchBar(
              controller: _controller,
              hint: 'Введите ФИО',
              hintStyle: theme.textTheme.bodyMedium,
              backgroundColor: theme.colorScheme.background,
              shadowColor: Colors.transparent,
              backdropColor: Colors.transparent,
              border: BorderSide(
                color: theme.colorScheme.onBackground.withOpacity(0.2),
                width: 1,
              ),
              scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
              transitionDuration: const Duration(milliseconds: 400),
              transitionCurve: Curves.easeInOut,
              physics: const BouncingScrollPhysics(),
              openAxisAlignment: 0.0,
              debounceDelay: const Duration(milliseconds: 300),
              onQueryChanged: (query) {
                eventBloc.state.maybeWhen(
                  orElse: () {},
                  eventLoaded: (event, _) {
                    if (query.isEmpty || query.length < 3) return;

                    BlocProvider.of<SearchUsersCubit>(context).searchUsers(
                      event,
                      query,
                    );
                  },
                );
              },
              transition: CircularFloatingSearchBarTransition(),
              iconColor: theme.colorScheme.onBackground,
              actions: [
                FloatingSearchBarAction(
                  showIfOpened: false,
                  child: CircularButton(
                    icon: const Icon(FeatherIcons.search),
                    onPressed: () {},
                  ),
                ),
              ],
              body: BlocBuilder<SearchUsersCubit, SearchUsersState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    initial: () => Column(
                      children: const [
                        Spacer(),
                        Center(
                          child: Icon(
                            FeatherIcons.search,
                            size: 64,
                          ),
                        ),
                        SizedBox(height: 16),
                        CustomText.bodyMedium(
                          'Тут появятся результаты поиска',
                          textAlign: TextAlign.center,
                        ),
                        Spacer(),
                      ],
                    ),
                    orElse: () => const SizedBox(),
                  );
                },
              ),
              builder: (context, transition) {
                return BlocBuilder<SearchUsersCubit, SearchUsersState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      loaded: (users) {
                        return ListView.separated(
                          shrinkWrap: true,
                          itemCount: users.length,
                          itemBuilder: (context, index) {
                            final user = users[index].key;
                            final isParticipant = users[index].value;

                            return ListTile(
                              title: CustomText.bodyMedium(
                                user.name +
                                    (user.prefs.containsKey('academicGroup')
                                        ? ' (${user.prefs['academicGroup']})'
                                        : ''),
                                fontWeight: 600,
                              ),
                              subtitle: CustomText.bodySmall(
                                user.email,
                              ),
                              trailing: isParticipant
                                  ? CustomButton.outlined(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      onPressed: () {
                                        eventBloc.state.maybeWhen(
                                          orElse: () {
                                            _showMessage(
                                              context,
                                              'Невозможно удалить участника',
                                            );
                                          },
                                          eventLoaded: (event, _) {
                                            BlocProvider.of<ParticipantsCubit>(
                                                    context)
                                                .removeParticipant(
                                                    event.$id, user.id);

                                            _showMessage(
                                              context,
                                              'Участник удален',
                                            );

                                            _controller.clear();
                                            _controller.close();
                                          },
                                        );
                                      },
                                      borderColor: theme.colorScheme.error,
                                      child: CustomText.bodySmall(
                                        'Удалить',
                                        color: theme.colorScheme.error,
                                      ),
                                    )
                                  : CustomButton.outlined(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      onPressed: () {
                                        eventBloc.state.maybeWhen(
                                          orElse: () {
                                            _showMessage(
                                              context,
                                              'Невозможно добавить участника',
                                            );
                                          },
                                          eventLoaded: (event, _) {
                                            BlocProvider.of<ParticipantsCubit>(
                                                    context)
                                                .addParticipant(
                                                    event.$id, user.id);

                                            _showMessage(
                                              context,
                                              'Участник добавлен',
                                            );

                                            _controller.clear();
                                            _controller.close();
                                          },
                                        );
                                      },
                                      borderColor: theme.colorScheme.primary,
                                      child: CustomText.bodySmall(
                                        'Добавить',
                                        color: theme.colorScheme.primary,
                                      ),
                                    ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const Divider();
                          },
                        );
                      },
                      error: (error) {
                        return Center(
                          child: Text(
                            error,
                            style: theme.textTheme.bodySmall,
                          ),
                        );
                      },
                      orElse: () => const SizedBox(),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
