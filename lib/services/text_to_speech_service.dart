// lib/services/text_to_speech_service.dart
import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeechService {
  final FlutterTts _flutterTts = FlutterTts();
  String _currentLanguage = 'id';
  String _currentGender = 'male';
  List<dynamic>? _voices;
  
  TextToSpeechService() {
    _initTts();
  }
  
  Future<void> _initTts() async {
    await _flutterTts.setLanguage(_currentLanguage);
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.setVolume(1.0);
    await _loadVoices();
    await _applyVoiceByGender();
  }
  
  /// Load available voices
  Future<void> _loadVoices() async {
    try {
      _voices = await _flutterTts.getVoices;
      if (_voices != null) {
        debugPrint('Available voices count: ${_voices!.length}');
        // Tampilkan voice yang tersedia tanpa casting
        for (var i = 0; i < _voices!.length; i++) {
          final voice = _voices![i] as Map;
          debugPrint('Voice $i - Name: ${voice['name']}, Locale: ${voice['locale']}');
        }
      }
    } catch (e) {
      debugPrint('Error loading voices: $e');
    }
  }
  
  /// Apply voice based on gender and language
  Future<void> _applyVoiceByGender() async {
    if (_voices == null || _voices!.isEmpty) {
      debugPrint('No voices available, using pitch adjustment');
      await _setPitchByGender();
      return;
    }
    
    final targetLanguage = _currentLanguage == 'id' ? 'id' : 'en';
    final targetGender = _currentGender == 'female' ? 'female' : 'male';
    
    try {
      // Cari voice yang sesuai
      for (var voiceData in _voices!) {
        final voice = voiceData as Map;
        final name = voice['name']?.toString().toLowerCase() ?? '';
        final locale = voice['locale']?.toString().toLowerCase() ?? '';
        
        if (locale.contains(targetLanguage)) {
          if (targetGender == 'female' && 
              (name.contains('female') || name.contains('woman') || 
               name.contains('f') || name.contains('perempuan'))) {
            await _flutterTts.setVoice(voice as Map<String, String>);
            debugPrint('Set female voice: ${voice['name']}');
            return;
          } else if (targetGender == 'male' && 
                     (name.contains('male') || name.contains('man') || 
                      name.contains('m') || name.contains('laki'))) {
            await _flutterTts.setVoice(voice as Map<String, String>);
            debugPrint('Set male voice: ${voice['name']}');
            return;
          }
        }
      }
      
      // Fallback ke pitch adjustment
      debugPrint('No matching voice found, using pitch adjustment');
      await _setPitchByGender();
      
    } catch (e) {
      debugPrint('Error setting voice: $e, using pitch adjustment');
      await _setPitchByGender();
    }
  }
  
  /// Adjust pitch based on gender
  Future<void> _setPitchByGender() async {
    if (_currentGender == 'female') {
      await _flutterTts.setPitch(1.4);
      await _flutterTts.setSpeechRate(0.55);
      debugPrint('Set female pitch: 1.4');
    } else {
      await _flutterTts.setPitch(0.9);
      await _flutterTts.setSpeechRate(0.5);
      debugPrint('Set male pitch: 0.9');
    }
  }
  
  /// Set language for TTS
  Future<void> setLanguage(String languageCode) async {
    _currentLanguage = languageCode;
    await _flutterTts.setLanguage(languageCode);
    await _applyVoiceByGender();
  }
  
  /// Set voice gender
  Future<void> setVoiceGender(String gender) async {
    _currentGender = gender;
    await _applyVoiceByGender();
  }
  
  /// Speak with specific language and gender
  Future<void> speakWithLanguageAndGender(String text, String languageCode, String gender) async {
    if (text.isEmpty) return;
    
    _currentLanguage = languageCode;
    _currentGender = gender;
    
    await _flutterTts.setLanguage(languageCode);
    await _applyVoiceByGender();
    await _flutterTts.speak(text);
  }
  
  /// Speak text with current settings
  Future<void> speak(String text) async {
    if (text.isEmpty) return;
    await _flutterTts.speak(text);
  }
  
  Future<void> stop() async {
    await _flutterTts.stop();
  }
  
  void dispose() {
    _flutterTts.stop();
  }
}