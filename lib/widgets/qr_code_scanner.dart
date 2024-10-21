import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrCodeScanner extends StatelessWidget {
  final Function(String) onCodeScanned;

  const QrCodeScanner({required this.onCodeScanned, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code Scanner'),
      ),
      body: MobileScanner(
        onDetect: (BarcodeCapture capture) async {
          final barcodes = capture.barcodes;
          if (barcodes.isNotEmpty) {
            final qrCode = barcodes.first.rawValue;
            if (qrCode != null) {
              onCodeScanned(qrCode);
              Navigator.pop(context); // Close the scanner after a successful scan
            }
          }
        },
      ),
    );
  }
}