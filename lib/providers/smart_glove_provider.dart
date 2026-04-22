// lib/providers/smart_glove_provider.dart
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import '../services/realtime_db_service.dart';
import '../services/text_to_speech_service.dart';
import '../models/gesture_data_model.dart';

class SmartGloveProvider extends ChangeNotifier {
  final RealtimeDBService _realtimeDB = RealtimeDBService();
  final TextToSpeechService _ttsService = TextToSpeechService();
  
  // State variables
  bool _isConnected = false;
  bool _isProcessing = false;
  bool _isEsp32Connected = false;
  int _batteryLevel = 0;
  double _batteryVoltage = 0.0;
  int _latency = 0;
  String _sensorStatus = '';
  String _firmwareVersion = '';
  double _systemEfficiency = 0.0;
  int _wifiStrength = 0;
  int _uptime = 0;
  String _lastSeen = '';
  TranslationResult? _lastTranslation;
  List<TranslationResult> _translationHistory = [];
  String _connectionStatus = 'Disconnected';
  
  // Voice settings state
  String _currentVoiceGender = 'male'; // 'male' or 'female'
  String _currentLanguageCode = 'id'; // 'id' for Indonesian, 'en' for English
  
  // Getters
  bool get isConnected => _isConnected;
  bool get isProcessing => _isProcessing;
  bool get isEsp32Connected => _isEsp32Connected;
  int get batteryLevel => _batteryLevel;
  double get batteryVoltage => _batteryVoltage;
  int get latency => _latency;
  String get sensorStatus => _sensorStatus;
  String get firmwareVersion => _firmwareVersion;
  double get systemEfficiency => _systemEfficiency;
  int get wifiStrength => _wifiStrength;
  int get uptime => _uptime;
  String get lastSeen => _lastSeen;
  TranslationResult? get lastTranslation => _lastTranslation;
  List<TranslationResult> get translationHistory => _translationHistory;
  String get connectionStatus => _connectionStatus;
  String get currentVoiceGender => _currentVoiceGender;
  String get currentLanguageCode => _currentLanguageCode;
  
  SmartGloveProvider() {
    _initRealtimeListener();
    _initDeviceStatusListener();
  }
  
  void _initRealtimeListener() {
    _realtimeDB.translationStream.listen((result) {
      _lastTranslation = result;
      _translationHistory.insert(0, result);
      
      if (result.isSuccess && result.text.isNotEmpty) {
        // Gunakan pengaturan suara saat ini
        _ttsService.speakWithLanguageAndGender(
          result.text, 
          _currentLanguageCode, 
          _currentVoiceGender
        );
        _triggerHapticFeedback();
      }
      
      notifyListeners();
    });
  }
  
  void _triggerHapticFeedback() {
    HapticFeedback.lightImpact();
  }
  
  void _initDeviceStatusListener() {
    _realtimeDB.statusStream.listen((status) {
      _isEsp32Connected = status['is_connected'] ?? false;
      _batteryLevel = status['battery_level'] ?? 0;
      _batteryVoltage = (status['battery_voltage'] ?? 0.0).toDouble();
      _firmwareVersion = status['firmware_version'] ?? '';
      _latency = status['latency'] ?? 0;
      _sensorStatus = status['sensor_status'] ?? '';
      _systemEfficiency = (status['system_efficiency'] ?? 0) / 100;
      _wifiStrength = status['wifi_strength'] ?? 0;
      _uptime = status['uptime'] ?? 0;
      _lastSeen = status['last_seen'] ?? '';
      _connectionStatus = _isEsp32Connected 
          ? 'ESP32 Connected • $_batteryLevel%' 
          : 'Waiting for ESP32';
      notifyListeners();
    });
  }
  
  /// Memulai koneksi ke Realtime Database
  Future<void> connect() async {
    _connectionStatus = 'Connecting to Firebase...';
    notifyListeners();
    
    try {
      _isConnected = await _realtimeDB.checkConnection();
      _connectionStatus = _isConnected ? 'Connected to Firebase' : 'Failed to connect';
      
      if (_isConnected) {
        _realtimeDB.listenToTranslations();
        _realtimeDB.listenToDeviceStatus();
        debugPrint('Realtime Database connected successfully');
      }
    } catch (e) {
      _connectionStatus = 'Error: $e';
      _isConnected = false;
      debugPrint('Connection error: $e');
    }
    
    notifyListeners();
  }
  
  /// Memainkan text-to-speech untuk teks tertentu (dengan pengaturan saat ini)
  Future<void> speakTranslation(String text) async {
    if (text.isEmpty) return;
    await _ttsService.speakWithLanguageAndGender(text, _currentLanguageCode, _currentVoiceGender);
  }
  
  /// Memainkan text-to-speech dengan bahasa dan gender tertentu
  Future<void> speakTranslationWithLanguage(String text, String languageCode) async {
    if (text.isEmpty) return;
    await _ttsService.speakWithLanguageAndGender(text, languageCode, _currentVoiceGender);
  }
  
  /// Memainkan text-to-speech dengan bahasa dan gender spesifik
  Future<void> speakWithCustomSettings(String text, String languageCode, String gender) async {
    if (text.isEmpty) return;
    await _ttsService.speakWithLanguageAndGender(text, languageCode, gender);
  }
  
  /// Update voice gender (male/female)
  Future<void> updateVoiceGender(String gender) async {
    _currentVoiceGender = gender;
    await _ttsService.setVoiceGender(gender);
    debugPrint('Voice gender updated to: $gender');
    notifyListeners();
  }
  
  /// Update voice language
  Future<void> updateVoiceLanguage(String languageCode) async {
    _currentLanguageCode = languageCode;
    await _ttsService.setLanguage(languageCode);
    debugPrint('Voice language updated to: $languageCode');
    notifyListeners();
  }
  
  /// Update both voice gender and language
  Future<void> updateVoiceSettings({required String gender, required String languageCode}) async {
    _currentVoiceGender = gender;
    _currentLanguageCode = languageCode;
    await _ttsService.setVoiceGender(gender);
    await _ttsService.setLanguage(languageCode);
    debugPrint('Voice settings updated - Gender: $gender, Language: $languageCode');
    notifyListeners();
  }
  
  /// Menghentikan text-to-speech
  Future<void> stopSpeaking() async {
    await _ttsService.stop();
  }
  
  /// Mendapatkan riwayat terjemahan
  Future<void> loadHistory() async {
    final history = await _realtimeDB.getTranslationHistory();
    _translationHistory = history;
    notifyListeners();
  }
  
  /// Mendapatkan teks terjemahan terbaru
  String getCurrentTranslation() {
    return _lastTranslation?.text ?? '';
  }
  
  void disconnect() {
    _isConnected = false;
    _connectionStatus = 'Disconnected';
    notifyListeners();
  }
  
  @override
  void dispose() {
    _realtimeDB.dispose();
    _ttsService.dispose();
    super.dispose();
  }
}