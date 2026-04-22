import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/gesture_data_model.dart';

class CloudAIService {
  // Ganti dengan endpoint AI server yang sesungguhnya
  static const String baseUrl = 'https://your-ai-server.com/api';
  
  // Untuk development, gunakan mock data
  static const bool useMockData = true;
  
  /// Mengirim data gesture ke AI server untuk diproses
  Future<TranslationResult> recognizeGesture(RawGestureData gestureData) async {
    // Untuk development, gunakan mock data
    if (useMockData) {
      await Future.delayed(const Duration(milliseconds: 300));
      
      final mockText = _getMockTranslation(gestureData.flexSensorValues);
      final mockConfidence = 0.85 + (DateTime.now().millisecond % 15) / 100;
      
      return TranslationResult(
        text: mockText,
        predictedGesture: mockText.toLowerCase(),
        confidenceScore: mockConfidence,
        timestamp: DateTime.now(),
        isSuccess: true,
      );
    }
    
    // Real API call
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/predict'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(gestureData.toJson()),
      );
      
      if (response.statusCode == 200) {
        return TranslationResult.fromJson(jsonDecode(response.body));
      } else {
        return TranslationResult(
          text: 'Gagal mengenali gesture',
          predictedGesture: 'unknown',
          confidenceScore: 0.0,
          timestamp: DateTime.now(),
          isSuccess: false,
          errorMessage: 'Server error: ${response.statusCode}',
        );
      }
    } catch (e) {
      return TranslationResult(
        text: 'Koneksi ke server gagal',
        predictedGesture: 'unknown',
        confidenceScore: 0.0,
        timestamp: DateTime.now(),
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }
  
  /// Mock translation berdasarkan nilai flex sensor (untuk testing)
  String _getMockTranslation(List<double> flexValues) {
    if (flexValues.length < 5) return 'Belajar';
    
    // Simulasi pengenalan gesture berdasarkan nilai flex sensor
    // Nilai 0 = lurus, 100 = bengkok penuh
    if (flexValues[0] > 80 && flexValues[1] > 80 && flexValues[2] > 80) {
      return 'Terima Kasih';
    } else if (flexValues[0] > 70 && flexValues[3] > 70) {
      return 'Halo';
    } else if (flexValues[2] > 90 && flexValues[4] > 90) {
      return 'Tolong';
    } else if (flexValues[1] > 85) {
      return 'Makan';
    } else if (flexValues[0] > 50 && flexValues[1] > 50 && flexValues[2] > 50 && flexValues[3] > 50 && flexValues[4] > 50) {
      return 'Semua jari bengkok';
    } else {
      return 'Belajar';
    }
  }
}