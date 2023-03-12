import 'package:collection/collection.dart';
import 'package:face_to_face_voting/blocs/events/events_cubit.dart';
import 'package:face_to_face_voting/blocs/poll/poll_cubit.dart';
import 'package:face_to_face_voting/blocs/profile/profile_cubit.dart';
import 'package:face_to_face_voting/theme/app_theme.dart';
import 'package:face_to_face_voting/utils/spacing.dart';
import 'package:face_to_face_voting/widgets/text.dart';
import 'package:face_to_face_voting/widgets/votes_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PollScreen extends StatefulWidget {
  const PollScreen({Key? key}) : super(key: key);

  @override
  _PollScreenState createState() => _PollScreenState();
}

class _PollScreenState extends State<PollScreen> {
  @override
  void initState() {
    super.initState();
  }

  int? _selectedOption = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, profileState) {
          return profileState.maybeMap(
            orElse: () => Container(),
            success: (user) {
              return BlocConsumer<EventsCubit, EventsState>(
                listener: (context, state) {
                  state.maybeWhen(
                      orElse: () {},
                      eventLoaded: (events) {
                        BlocProvider.of<PollCubit>(context)
                            .loadPolls(events.$id);
                      });
                },
                builder: (context, state) {
                  return state.maybeMap(
                    eventLoaded: (eventLoadedStateValue) =>
                        BlocBuilder<PollCubit, PollState>(
                      builder: (context, pollState) {
                        final eventName =
                            eventLoadedStateValue.event.data['name'];
                        return pollState.maybeWhen(
                          success:
                              (eventId, poll, votes, timeLeft, timeMaximum) {
                            final question = poll.data['question'] as String;
                            final options =
                                List<String>.from(poll.data['poll_options']);

                            final votesMap = votes.documents
                                .fold<Map<String, int>>({}, (map, doc) {
                              final vote = doc.data['vote'] as String;
                              return map
                                ..update(vote, (count) => count + 1,
                                    ifAbsent: () => 1);
                            });

                            final meId = user.user.$id;

                            final String? myVote;
                            final myVoteDoc = votes.documents.firstWhereOrNull(
                                (doc) => doc.data['voter_id'] == meId);
                            if (myVoteDoc != null) {
                              myVote = myVoteDoc.data['vote'] as String;
                            } else {
                              myVote = null;
                            }

                            return _buildPoll(
                              eventName,
                              question,
                              options,
                              votesMap,
                              (timeLeft.isNegative || timeLeft.inSeconds == 0)
                                  ? false
                                  : true,
                              eventId,
                              poll.$id,
                            );
                          },
                          noPoll: (eventId) =>
                              _NoPollScreen(eventName: eventName),
                          orElse: () {
                            return Container();
                          },
                        );
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

  Widget _buildPoll(String eventName, String question, List<String> options,
      Map<String, int> votes, bool isActive, String eventId, String pollId) {
    return Column(
      children: <Widget>[
        Container(
          padding: Spacing.fromLTRB(16, 42, 16, 0),
          child: Column(
            children: <Widget>[
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
              children: <Widget>[
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
                    children: options
                        .asMap()
                        .entries
                        .map(
                          (e) => questionOption(
                            option: e.value,
                            index: e.key,
                            onTap: () {
                              if (isActive) {
                                BlocProvider.of<PollCubit>(context)
                                    .sendVote(eventId, pollId, e.value);
                              }
                            },
                          ),
                        )
                        .toList(),
                  ),
              ],
            ),
          ),
        ),
        VotesBanner(votes: votes),
        const SizedBox(height: 25),
        Container(
          padding: Spacing.fromLTRB(48, 0, 48, 0),
          child: CustomText.bodySmall(
            "Голосование завершится автоматически, когда все участники проголосуют. Если вы не успеете завершить голосование, ваш голос автоматически отправится как \"воздержусь\".",
            color: AppTheme.theme.colorScheme.onBackground,
            muted: true,
            textAlign: TextAlign.justify,
          ),
        ),
        const SizedBox(height: 25),
      ],
    );
  }

  Widget questionOption({
    required String option,
    int? index,
    required Function onTap,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (index != _selectedOption) onTap();
          _selectedOption = index;
        });
      },
      child: Container(
        decoration: BoxDecoration(
            color: _selectedOption == index
                ? AppTheme.theme.colorScheme
                    .primary //_getColorBySelectedOption(option)
                : Colors.transparent,
            border: Border.all(
                color: _selectedOption == index
                    ? AppTheme.theme.colorScheme
                        .primary //_getColorBySelectedOption(option)
                    : AppTheme.theme.colorScheme.onBackground),
            borderRadius: const BorderRadius.all(Radius.circular(4))),
        padding: Spacing.fromLTRB(0, 12, 0, 12),
        margin: Spacing.fromLTRB(48, 0, 48, 16),
        child: Center(
          child: CustomText.bodyLarge(option,
              color: _selectedOption == index
                  ? AppTheme.theme.colorScheme.onPrimary
                  : AppTheme.theme.colorScheme.onBackground,
              fontWeight: 600),
        ),
      ),
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
