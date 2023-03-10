import 'package:face_to_face_voting/blocs/events/events_cubit.dart';
import 'package:face_to_face_voting/blocs/poll/poll_cubit.dart';
import 'package:face_to_face_voting/theme/app_theme.dart';
import 'package:face_to_face_voting/views/login/login_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/profile/profile_cubit.dart';
import 'service_locator.dart' as service_locator;

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
        BlocProvider<ProfileCubit>(
            lazy: false,
            create: (context) =>
                service_locator.getIt<ProfileCubit>()..started()),
        BlocProvider<EventsCubit>(
            create: (context) => service_locator.getIt<EventsCubit>()),
        BlocProvider<PollCubit>(
            create: (context) => service_locator.getIt<PollCubit>()),
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
