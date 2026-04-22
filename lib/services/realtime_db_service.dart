import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import '../models/gesture_data_model.dart';

/// Service untuk komunikasi dengan Firebase Realtime Database
/// ESP32 akan menulis data mentah ke sini, dan AI server akan membaca
class RealtimeDBService {
  static final FirebaseDatabase database = FirebaseDatabase.instance;
  
  // Reference ke node gesture data
  final DatabaseReference _gestureRef = database.ref('gesture_data');
  
  // Reference untuk hasil terjemahan
  final DatabaseReference _translationRef = database.ref('translations');
  
  // Reference untuk status perangkat
  final DatabaseReference _statusRef = database.ref('device_status');
  
  // Stream controller untuk hasil terjemahan real-time
  final StreamController<TranslationResult> _translationController =
      StreamController<TranslationResult>.broadcast();
  
  // Stream controller untuk status perangkat
  final StreamController<Map<String, dynamic>> _statusController =
      StreamController<Map<String, dynamic>>.broadcast();
  
  Stream<TranslationResult> get translationStream => _translationController.stream;
  Stream<Map<String, dynamic>> get statusStream => _statusController.stream;
  
  /// Mendengarkan status perangkat (ESP32)
  void listenToDeviceStatus() {
    _statusRef.onValue.listen((event) {
      if (event.snapshot.value != null) {
        final status = Map<String, dynamic>.from(event.snapshot.value as Map);
        
        // Extract data sesuai dengan struktur JSON dari ESP32
        final deviceStatus = {
          'is_connected': status['is_connected'] ?? false,
          'battery_level': status['battery_level'] ?? 0,
          'battery_voltage': (status['battery_voltage'] ?? 0.0).toDouble(),
          'firmware_version': status['firmware_version'] ?? '',
          'sensor_status': status['sensor_status'] ?? '',
          'latency': status['latency'] ?? 0,
          'system_efficiency': status['system_efficiency'] ?? 0,
          'wifi_strength': status['wifi_strength'] ?? 0,
          'uptime': status['uptime'] ?? 0,
          'last_seen': status['last_seen'] ?? '',
        };
        
        _statusController.add(deviceStatus);
      }
    });
  }
  
  /// Mendengarkan data mentah dari ESP32 (untuk debugging/monitoring)
  Stream<RawGestureData> listenToRawData() {
    return _gestureRef.onChildAdded.map((event) {
      final data = Map<String, dynamic>.from(event.snapshot.value as Map);
      return RawGestureData.fromJson(data, event.snapshot.key ?? '');
    });
  }
  
  /// Mendengarkan hasil terjemahan dari AI server
  void listenToTranslations() {
    _translationRef.onChildAdded.listen((event) {
      final data = Map<String, dynamic>.from(event.snapshot.value as Map);
      final result = TranslationResult.fromJson(data);
      _translationController.add(result);
    });
    
    _translationRef.onChildChanged.listen((event) {
      final data = Map<String, dynamic>.from(event.snapshot.value as Map);
      final result = TranslationResult.fromJson(data);
      _translationController.add(result);
    });
  }
  
  /// Mengirim hasil terjemahan (dari AI server ke app)
  Future<void> sendTranslationResult(TranslationResult result) async {
    final newRef = _translationRef.push();
    await newRef.set(result.toJson());
  }
  
  /// Mendapatkan riwayat terjemahan
  Future<List<TranslationResult>> getTranslationHistory({int limit = 50}) async {
    final snapshot = await _translationRef
        .orderByKey()
        .limitToLast(limit)
        .get();
    
    if (!snapshot.exists) return [];
    
    final results = <TranslationResult>[];
    final data = Map<String, dynamic>.from(snapshot.value as Map);
    
    data.forEach((key, value) {
      results.add(TranslationResult.fromJson(Map<String, dynamic>.from(value)));
    });
    
    return results.reversed.toList();
  }
  
  /// Mengecek koneksi ke Realtime Database
  Future<bool> checkConnection() async {
    try {
      final connectedRef = database.ref('.info/connected');
      final snapshot = await connectedRef.get();
      return snapshot.value == true;
    } catch (e) {
      return false;
    }
  }
  
  /// Mengupdate status perangkat (dipanggil oleh ESP32)
  Future<void> updateDeviceStatus({
    required bool isConnected,
    required int batteryLevel,
    required String firmwareVersion,
    double batteryVoltage = 0.0,
    String sensorStatus = '',
    int latency = 0,
    int systemEfficiency = 0,
    int wifiStrength = 0,
    int uptime = 0,
  }) async {
    await _statusRef.set({
      'is_connected': isConnected,
      'battery_level': batteryLevel,
      'battery_voltage': batteryVoltage,
      'firmware_version': firmwareVersion,
      'sensor_status': sensorStatus,
      'latency': latency,
      'system_efficiency': systemEfficiency,
      'wifi_strength': wifiStrength,
      'uptime': uptime,
      'last_seen': DateTime.now().toIso8601String(),
    });
  }
  
  void dispose() {
    _translationController.close();
    _statusController.close();
  }
}