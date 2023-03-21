import 'package:appwrite/models.dart';
import 'package:collection/collection.dart';
import 'package:face_to_face_voting/blocs/events/events_cubit.dart';
import 'package:face_to_face_voting/blocs/poll/poll_cubit.dart';
import 'package:face_to_face_voting/blocs/user/user_cubit.dart';
import 'package:face_to_face_voting/theme/app_theme.dart';
import 'package:face_to_face_voting/utils/spacing.dart';
import 'package:face_to_face_voting/widgets/button.dart';
import 'package:face_to_face_voting/widgets/failure.dart';
import 'package:face_to_face_voting/widgets/text.dart';
import 'package:face_to_face_voting/widgets/votes_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class PollScreen extends StatefulWidget {
  const PollScreen({Key? key}) : super(key: key);

  @override
  _PollScreenState createState() => _PollScreenState();
}

class _PollScreenState extends State<PollScreen> {
  bool _isFirstBuild = true;

  @override
  void initState() {
    super.initState();
    _selectedOption = ValueNotifier<int?>(-1);
  }

  late final ValueNotifier<int?> _selectedOption;

  void _setMyVote(String meId, List<Document> votes, List<String> options) {
    if (!_isFirstBuild) {
      return;
    }

    final String? myVote;
    final myVoteDoc =
        votes.firstWhereOrNull((doc) => doc.data['voter_id'] == meId);
    if (myVoteDoc != null) {
      myVote = myVoteDoc.data['vote'] as String;
    } else {
      myVote = null;
    }

    final index = options.indexWhere((element) => element == myVote);
    if (index != -1 && index != _selectedOption.value) {
      _selectedOption.value = index;
    }

    _isFirstBuild = false;
  }

  Map<String, int> _getVotes(List<Document> votes) {
    final votesMap = votes.fold<Map<String, int>>({}, (map, doc) {
      final vote = doc.data['vote'] as String;
      return map..update(vote, (count) => count + 1, ifAbsent: () => 1);
    });

    return votesMap;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, UserState) {
          return UserState.maybeMap(
            orElse: () => Container(),
            error: (value) {
              return Failure(
                message: value.message,
                onRetry: () {
                  BlocProvider.of<UserCubit>(context).login();
                },
              );
            },
            success: (user) {
              final me = user.user;

              return BlocConsumer<EventsCubit, EventsState>(
                listener: (context, state) {
                  state.maybeWhen(
                    orElse: () {},
                    eventLoaded: (events, isAcessModerator) {
                      BlocProvider.of<PollCubit>(context).loadPolls(events.$id);
                    },
                  );
                },
                builder: (context, state) {
                  return state.maybeMap(
                    eventLoaded: (eventLoadedStateValue) =>
                        BlocBuilder<PollCubit, PollState>(
                      builder: (context, pollState) {
                        final eventName =
                            eventLoadedStateValue.event.data['name'];
                        return RefreshIndicator(
                          onRefresh: () async {
                            BlocProvider.of<PollCubit>(context)
                                .loadPolls(eventLoadedStateValue.event.$id);
                          },
                          child: pollState.maybeWhen(
                            success:
                                (eventId, poll, votes, timeLeft, timeMaximum) {
                              final question = poll.data['question'] as String;
                              final options =
                                  List<String>.from(poll.data['poll_options']);

                              _setMyVote(me.$id, votes, options);

                              return _Poll(
                                eventName: eventName,
                                question: question,
                                options: options,
                                votes: _getVotes(votes),
                                isActive: (timeLeft.isNegative ||
                                        timeLeft.inSeconds == 0)
                                    ? false
                                    : true,
                                eventId: eventId,
                                pollId: poll.$id,
                                selectedOptionNotifier: _selectedOption,
                              );
                            },
                            noPoll: (eventId) =>
                                _NoPollScreen(eventName: eventName),
                            error: (message) {
                              return Failure(
                                showImage: false,
                                message: message,
                                onRetry: () {
                                  BlocProvider.of<PollCubit>(context).loadPolls(
                                      eventLoadedStateValue.event.$id);
                                },
                              );
                            },
                            orElse: () {
                              return Container();
                            },
                          ),
                        );
                      },
                    ),
                    error: (value) => Failure(
                      showImage: false,
                      message: value.message,
                      onRetry: () {
                        BlocProvider.of<EventsCubit>(context).loadEventsList();
                      },
                    ),
                    orElse: () => Container(),
                    loading: (value) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class _PollAnswerOption extends StatelessWidget {
  const _PollAnswerOption({
    Key? key,
    this.index,
    required this.option,
    required this.onTap,
    required this.selectedOptionNotifier,
  }) : super(key: key);

  final int? index;
  final String option;
  final VoidCallback onTap;

  final ValueNotifier<int?> selectedOptionNotifier;

  void _showConfirmDialog(BuildContext context, VoidCallback onPressed) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          icon: const Icon(
            FeatherIcons.alertTriangle,
            color: Colors.red,
            size: 40,
          ),
          title: const CustomText.titleMedium('Подтверждение'),
          content: CustomText.bodyMedium(
            'Вы уверены, что хотите выбрать этот вариант ответа? Вы не сможете изменить свой голос.\n\n'
            'Вы выбрали вариант ответа: $option',
          ),
          actions: [
            CustomButton.text(
              onPressed: Navigator.of(context).pop,
              child: const CustomText.bodyMedium(
                'Отмена',
              ),
            ),
            CustomButton.text(
              onPressed: () {
                onPressed();
                Navigator.of(context).pop();
              },
              child: CustomText.bodyMedium(
                'Подтвердить',
                color: AppTheme.theme.colorScheme.primary,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (index != selectedOptionNotifier.value) {
          if (selectedOptionNotifier.value == null ||
              selectedOptionNotifier.value == -1) {
            _showConfirmDialog(context, () {
              onTap();

              selectedOptionNotifier.value = index;
            });
          }
        }
      },
      child: ValueListenableBuilder(
        valueListenable: selectedOptionNotifier,
        builder: (context, value, child) {
          return Container(
            decoration: BoxDecoration(
              color: selectedOptionNotifier.value == index
                  ? AppTheme.theme.colorScheme.primary
                  : Colors.transparent,
              border: Border.all(
                  color: selectedOptionNotifier.value == index
                      ? AppTheme.theme.colorScheme
                          .primary //_getColorBySelectedOption(option)
                      : AppTheme.theme.colorScheme.onBackground),
              borderRadius: const BorderRadius.all(
                Radius.circular(4),
              ),
            ),
            padding: Spacing.fromLTRB(0, 12, 0, 12),
            margin: Spacing.fromLTRB(48, 0, 48, 16),
            child: Center(
              child: CustomText.bodyLarge(
                option,
                color: selectedOptionNotifier.value == index
                    ? AppTheme.theme.colorScheme.onPrimary
                    : AppTheme.theme.colorScheme.onBackground,
                fontWeight: 600,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _Poll extends StatelessWidget {
  const _Poll({
    Key? key,
    required this.eventName,
    required this.question,
    required this.options,
    required this.votes,
    required this.isActive,
    required this.eventId,
    required this.pollId,
    required this.selectedOptionNotifier,
  }) : super(key: key);

  final String eventName;
  final String question;
  final List<String> options;
  final Map<String, int> votes;
  final bool isActive;
  final String eventId;
  final String pollId;

  final ValueNotifier<int?> selectedOptionNotifier;

  // Сортировки нужны, так как в БД не гарантируется порядок опций. Поэтому
  // сортируем их во время отображения, чтобы у всех пользователей был одинаковый
  // порядок опций.
  List<String> _getSortedOptions() {
    final sortedOptions = options.toList();
    sortedOptions.sort((a, b) {
      if (a.length == b.length) {
        return a.compareTo(b);
      } else {
        return a.length.compareTo(b.length);
      }
    });
    return sortedOptions;
  }

  Map<String, int> _getSortedVotes() {
    final sortedVotes = <String, int>{};
    final sortedOptions = _getSortedOptions();
    for (final option in sortedOptions) {
      sortedVotes[option] = votes[option] ?? 0;
    }
    return sortedVotes;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: Spacing.fromLTRB(16, 42, 16, 0),
          child: Column(
            children: [
              CustomText.titleMedium(eventName, //value.event.data['name'],
                  color: AppTheme.theme.colorScheme.onBackground,
                  fontWeight: 700),
              CustomText.bodySmall(
                isActive ? "Идёт голосование" : "Голосование завершено",
                color: AppTheme.theme.colorScheme.onBackground,
                fontWeight: 500,
              )
            ],
          ),
        ),
        Expanded(
          child: Container(
            padding: Spacing.fromLTRB(48, 0, 48, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomText.titleLarge(
                  question,
                  letterSpacing: 0.2,
                  wordSpacing: 0.5,
                  color: AppTheme.theme.colorScheme.onBackground,
                  fontWeight: 600,
                  textAlign: TextAlign.center,
                ),
                if (isActive)
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: _getSortedOptions()
                        .asMap()
                        .entries
                        .map(
                          (e) => _PollAnswerOption(
                            option: e.value,
                            index: e.key,
                            onTap: () {
                              if (isActive) {
                                BlocProvider.of<PollCubit>(context)
                                    .sendVote(eventId, pollId, e.value);
                              }
                            },
                            selectedOptionNotifier: selectedOptionNotifier,
                          ),
                        )
                        .toList(),
                  ),
              ],
            ),
          ),
        ),
        VotesBanner(votes: _getSortedVotes()),
        const SizedBox(height: 25),
        Container(
          padding: Spacing.fromLTRB(48, 0, 48, 0),
          child: CustomText.bodySmall(
            "Голосование завершится автоматически, когда все участники проголосуют."
            "${options.indexWhere((element) => element.toLowerCase() == 'воздержусь') == -1 ? "" : " Если вы не успеете завершить голосование, ваш голос автоматически отправится как \"воздержусь\"."}",
            color: AppTheme.theme.colorScheme.onBackground,
            muted: true,
            textAlign: TextAlign.justify,
          ),
        ),
        const SizedBox(height: 25),
      ],
    );
  }
}

class _NoPollScreen extends StatelessWidget {
  const _NoPollScreen({Key? key, required this.eventName}) : super(key: key);

  final String eventName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: Spacing.fromLTRB(16, 42, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText.titleMedium(eventName, //value.event.data['name'],
                  color: AppTheme.theme.colorScheme.onBackground,
                  fontWeight: 700,
                  textAlign: TextAlign.center),
              CustomText.bodySmall(
                "Сейчас нет доступных голосований",
                color: AppTheme.theme.colorScheme.onBackground,
                fontWeight: 500,
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
        Expanded(
          child: Container(
            padding: Spacing.fromLTRB(48, 0, 48, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CustomText.titleLarge(
                  "Подождите, пока начнётся голосование",
                  letterSpacing: 0.2,
                  wordSpacing: 0.5,
                  color: AppTheme.theme.colorScheme.onBackground,
                  fontWeight: 600,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
