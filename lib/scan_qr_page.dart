import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'api_service.dart';

class ScanQrPage extends StatefulWidget {
  const ScanQrPage({super.key});

  @override
  State<ScanQrPage> createState() => _ScanQrPageState();
}

class _ScanQrPageState extends State<ScanQrPage> {
  MobileScannerController cameraController = MobileScannerController();
  String? result;
  String? apiInfo;
  bool scanning = false;

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture barcodeCapture) async {
    if (!scanning && barcodeCapture.barcodes.isNotEmpty) {
      setState(() {
        scanning = true;
      });

      final code = barcodeCapture.barcodes.first.rawValue ?? "";

      // Send to API and get info
      final info = await ApiService.sendQrData(code);
      setState(() {
        result = code;
        apiInfo = info;
        scanning = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Container(
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.indigo, width: 3),
              ),
              child: MobileScanner(
                controller: cameraController,
                onDetect: _onDetect,
              ),
            ),
          ),
          if (result != null)
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Text(
                    'Scanned QR Data:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SelectableText(result ?? ""),
                ],
              ),
            ),
          if (apiInfo != null)
            Card(
              color: Colors.indigo[50],
              elevation: 2,
              margin: EdgeInsets.all(12),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  apiInfo!,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          SizedBox(height: 12),
          ElevatedButton.icon(
            icon: Icon(Icons.qr_code_scanner),
            label: Text('Scan QR Code'),
            style: ElevatedButton.styleFrom(
              minimumSize: Size(180, 48),
              textStyle: TextStyle(fontSize: 18),
            ),
            onPressed: () {
              setState(() {
                result = null;
                apiInfo = null;
                scanning = false;
              });
            },
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
