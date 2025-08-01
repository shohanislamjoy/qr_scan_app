import 'package:flutter_test/flutter_test.dart';
import 'package:qr_scan_app/api_service.dart';

void main() {
  group('ApiService Tests', () {
    test('should identify URL QR codes correctly', () async {
      const testUrl = 'https://www.example.com';
      final result = await ApiService.sendQrData(testUrl);
      
      expect(result, contains('QR Type: URL'));
      expect(result, contains(testUrl));
      expect(result, contains('Valid URL detected'));
    });

    test('should identify email QR codes correctly', () async {
      const testEmail = 'test@example.com';
      final result = await ApiService.sendQrData(testEmail);
      
      expect(result, contains('QR Type: Email'));
      expect(result, contains(testEmail));
      expect(result, contains('Valid email format'));
    });

    test('should identify numeric QR codes correctly', () async {
      const testNumber = '123456789';
      final result = await ApiService.sendQrData(testNumber);
      
      expect(result, contains('QR Type: Numeric'));
      expect(result, contains(testNumber));
      expect(result, contains('Number detected'));
    });

    test('should identify text QR codes correctly', () async {
      const testText = 'Hello World';
      final result = await ApiService.sendQrData(testText);
      
      expect(result, contains('QR Type: Text'));
      expect(result, contains(testText));
      expect(result, contains('Text content scanned'));
    });

    test('should handle empty strings', () async {
      final result = await ApiService.sendQrData('');
      
      expect(result, contains('QR Type: Text'));
    });
  });
}