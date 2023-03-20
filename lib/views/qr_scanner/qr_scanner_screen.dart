import 'dart:typed_data';

import 'package:face_to_face_voting/blocs/events/events_cubit.dart';
import 'package:face_to_face_voting/blocs/search_users/search_users_cubit.dart';
import 'package:face_to_face_voting/widgets/snackbar.dart';
import 'package:face_to_face_voting/widgets/text.dart';
import 'package:face_to_face_voting/widgets/user_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

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

                      ScannedBottomSheet.show(context, event, barcode.rawValue!)
                          .then((value) {
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
