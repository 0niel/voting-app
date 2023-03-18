import 'dart:async';

import 'package:face_to_face_voting/blocs/events/events_cubit.dart';
import 'package:face_to_face_voting/blocs/poll/poll_cubit.dart';
import 'package:face_to_face_voting/blocs/resources/resources_cubit.dart';
import 'package:face_to_face_voting/theme/app_theme.dart';
import 'package:face_to_face_voting/utils/spacing.dart';
import 'package:face_to_face_voting/views/events/events_screen.dart';
import 'package:face_to_face_voting/views/profile/profile_screen.dart';
import 'package:face_to_face_voting/views/qrcode/qrcode_screen.dart';
import 'package:face_to_face_voting/views/poll/poll_screen.dart';
import 'package:face_to_face_voting/widgets/container.dart';
import 'package:face_to_face_voting/widgets/quick_action_bottom_sheet.dart';
import 'package:face_to_face_voting/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  final ValueNotifier<int> value = ValueNotifier<int>(30);
  int _currentScreen = 1;
  final _screens = const [QrCodeScreen(), PollScreen(), ProfileScreen()];

  Timer? _timer;

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  void _changeCurrentScreen(int page) {
    // we increase the brightness to the maximum on the page with the qr code
    if (page == 0) {
      setBrightness(1.0);
    } else {
      resetBrightness();
    }

    setState(() {
      _currentScreen = page;
    });
  }

  Future<void> resetBrightness() async {
    try {
      return await ScreenBrightness().resetScreenBrightness();
    } catch (e) {
      return;
    }
  }

  Future<void> setBrightness(double brightness) async {
    try {
      await ScreenBrightness().setScreenBrightness(brightness);
    } catch (e) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<EventsCubit>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      drawer: const _Drawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: BlocBuilder<EventsCubit, EventsState>(
        builder: (context, state) {
          return state.maybeMap(
            eventLoaded: (value) {
              if (!value.isAcessModerator) {
                return const SizedBox();
              }
              return Padding(
                padding: Spacing.bottom(42),
                child: FloatingActionButton(
                  mini: false,
                  onPressed: () {
                    QuickActionBottomSheet.showBottomSheet(context);
                  },
                  elevation: 2,
                  backgroundColor: AppTheme.theme.colorScheme.primary,
                  child: Icon(
                    Icons.flash_on_outlined,
                    size: 26,
                    color: AppTheme.theme.colorScheme.onPrimary,
                  ),
                ),
              );
            },
            orElse: () => const SizedBox(),
          );
        },
      ),
      body: BlocBuilder<EventsCubit, EventsState>(
        bloc: bloc,
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: state.maybeMap(
                  initial: (value) {
                    return _currentScreen == 1
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : _screens[_currentScreen];
                  },
                  eventsListLoaded: (value) {
                    return _currentScreen == 1
                        ? EventsScreen(events: value.events)
                        : _screens[_currentScreen];
                  },
                  eventLoaded: (value) {
                    return _screens[_currentScreen];
                  },
                  orElse: () => _screens[_currentScreen],
                ),
              ),
              Container(
                color: AppTheme.theme.cardColor,
                padding: Spacing.fromLTRB(32, 16, 32, 4),
                child: SafeArea(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      InkWell(
                        onTap: () => _changeCurrentScreen(0),
                        child: Icon(
                          MdiIcons.qrcode,
                          color: _currentScreen == 0
                              ? AppTheme.theme.colorScheme.primary
                              : AppTheme.theme.colorScheme.onBackground,
                          size: 26,
                        ),
                      ),
                      _currentScreen != 1 ||
                              state.maybeMap(
                                  eventsListLoaded: (value) => true,
                                  orElse: () => false)
                          ? SizedBox(
                              width: 48,
                              height: 48,
                              child: InkWell(
                                onTap: () => _changeCurrentScreen(1),
                                child: Icon(
                                  MdiIcons.vote,
                                  color: (_currentScreen == 1 &&
                                          state.maybeMap(
                                              eventsListLoaded: (value) => true,
                                              orElse: () => false))
                                      ? AppTheme.theme.colorScheme.primary
                                      : AppTheme.theme.colorScheme.onBackground,
                                  size: 26,
                                ),
                              ),
                            )
                          : Center(
                              child: _buildTimer(),
                            ),
                      InkWell(
                        onTap: () => _changeCurrentScreen(2),
                        child: Icon(
                          MdiIcons.account,
                          color: _currentScreen == 2
                              ? AppTheme.theme.colorScheme.primary
                              : AppTheme.theme.colorScheme.onBackground,
                          size: 26,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTimer() {
    return BlocBuilder<PollCubit, PollState>(
      builder: (context, state) {
        return state.maybeMap(
          success: (value) {
            print('Percent left: ${value.percentsLeft}');
            return SizedBox(
              width: 48,
              height: 48,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  CircularProgressIndicator(
                    valueColor: value.timeLeft.inSeconds > 0
                        ? AlwaysStoppedAnimation<Color>(
                            AppTheme.theme.colorScheme.primary,
                          )
                        : AlwaysStoppedAnimation<Color>(
                            AppTheme.theme.colorScheme.error,
                          ),
                    value: value.percentsLeft,
                  ),
                  CustomText.bodyLarge(value.timeLeft.inSeconds.toString(),
                      color: AppTheme.theme.colorScheme.onBackground,
                      fontWeight: 600)
                ],
              ),
            );
          },
          orElse: () => SizedBox(
            width: 48,
            height: 48,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                const Text(""),
                CustomText.bodyLarge(
                  "0",
                  color: AppTheme.theme.colorScheme.onBackground,
                  fontWeight: 600,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class _Drawer extends StatelessWidget {
  const _Drawer({Key? key}) : super(key: key);

  void _launchResource(e) async {
    String url = e.data['url'];
    await launchUrlString(url);
  }

  List<Color> _getResourceColorByName(String name) {
    final colors = [
      [const Color(0xff639fdc).withAlpha(20), const Color(0xff639fdc)],
      [const Color(0xffb38220).withAlpha(20), const Color(0xffb38220)],
      [const Color(0xff8bc34a).withAlpha(20), const Color(0xff8bc34a)],
      [const Color(0xffe91e63).withAlpha(20), const Color(0xffe91e63)],
      [const Color(0xff9c27b0).withAlpha(20), const Color(0xff9c27b0)],
      [const Color(0xff795548).withAlpha(20), const Color(0xff795548)],
      [const Color(0xff00bcd4).withAlpha(20), const Color(0xff00bcd4)],
      [const Color(0xff607d8b).withAlpha(20), const Color(0xff607d8b)],
      [const Color(0xffcddc39).withAlpha(20), const Color(0xffcddc39)],
      [const Color(0xff009688).withAlpha(20), const Color(0xff009688)],
    ];

    return colors[name.hashCode % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    return CustomContainer.none(
      margin: Spacing.fromLTRB(16, Spacing.safeAreaTop(context) + 16, 16, 16),
      borderRadiusAll: 4,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: AppTheme.theme.scaffoldBackgroundColor,
      child: Drawer(
        child: Container(
          color: AppTheme.theme.scaffoldBackgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: Spacing.only(left: 20, bottom: 24, top: 24, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Image(
                      image: AssetImage('assets/logo-retina.png'),
                      height: 102,
                      width: 102,
                    ),
                    Spacing.height(16),
                    CustomContainer(
                      padding: Spacing.fromLTRB(12, 4, 12, 4),
                      borderRadiusAll: 4,
                      color: AppTheme.theme.colorScheme.primary.withAlpha(40),
                      child: CustomText.bodyMedium("Powered by Mirea Ninja",
                          color: AppTheme.theme.colorScheme.primary,
                          fontWeight: 600,
                          letterSpacing: 0.2),
                    ),
                  ],
                ),
              ),
              Spacing.height(32),
              BlocBuilder<EventsCubit, EventsState>(builder: (context, state) {
                final resourcesBloc = BlocProvider.of<ResourcesCubit>(context);
                final eventId = state.maybeMap(
                  eventLoaded: (event) {
                    return event.event.$id;
                  },
                  orElse: () => null,
                );

                resourcesBloc.state.maybeMap(
                  loaded: (value) {
                    if (value.resources.isEmpty) {
                      resourcesBloc.loadResources();
                    }
                  },
                  orElse: () => resourcesBloc.loadResources(),
                );

                return BlocBuilder<ResourcesCubit, ResourcesState>(
                  bloc: resourcesBloc,
                  builder: (context, resourcesState) {
                    return resourcesState.maybeMap(
                      loaded: (value) {
                        return Container(
                          margin: Spacing.x(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ...value.resources
                                  .where((element) =>
                                      (element.data['event_id'] == eventId) ||
                                      (element.data['event_id'] == null))
                                  .map(
                                    (e) => Padding(
                                      padding: Spacing.y(8),
                                      child: InkWell(
                                        onTap: () => _launchResource(e),
                                        highlightColor: Colors.transparent,
                                        splashColor: Colors.transparent,
                                        child: Row(
                                          children: [
                                            CustomContainer(
                                              paddingAll: 12,
                                              borderRadiusAll: 4,
                                              color: _getResourceColorByName(
                                                  e.data['name'])[0],
                                              child: SvgPicture.string(
                                                e.data['svg_icon'],
                                                width: 20,
                                                height: 20,
                                                color: _getResourceColorByName(
                                                    e.data['name'])[1],
                                              ),
                                            ),
                                            Spacing.width(16),
                                            Expanded(
                                              child: CustomText.bodyLarge(
                                                  e.data['name']),
                                            ),
                                            Spacing.width(16),
                                            Icon(
                                              MdiIcons.chevronRight,
                                              size: 18,
                                              color: AppTheme.theme.colorScheme
                                                  .onBackground
                                                  .withAlpha(200),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ],
                          ),
                        );
                      },
                      orElse: () => const SizedBox(),
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
