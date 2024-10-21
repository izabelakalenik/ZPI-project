import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../styles/layouts.dart';

class QrCodeScanner extends StatelessWidget {
  final Function(String) onCodeScanned;

  const QrCodeScanner({required this.onCodeScanned, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MainLayout(
    child: Scaffold(
      appBar: AppBar(
        title: Text(
          'QR Code Scanner',
          style: theme.textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: MobileScanner(
        onDetect: (BarcodeCapture capture) async {
          final barcodes = capture.barcodes;
          if (barcodes.isNotEmpty) {
            final qrCode = barcodes.first.rawValue;
            if (qrCode != null) {
              onCodeScanned(qrCode);
            }
          }
        },
      ),
    ),
    );
  }
}