import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'api_service.dart';

class ScanQrPage extends StatefulWidget {
  @override
  _ScanQrPageState createState() => _ScanQrPageState();
}

class _ScanQrPageState extends State<ScanQrPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  String? apiInfo;
  bool scanning = false;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController ctrl) {
    controller = ctrl;
    controller!.scannedDataStream.listen((scanData) async {
      if (!scanning) {
        setState(() {
          scanning = true;
        });
        controller?.pauseCamera();

        // Send to API and get info
        final info = await ApiService.sendQrData(scanData.code ?? "");
        setState(() {
          result = scanData;
          apiInfo = info;
          scanning = false;
        });
        controller?.resumeCamera();
      }
    });
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
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
                overlay: QrScannerOverlayShape(
                  borderColor: Colors.indigo,
                  borderRadius: 12,
                  borderLength: 30,
                  borderWidth: 10,
                  cutOutSize: 250,
                ),
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
                  SelectableText(result!.code ?? ""),
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
              controller?.resumeCamera();
              setState(() {
                result = null;
                apiInfo = null;
              });
            },
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}