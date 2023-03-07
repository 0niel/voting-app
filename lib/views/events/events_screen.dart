import 'package:appwrite/models.dart';
import 'package:face_to_face_voting/blocs/events/events_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../poll/poll_screen.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({Key? key, required this.events}) : super(key: key);

  final DocumentList events;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<EventsBloc, EventsState>(
      builder: (context, state) {
        return state.map(
          initial: (initialState) => const _Loading(),
          loading: (loadingState) => const _Loading(),
          eventsListLoaded: (eventsListLoadedState) =>
              _Success(events: eventsListLoadedState.events),
          eventLoaded: (eventLoadedState) => Container(),
        );
      },
    ));
  }
}

class _Success extends StatelessWidget {
  const _Success({Key? key, required this.events}) : super(key: key);

  final DocumentList events;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: events.total,
      itemBuilder: (context, index) {
        return Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                  leading: const Icon(Icons.album),
                  title: Text(events.documents[index].data['name']),
                  subtitle: Text(
                      events.documents[index].data['start_at'] != null
                          ? events.documents[index].data['start_at'].toString()
                          : 'дата не указана')),
            ],
          ),
        );
      },
    );
  }
}

class _Loading extends StatelessWidget {
  const _Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class _Failure extends StatelessWidget {
  const _Failure({Key? key, required this.message}) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(message),
    );
  }
}
