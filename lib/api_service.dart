import 'dart:async';

class ApiService {
  static Future<String> sendQrData(String qrData) async {
    // Simulate API call
    await Future.delayed(Duration(seconds: 2));
    // Replace this with actual API logic
    // final response = await http.post(...);
    // return response.body or parsed info

    // Mock response
    return 'API Info for QR:\nData: $qrData\nType: Example\nValid: Yes';
  }
}