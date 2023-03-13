import 'dart:typed_data';

import 'package:face_to_face_voting/widgets/text.dart';
import 'package:flutter/material.dart';
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
      body: MobileScanner(
        // fit: BoxFit.contain,
        controller: MobileScannerController(
          facing: CameraFacing.back,
        ),
        onDetect: (capture) {
          final List<Barcode> barcodes = capture.barcodes;
          final Uint8List? image = capture.image;
          for (final barcode in barcodes) {
            debugPrint('Barcode found! ${barcode.rawValue}');
          }
        },
      ),
    );
  }
}
