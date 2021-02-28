import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/src/providers/scan_list_provider.dart';

class ScanButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.filter_center_focus),
      onPressed: () async {
        print('Hola desde qr');
        String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
            '#3D8BEF', 'Cancelar', false, ScanMode.QR);

        //String barcodeScanRes = 'https://fernando-herrera.com';
        print(barcodeScanRes);
        final scanListProvider =
            Provider.of<ScanListProvider>(context, listen: false);
        scanListProvider.nuevoScan(barcodeScanRes);
      },
    );
  }
}
