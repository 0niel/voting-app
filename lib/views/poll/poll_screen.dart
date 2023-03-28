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

  @override
  void dispose() {
    _selectedOption.dispose();
    super.dispose();
  }

  late final ValueNotifier<int?> _selectedOption;

  void _setMyVote(String meId, List<Document> votes, List<String> options,
      [bool onUpdate = false]) {
    if (!_isFirstBuild && !onUpdate) {
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
    if (index != _selectedOption.value || index == -1) {
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
                        BlocConsumer<PollCubit, PollState>(
                      listenWhen: (previous, current) {
                        if (previous.maybeWhen(
                              orElse: () => false,
                              noPoll: (_) => true,
                              error: (_) => true,
                              loading: () => true,
                            ) &&
                            current.maybeWhen(
                              orElse: () => false,
                              success: (eventId, poll, votes, timeLeft,
                                      timeMaximum) =>
                                  true,
                            )) {
                          return true;
                        }

                        final prevSuccess = previous.maybeWhen(
                          orElse: () => false,
                          success:
                              (eventId, poll, votes, timeLeft, timeMaximum) =>
                                  true,
                        );

                        final currentSuccess = current.maybeWhen(
                          orElse: () => false,
                          success:
                              (eventId, poll, votes, timeLeft, timeMaximum) =>
                                  true,
                        );

                        if (prevSuccess && currentSuccess) {
                          final prevPoll = previous.maybeWhen(
                            orElse: () => null,
                            success:
                                (eventId, poll, votes, timeLeft, timeMaximum) =>
                                    poll,
                          );

                          final currentPoll = current.maybeWhen(
                            orElse: () => null,
                            success:
                                (eventId, poll, votes, timeLeft, timeMaximum) =>
                                    poll,
                          );

                          final prevTimeStart = prevPoll?.data['start_at'];
                          final currentTimeStart =
                              currentPoll?.data['start_at'];

                          final prevTimeEnd = prevPoll?.data['end_at'];
                          final currentTimeEnd = currentPoll?.data['end_at'];

                          final prevOptions = List<String>.from(
                              prevPoll?.data['poll_options'] ?? []);
                          final currentOptions = List<String>.from(
                              currentPoll?.data['poll_options'] ?? []);

                          if (prevTimeStart != currentTimeStart ||
                              !const ListEquality()
                                  .equals(prevOptions, currentOptions) ||
                              prevTimeEnd != currentTimeEnd) {
                            return true;
                          }
                        }

                        return false;
                      },
                      listener: (context, state) {
                        state.maybeWhen(
                          orElse: () {},
                          success:
                              (eventId, poll, votes, timeLeft, timeMaximum) {
                            final options =
                                List<String>.from(poll.data['poll_options']);

                            _setMyVote(me.$id, votes, options, true);
                          },
                        );
                      },
                      builder: (context, pollState) {
                        final eventName =
                            eventLoadedStateValue.event.data['name'];
                        return RefreshIndicator(
                          onRefresh: () async {
                            BlocProvider.of<PollCubit>(context)
                                .loadPolls(eventLoadedStateValue.event.$id);
                          },
                          child: CustomScrollView(
                            slivers: [
                              SliverFillRemaining(
                                hasScrollBody: false,
                                child: pollState.maybeWhen(
                                  success: (eventId, poll, votes, timeLeft,
                                      timeMaximum) {
                                    final question =
                                        poll.data['question'] as String;
                                    final options = List<String>.from(
                                        poll.data['poll_options']);

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
                                      showOnlyVotersCount:
                                          poll.data['show_only_voters_count'] ??
                                              false,
                                      isFinished:
                                          poll.data['is_finished'] ?? false,
                                    );
                                  },
                                  noPoll: (eventId) =>
                                      _NoPollScreen(eventName: eventName),
                                  error: (message) {
                                    return Failure(
                                      showImage: false,
                                      message: message,
                                      onRetry: () {
                                        BlocProvider.of<PollCubit>(context)
                                            .loadPolls(eventLoadedStateValue
                                                .event.$id);
                                      },
                                    );
                                  },
                                  orElse: () {
                                    return Container();
                                  },
                                ),
                              ),
                            ],
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
    required this.showOnlyVotersCount,
    required this.isFinished,
  }) : super(key: key);

  final String eventName;
  final String question;
  final List<String> options;
  final Map<String, int> votes;
  final bool isActive;
  final String eventId;
  final String pollId;

  final bool showOnlyVotersCount;
  final bool isFinished;

  final ValueNotifier<int?> selectedOptionNotifier;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: Spacing.fromLTRB(16, 16, 8, 0),
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
            padding: Spacing.fromLTRB(24, 0, 24, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
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
                    children: [
                      for (var i = 0; i < options.length; i++)
                        _PollAnswerOption(
                          index: i,
                          option: options[i],
                          onTap: () {
                            if (isActive) {
                              BlocProvider.of<PollCubit>(context)
                                  .sendVote(eventId, pollId, options[i]);
                            }
                          },
                          selectedOptionNotifier: selectedOptionNotifier,
                        ),
                    ],
                  ),
              ],
            ),
          ),
        ),
        VotesBanner(
          votes: votes,
          showOnlyVotersCount: showOnlyVotersCount,
          isFinished: isFinished,
        ),
        if (options.indexWhere(
                (element) => element.toLowerCase() == 'воздержусь') !=
            -1) ...[
          const SizedBox(height: 25),
          Container(
            padding: Spacing.fromLTRB(48, 0, 48, 0),
            child: CustomText.bodySmall(
              "Если вы не успеете завершить голосование, ваш голос автоматически отправится как \"воздержусь\".",
              color: AppTheme.theme.colorScheme.onBackground,
              muted: true,
              textAlign: TextAlign.justify,
            ),
          ),
        ],
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
