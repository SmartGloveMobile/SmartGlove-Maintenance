/// Model untuk data mentah dari ESP32
class RawGestureData {
  final List<double> flexSensorValues; // 5 jari
  final double accelX, accelY, accelZ;  // Akselerasi
  final double gyroX, gyroY, gyroZ;     // Gyroscope
  final double magX, magY, magZ;        // Magnetometer
  final DateTime timestamp;
  
  RawGestureData({
    required this.flexSensorValues,
    required this.accelX,
    required this.accelY,
    required this.accelZ,
    required this.gyroX,
    required this.gyroY,
    required this.gyroZ,
    required this.magX,
    required this.magY,
    required this.magZ,
    required this.timestamp,
  });
  
  /// Konversi ke format untuk dikirim ke AI Server
  Map<String, dynamic> toJson() {
    return {
      'flex_sensors': flexSensorValues,
      'accel': [accelX, accelY, accelZ],
      'gyro': [gyroX, gyroY, gyroZ],
      'mag': [magX, magY, magZ],
      'timestamp': timestamp.toIso8601String(),
    };
  }
  
  /// Dari JSON yang diterima dari ESP32 via Realtime Database
  factory RawGestureData.fromJson(Map<String, dynamic> json, String timestamp) {
    return RawGestureData(
      flexSensorValues: List<double>.from(json['flex'] ?? [0,0,0,0,0]),
      accelX: (json['accel_x'] ?? 0.0).toDouble(),
      accelY: (json['accel_y'] ?? 0.0).toDouble(),
      accelZ: (json['accel_z'] ?? 0.0).toDouble(),
      gyroX: (json['gyro_x'] ?? 0.0).toDouble(),
      gyroY: (json['gyro_y'] ?? 0.0).toDouble(),
      gyroZ: (json['gyro_z'] ?? 0.0).toDouble(),
      magX: (json['mag_x'] ?? 0.0).toDouble(),
      magY: (json['mag_y'] ?? 0.0).toDouble(),
      magZ: (json['mag_z'] ?? 0.0).toDouble(),
      timestamp: DateTime.parse(timestamp),
    );
  }
}

/// Model untuk hasil terjemahan dari AI
class TranslationResult {
  final String text;                    // Teks terjemahan
  final String predictedGesture;       // Nama gesture yang dikenali
  final double confidenceScore;        // Skor kepercayaan
  final DateTime timestamp;            // Waktu terjemahan
  final bool isSuccess;                // Apakah gesture dikenali?
  final String errorMessage;           // Pesan error jika ada
  
  TranslationResult({
    required this.text,
    required this.predictedGesture,
    required this.confidenceScore,
    required this.timestamp,
    this.isSuccess = true,
    this.errorMessage = '',
  });
  
  factory TranslationResult.fromJson(Map<String, dynamic> json) {
    return TranslationResult(
      text: json['text'] ?? json['hasil_prediksi'] ?? '',
      predictedGesture: json['gesture'] ?? 'Unknown',
      confidenceScore: (json['confidence'] ?? 0.0).toDouble(),
      timestamp: DateTime.parse(json['timestamp'] ?? DateTime.now().toIso8601String()),
      isSuccess: json['success'] ?? true,
      errorMessage: json['error'] ?? '',
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'gesture': predictedGesture,
      'confidence': confidenceScore,
      'timestamp': timestamp.toIso8601String(),
      'success': isSuccess,
      'error': errorMessage,
    };
  }
}