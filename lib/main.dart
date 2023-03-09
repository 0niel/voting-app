import 'package:face_to_face_voting/blocs/events/events_bloc.dart';
import 'package:face_to_face_voting/blocs/poll/poll_bloc.dart';
import 'package:face_to_face_voting/theme/app_theme.dart';
import 'package:face_to_face_voting/views/login/login_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'blocs/profile/profile_bloc.dart';
import 'service_locator.dart' as service_locator;
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await service_locator.setup();

  // clear secure storage
  // final secureStorage = service_locator.getIt<FlutterSecureStorage>();
  // await secureStorage.deleteAll();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProfileBloc>(
            lazy: false,
            create: (context) => service_locator.getIt<ProfileBloc>()
              ..add(const ProfileEvent.started())),
        BlocProvider<EventsBloc>(
            create: (context) => service_locator.getIt<EventsBloc>()),
        BlocProvider<PollBloc>(
            create: (context) => service_locator.getIt<PollBloc>()),
      ],
      child: MaterialApp(
        title: 'Система очного голосования',
        theme: AppTheme.theme,
        home: const LoginHomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
