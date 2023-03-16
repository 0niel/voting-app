import 'dart:typed_data';

import 'package:appwrite/models.dart';
import 'package:face_to_face_voting/blocs/events/events_cubit.dart';
import 'package:face_to_face_voting/blocs/participants/participants_cubit.dart';
import 'package:face_to_face_voting/blocs/search_users/search_users_cubit.dart';
import 'package:face_to_face_voting/theme/app_theme.dart';
import 'package:face_to_face_voting/utils/spacing.dart';
import 'package:face_to_face_voting/widgets/button.dart';
import 'package:face_to_face_voting/widgets/snackbar.dart';
import 'package:face_to_face_voting/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class _ScannedBottomSheet extends StatelessWidget {
  const _ScannedBottomSheet(
      {Key? key, required this.event, required this.userId})
      : super(key: key);

  final String userId;
  final Document event;

  @override
  Widget build(BuildContext context) {
    final searchBloc = context.read<SearchUsersCubit>();
    final participantsBloc = context.read<ParticipantsCubit>();

    return Container(
      color: Colors.transparent,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: AppTheme.theme.colorScheme.background,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Padding(
          padding: Spacing.all(16),
          child: BlocBuilder<SearchUsersCubit, SearchUsersState>(
            builder: (context, state) {
              return state.maybeWhen(
                loading: () => const Center(child: CircularProgressIndicator()),
                loadedUser: (user, avatar) => Column(
                  children: [
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: CircleAvatar(
                        radius: 50,
                        child: avatar,
                      ),
                    ),
                    const SizedBox(height: 20),
                    CustomText.headlineSmall(user.key.name),
                    const SizedBox(height: 20),
                    CustomText.bodySmall(
                        user.key.prefs.containsKey('academicGroup')
                            ? user.key.prefs['academicGroup']
                            : "У пользователя нет группы"),
                    const SizedBox(height: 20),
                    CustomText.bodySmall(
                        user.value ? "Участник" : "Не участник"),
                    const SizedBox(height: 20),
                    user.value
                        ? CustomButton.text(
                            onPressed: () {
                              participantsBloc
                                  .removeParticipant(event.$id, userId)
                                  .then((value) {
                                searchBloc.getUser(event, userId);
                              });
                            },
                            backgroundColor: AppTheme.theme.colorScheme.primary,
                            child: const CustomText.bodySmall(
                              "Удалить из участников",
                            ),
                          )
                        : CustomButton.text(
                            backgroundColor: AppTheme.theme.colorScheme.primary,
                            onPressed: () {
                              participantsBloc
                                  .addParticipant(event.$id, userId)
                                  .then((value) {
                                searchBloc.getUser(event, userId);
                              });
                            },
                            child: const CustomText.bodySmall(
                              "Добавить в участники",
                            ),
                          ),
                  ],
                ),
                orElse: () => const Center(child: CircularProgressIndicator()),
              );
            },
          ),
        ),
      ),
    );
  }
}

class QrScannerScreen extends StatelessWidget {
  QrScannerScreen({Key? key}) : super(key: key);

  MobileScannerController cameraController = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText.titleMedium("QR-сканер"),
        elevation: 0,
      ),
      body: BlocListener<SearchUsersCubit, SearchUsersState>(
        listener: (context, state) {
          state.maybeWhen(
            error: (message) {
              showMessage(context, message, true);
            },
            orElse: () {},
          );
        },
        child: BlocBuilder<EventsCubit, EventsState>(
          builder: (context, state) {
            return state.maybeWhen(
              eventLoaded: (event, _) {
                return MobileScanner(
                  controller: cameraController,
                  onDetect: (capture) {
                    final List<Barcode> barcodes = capture.barcodes;
                    final Uint8List? image = capture.image;
                    for (final barcode in barcodes) {
                      if (barcode.rawValue == null) return;

                      cameraController.stop();
                      context
                          .read<SearchUsersCubit>()
                          .getUser(event, barcode.rawValue!);
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(16),
                          ),
                        ),
                        isScrollControlled: true,
                        builder: (context) => _ScannedBottomSheet(
                          event: event,
                          userId: barcode.rawValue!,
                        ),
                      ).then((value) {
                        cameraController.start();
                      });
                    }
                  },
                );
              },
              orElse: () => const Scaffold(),
            );
          },
        ),
      ),
    );
  }
}
