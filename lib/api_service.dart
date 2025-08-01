import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'https://api.example.com'; // Replace with actual API
  
  static Future<String> sendQrData(String qrData) async {
    try {
      // For now, simulate API call for demo purposes
      // In a real app, uncomment the HTTP request below:
      
      // final response = await http.post(
      //   Uri.parse('$_baseUrl/qr-scan'),
      //   headers: {'Content-Type': 'application/json'},
      //   body: jsonEncode({'qr_data': qrData}),
      // );
      
      // if (response.statusCode == 200) {
      //   final data = jsonDecode(response.body);
      //   return data['info'] ?? 'No information available';
      // } else {
      //   return 'Error: ${response.statusCode}';
      // }
      
      // Simulate network delay
      await Future.delayed(Duration(seconds: 1));
      
      // Mock response based on QR data type
      if (qrData.startsWith('http')) {
        return 'QR Type: URL\nData: $qrData\nStatus: Valid URL detected';
      } else if (qrData.contains('@')) {
        return 'QR Type: Email\nData: $qrData\nStatus: Valid email format';
      } else if (RegExp(r'^\d+$').hasMatch(qrData)) {
        return 'QR Type: Numeric\nData: $qrData\nStatus: Number detected';
      } else {
        return 'QR Type: Text\nData: $qrData\nStatus: Text content scanned';
      }
    } catch (e) {
      return 'Error processing QR data: $e';
    }
  }
}