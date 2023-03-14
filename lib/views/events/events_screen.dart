import 'package:appwrite/models.dart';
import 'package:face_to_face_voting/blocs/events/events_cubit.dart';
import 'package:face_to_face_voting/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({Key? key, required this.events}) : super(key: key);

  final DocumentList events;

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<EventsCubit>(context);
    print("BUILDING EVENTS SCREEN. BLOC: $bloc");
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const CustomText.titleLarge('Предстоящие мероприятия',
            fontWeight: 700),
      ),
      body: BlocConsumer<EventsCubit, EventsState>(
        bloc: bloc,
        listener: (context, state) {
          print("LISTENING EVENTS SCREEN. STATE: $state");
        },
        builder: (context, state) {
          print("BUILDING EVENTS SCREEN. STATE: $state");
          return state.map(
            initial: (initialState) => const _Loading(),
            loading: (loadingState) => const _Loading(),
            eventsListLoaded: (eventsListLoadedState) =>
                _Success(events: eventsListLoadedState.events),
            eventLoaded: (eventLoadedState) => Container(),
          );
        },
      ),
    );
  }
}

class _Success extends StatelessWidget {
  const _Success({Key? key, required this.events}) : super(key: key);

  final DocumentList events;

  String _formatDateTime(String? dateTimeString) {
    if (dateTimeString == null) return "не указана";

    final dateTime = DateTime.parse(dateTimeString);
    return "${dateTime.day.toString().padLeft(2, '0')}.${dateTime.month.toString().padLeft(2, '0')}.${dateTime.year} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: events.total,
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.all(8),
                color:
                    Theme.of(context).colorScheme.secondary.withOpacity(0.15),
                elevation: 0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.event,
                          color: Theme.of(context).colorScheme.secondary),
                      title: CustomText.bodyLarge(
                        events.documents[index].data['name'],
                        fontWeight: 700,
                      ),
                      subtitle: CustomText.bodySmall(
                        "Дата проведения: ${_formatDateTime(events.documents[index].data['start_at'])}",
                        fontWeight: 500,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
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
