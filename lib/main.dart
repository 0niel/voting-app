import 'package:dio/dio.dart';
import 'package:face_to_face_voting/blocs/events/events_cubit.dart';
import 'package:face_to_face_voting/blocs/participants/participants_cubit.dart';
import 'package:face_to_face_voting/blocs/poll/poll_cubit.dart';
import 'package:face_to_face_voting/blocs/search_users/search_users_cubit.dart';
import 'package:face_to_face_voting/service_locator.dart';
import 'package:face_to_face_voting/theme/app_theme.dart';
import 'package:face_to_face_voting/views/login/login_home_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sentry_dio/sentry_dio.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:sentry_logging/sentry_logging.dart';
import 'blocs/profile/profile_cubit.dart';
import 'service_locator.dart' as service_locator;

class GlobalBlocObserver extends BlocObserver {
  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    Sentry.captureException(error, stackTrace: stackTrace);

    if (kDebugMode) {
      print(stackTrace);
    }

    super.onError(bloc, error, stackTrace);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await service_locator.setup();

  Bloc.observer = GlobalBlocObserver();

  await SentryFlutter.init(
    (options) {
      options.dsn =
          const String.fromEnvironment('SENTRY_DSN', defaultValue: '');

      // Set tracesSampleRate to 0.2 to capture 20% of transactions for
      // performance monitoring.
      options.tracesSampleRate = 0.2;

      options.enableAutoPerformanceTracking = true;

      options.attachScreenshot = true;

      options.addIntegration(LoggingIntegration());
    },
    appRunner: () => runApp(
      /// When a user experiences an error, an exception or a crash,
      /// Sentry provides the ability to take a screenshot and include
      /// it as an attachment.
      SentryScreenshotWidget(
        child: DefaultAssetBundle(
          /// The AssetBundle instrumentation provides insight into how long
          /// app takes to load its assets, such as files
          bundle: SentryAssetBundle(),
          child: const App(),
        ),
      ),
    ),
  ).then((value) {
    final Dio dio = getIt<Dio>();
    dio.addSentry();
  });
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

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
        BlocProvider<ParticipantsCubit>(
            create: (context) => service_locator.getIt<ParticipantsCubit>()),
        BlocProvider<SearchUsersCubit>(
            create: (context) => service_locator.getIt<SearchUsersCubit>()),
      ],
      child: MaterialApp(
        title: 'Система очного голосования',
        theme: AppTheme.theme,
        home: const LoginHomeScreen(),
        debugShowCheckedModeBanner: false,
        navigatorObservers: [
          SentryNavigatorObserver(),
        ],
      ),
    );
  }
}
