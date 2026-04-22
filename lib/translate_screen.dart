import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../providers/smart_glove_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const TranslatePage(),
    );
  }
}

// ==================== COLORS ====================
class AppColors {
  static const primary = Color(0xFF004D64);
  static const secondary = Color(0xFF006684);
  static const teal = Color(0xFF006A6A);
  static const lightTeal = Color(0xFF9DEEED);
  static const darkTeal = Color(0xFF0B6E6E);
  static const background = Color(0xFFF8F9FA);
  static const headerBg = Color(0xFFE7E8E9);
  static const cardBg = Color(0xFFF2F4F5);
  static const white = Colors.white;
  static const textDark = Color(0xFF191C1D);
  static const textGray = Color(0xFF3F484D);
  static const textLight = Color(0xFF40484B);
  static const statusLight = Color(0xFFBEE9FF);
  static const borderColor = Color(0x19BFC8CD);
  static const mintTeal = Color(0xFFA0F0F0);
  static const deepTeal = Color(0xFF004F4F);
}

// ==================== TEXT STYLES ====================
class AppTextStyles {
  static const lexendW900_20 = TextStyle(
    fontFamily: 'Lexend',
    fontWeight: FontWeight.w900,
    fontSize: 20,
    height: 1.4,
    letterSpacing: -0.5,
  );

  static const lexendW700_20 = TextStyle(
    fontFamily: 'Lexend',
    fontWeight: FontWeight.w700,
    fontSize: 20,
    height: 1.4,
  );

  static const lexendW700_24 = TextStyle(
    fontFamily: 'Lexend',
    fontWeight: FontWeight.w700,
    fontSize: 24,
    height: 1.33,
  );

  static const lexendW400_36 = TextStyle(
    fontFamily: 'Lexend',
    fontWeight: FontWeight.w400,
    fontSize: 36,
    height: 1.11,
    letterSpacing: -0.9,
  );

  static const lexendW900_48 = TextStyle(
    fontFamily: 'Lexend',
    fontWeight: FontWeight.w900,
    fontSize: 48,
    height: 1,
  );

  static const lexendW600_14 = TextStyle(
    fontFamily: 'Lexend',
    fontWeight: FontWeight.w600,
    fontSize: 14,
    height: 1.43,
    letterSpacing: -0.35,
  );

  static const lexendW700_12 = TextStyle(
    fontFamily: 'Lexend',
    fontWeight: FontWeight.w700,
    fontSize: 12,
    height: 1.33,
  );

  static const lexendW700_16 = TextStyle(
    fontFamily: 'Lexend',
    fontWeight: FontWeight.w700,
    fontSize: 16,
    height: 1.5,
  );

  static const lexendW600_16 = TextStyle(
    fontFamily: 'Lexend',
    fontWeight: FontWeight.w600,
    fontSize: 16,
    height: 1.5,
  );

  static const lexendW700_18 = TextStyle(
    fontFamily: 'Lexend',
    fontWeight: FontWeight.w700,
    fontSize: 18,
    height: 1.56,
  );

  static const publicSansW400_16 = TextStyle(
    fontFamily: 'Public Sans',
    fontWeight: FontWeight.w400,
    fontSize: 16,
    height: 1.5,
  );

  static const publicSansW500_14 = TextStyle(
    fontFamily: 'Public Sans',
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 1.43,
  );

  static const publicSansW500_12 = TextStyle(
    fontFamily: 'Public Sans',
    fontWeight: FontWeight.w500,
    fontSize: 12,
    height: 1.33,
  );

  static const publicSansW400_10 = TextStyle(
    fontFamily: 'Public Sans',
    fontWeight: FontWeight.w400,
    fontSize: 10,
    height: 1.5,
    letterSpacing: 1,
  );

  static const publicSansW700_10 = TextStyle(
    fontFamily: 'Public Sans',
    fontWeight: FontWeight.w700,
    fontSize: 10,
    height: 1.5,
    letterSpacing: 1,
  );

  static const publicSansW400_14Italic = TextStyle(
    fontFamily: 'Public Sans',
    fontWeight: FontWeight.w400,
    fontSize: 14,
    fontStyle: FontStyle.italic,
    height: 1.43,
  );

  static const publicSansW500_14Status = TextStyle(
    fontFamily: 'Public Sans',
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 1.43,
    letterSpacing: 1.4,
  );
}

// ==================== ENUM FOR VOICE SETTINGS ====================
enum VoiceGender { male, female }
enum TargetLanguage { indonesian, english }

extension VoiceGenderExtension on VoiceGender {
  String get displayName {
    switch (this) {
      case VoiceGender.male:
        return 'Pria';
      case VoiceGender.female:
        return 'Wanita';
    }
  }
  
  IconData get icon {
    switch (this) {
      case VoiceGender.male:
        return Icons.man_rounded;
      case VoiceGender.female:
        return Icons.woman_rounded;
    }
  }
}

extension TargetLanguageExtension on TargetLanguage {
  String get displayName {
    switch (this) {
      case TargetLanguage.indonesian:
        return 'Bahasa Indonesia';
      case TargetLanguage.english:
        return 'English';
    }
  }
  
  String get code {
    switch (this) {
      case TargetLanguage.indonesian:
        return 'id';
      case TargetLanguage.english:
        return 'en';
    }
  }
  
  String get flag {
    switch (this) {
      case TargetLanguage.indonesian:
        return '🇮🇩';
      case TargetLanguage.english:
        return '🇬🇧';
    }
  }
}

// ==================== MAIN PAGE ====================
class TranslatePage extends StatefulWidget {
  const TranslatePage({super.key});

  @override
  State<TranslatePage> createState() => _TranslatePageState();
}

class _TranslatePageState extends State<TranslatePage> {
  String _currentTranslation = '';
  String _originalTranslation = '';
  List<String> _translationHistory = [];
  bool _isListening = false;
  late Stream<QuerySnapshot> _translationStream;
  
  VoiceGender _selectedGender = VoiceGender.male;
  TargetLanguage _selectedLanguage = TargetLanguage.indonesian;
  
  @override
  void initState() {
    super.initState();
    _loadLastTranslation();
    _setupTranslationStream();
  }
  
  void _setupTranslationStream() {
    _translationStream = FirebaseFirestore.instance
        .collection('prediksi')
        .orderBy('waktu', descending: true)
        .limit(1)
        .snapshots();
  }
  
  Future<void> _loadLastTranslation() async {
    try {
      final firestore = FirebaseFirestore.instance;
      final snapshot = await firestore
          .collection('prediksi')
          .orderBy('waktu', descending: true)
          .limit(1)
          .get();
      
      if (snapshot.docs.isNotEmpty && mounted) {
        setState(() {
          _originalTranslation = snapshot.docs.first['hasil_prediksi'] ?? '';
          _currentTranslation = _translateText(_originalTranslation);
        });
      }
    } catch (e) {
      debugPrint('Error loading translation: $e');
    }
  }
  
  String _translateText(String text) {
    if (_selectedLanguage == TargetLanguage.indonesian) {
      return text;
    } else {
      final translations = {
        'halo': 'hello',
        'salam': 'greeting',
        'terima kasih': 'thank you',
        'tolong': 'help',
        'bantuan': 'help',
        'makan': 'eat',
        'makanan': 'food',
        'air': 'water',
        'minum': 'drink',
        'belajar': 'learn',
      };
      
      String lowerText = text.toLowerCase();
      for (var entry in translations.entries) {
        if (lowerText.contains(entry.key)) {
          return text.replaceAll(entry.key, entry.value);
        }
      }
      return text;
    }
  }
  
  void _updateTranslation(String newOriginal) {
    setState(() {
      _originalTranslation = newOriginal;
      _currentTranslation = _translateText(newOriginal);
      _translationHistory.insert(0, _currentTranslation);
      if (_translationHistory.length > 10) {
        _translationHistory.removeLast();
      }
    });
    _triggerHapticFeedback();
  }
  
  void _startListening() {
    final provider = Provider.of<SmartGloveProvider>(context, listen: false);
    
    if (!provider.isEsp32Connected) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('❌ ESP32 tidak terhubung! Periksa koneksi.'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    
    setState(() {
      _isListening = true;
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('🎤 Mendengarkan gesture... Lakukan gerakan pada smart glove.'),
        backgroundColor: AppColors.teal,
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
    
    _listenToRealtimeTranslations();
  }
  
  void _listenToRealtimeTranslations() {
    _translationStream.listen((snapshot) {
      if (snapshot.docs.isNotEmpty && mounted) {
        final newTranslation = snapshot.docs.first['hasil_prediksi'] ?? '';
        if (newTranslation != _originalTranslation && newTranslation.isNotEmpty) {
          _updateTranslation(newTranslation);
        }
      }
    });
  }
  
  void _triggerHapticFeedback() {
    HapticFeedback.lightImpact();
  }
  
  void _stopListening() {
    setState(() {
      _isListening = false;
    });
  }
  
  void _copyToClipboard() {
    if (_currentTranslation.isNotEmpty) {
      Clipboard.setData(ClipboardData(text: _currentTranslation));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('📋 Teks disalin ke clipboard'),
          duration: Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
  
  void _shareTranslation() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('🔗 Fitur berbagi akan segera hadir'),
        duration: Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
  
  void _speakTranslation() {
    final provider = Provider.of<SmartGloveProvider>(context, listen: false);
    if (_currentTranslation.isNotEmpty) {
      final languageCode = _selectedLanguage.code;
      provider.speakTranslationWithLanguage(_currentTranslation, languageCode);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tidak ada teks untuk dibacakan'),
          duration: Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
  
  void _showHistory() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          height: 400,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Riwayat Terjemahan',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Lexend',
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: _translationHistory.isEmpty
                    ? const Center(
                        child: Text('Belum ada riwayat terjemahan'),
                      )
                    : ListView.builder(
                        itemCount: _translationHistory.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: const Icon(Icons.translate, color: AppColors.teal),
                            title: Text(_translationHistory[index]),
                            trailing: IconButton(
                              icon: const Icon(Icons.volume_up, size: 18),
                              onPressed: () {
                                final provider = Provider.of<SmartGloveProvider>(
                                  context,
                                  listen: false,
                                );
                                provider.speakTranslationWithLanguage(
                                  _translationHistory[index],
                                  _selectedLanguage.code,
                                );
                              },
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SmartGloveProvider>(context);
    
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          HeaderSection(
            isEsp32Connected: provider.isEsp32Connected,
            batteryLevel: provider.batteryLevel,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 32),
                  const TitleSection(),
                  const SizedBox(height: 48),
                  ActiveStreamCard(
                    isListening: _isListening,
                    latency: provider.latency,
                    onStartListening: _startListening,
                    onStopListening: _stopListening,
                    isEsp32Connected: provider.isEsp32Connected,
                  ),
                  const SizedBox(height: 24),
                  TranslationOutputCard(
                    translationText: _currentTranslation,
                    onCopy: _copyToClipboard,
                    onShare: _shareTranslation,
                    onSpeak: _speakTranslation,
                    onHistory: _showHistory,
                  ),
                  const SizedBox(height: 24),
                  GloveHealthCard(
                    flexSensorHealth: provider.sensorStatus == 'OPTIMAL' ? 1.0 : 0.5,
                    imuPrecision: provider.isEsp32Connected ? 0.9 : 0.0,
                  ),
                  const SizedBox(height: 24),
                  VoiceSettingsCard(
                    selectedGender: _selectedGender,
                    selectedLanguage: _selectedLanguage,
                    onGenderChanged: (gender) {
                      setState(() {
                        _selectedGender = gender;
                      });
                      final provider = Provider.of<SmartGloveProvider>(
                        context,
                        listen: false,
                      );
                      provider.updateVoiceGender(gender == VoiceGender.male ? 'male' : 'female');
                    },
                    onLanguageChanged: (language) {
                      setState(() {
                        _selectedLanguage = language;
                        _currentTranslation = _translateText(_originalTranslation);
                      });
                      final provider = Provider.of<SmartGloveProvider>(
                        context,
                        listen: false,
                      );
                      provider.updateVoiceLanguage(language.code);
                    },
                  ),
                  const SizedBox(height: 24),
                  const AdvancedAIBanner(),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ==================== HEADER SECTION ====================
class HeaderSection extends StatelessWidget {
  final bool isEsp32Connected;
  final int batteryLevel;
  
  const HeaderSection({
    super.key,
    required this.isEsp32Connected,
    required this.batteryLevel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.headerBg,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 12,
        bottom: 16,
        left: 24,
        right: 24,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildLogo(),
          _buildConnectionStatus(),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: AppColors.teal,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.front_hand_outlined,
            color: Colors.white,
            size: 20,
          ),
        ),
        const SizedBox(width: 8),
        const Text(
          'Smart\nGlove',
          style: AppTextStyles.lexendW900_20,
        ),
      ],
    );
  }

  Widget _buildConnectionStatus() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: isEsp32Connected ? AppColors.teal : Colors.red,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            isEsp32Connected 
                ? 'ESP32 Terhubung • $batteryLevel%'
                : 'Menunggu ESP32...',
            style: AppTextStyles.lexendW600_14,
          ),
        ],
      ),
    );
  }
}

// ==================== TITLE SECTION ====================
class TitleSection extends StatelessWidget {
  const TitleSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Menerjemahkan\nGerakan ke Suara.',
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 36,
            fontFamily: 'Lexend',
            fontWeight: FontWeight.w400,
            height: 1.25,
          ),
        ),
        SizedBox(height: 16),
        Text(
          'Sarung tangan pintar Anda aktif. Lakukan gerakan sekarang untuk\npenerjemahan waktu nyata.',
          style: TextStyle(
            color: AppColors.textGray,
            fontSize: 18,
            fontFamily: 'Public Sans',
            fontWeight: FontWeight.w400,
            height: 1.56,
          ),
        ),
      ],
    );
  }
}

// ---- Active Stream Card ----
class ActiveStreamCard extends StatelessWidget {
  final bool isListening;
  final int latency;
  final VoidCallback onStartListening;
  final VoidCallback onStopListening;
  final bool isEsp32Connected;
  
  const ActiveStreamCard({
    super.key,
    required this.isListening,
    required this.latency,
    required this.onStartListening,
    required this.onStopListening,
    required this.isEsp32Connected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.borderColor),
        borderRadius: BorderRadius.circular(48),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0C191C1D),
            blurRadius: 40,
            offset: Offset(0, -10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    isListening ? Icons.graphic_eq : Icons.pause_circle_outline,
                    color: isEsp32Connected ? AppColors.teal : Colors.grey,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    isListening ? 'STREAM AKTIF' : 'STREAM BERHENTI',
                    style: TextStyle(
                      color: isEsp32Connected ? AppColors.teal : Colors.grey,
                      fontSize: 14,
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.4,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: isEsp32Connected ? AppColors.lightTeal : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Text(
                  'Latensi: ${isEsp32Connected ? latency : '--'}ms',
                  style: TextStyle(
                    color: isEsp32Connected ? AppColors.darkTeal : Colors.grey,
                    fontSize: 12,
                    fontFamily: 'Public Sans',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          GestureDetector(
            onTap: isEsp32Connected 
                ? (isListening ? onStopListening : onStartListening)
                : null,
            child: Container(
              width: double.infinity,
              height: 120,
              decoration: BoxDecoration(
                color: isEsp32Connected ? AppColors.cardBg : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(32),
              ),
              child: isListening
                  ? const WaveformWidget(isActive: true)
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.play_circle_outline,
                            size: 48,
                            color: isEsp32Connected ? AppColors.teal : Colors.grey,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            isEsp32Connected ? 'Ketuk untuk memulai' : 'Tunggu ESP32 terhubung',
                            style: TextStyle(
                              color: isEsp32Connected ? AppColors.teal : Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class WaveformWidget extends StatelessWidget {
  final bool isActive;
  
  const WaveformWidget({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    final bars = [
      {'h': 32.0, 'opacity': 0.4, 'color': AppColors.primary},
      {'h': 64.0, 'opacity': 0.6, 'color': AppColors.secondary},
      {'h': 96.0, 'opacity': 1.0, 'color': AppColors.teal},
      {'h': 128.0, 'opacity': 1.0, 'color': AppColors.mintTeal},
      {'h': 96.0, 'opacity': 1.0, 'color': AppColors.teal},
      {'h': 80.0, 'opacity': 0.8, 'color': AppColors.primary},
      {'h': 112.0, 'opacity': 0.6, 'color': AppColors.secondary},
      {'h': 48.0, 'opacity': 0.4, 'color': AppColors.primary},
      {'h': 96.0, 'opacity': 1.0, 'color': AppColors.teal},
      {'h': 64.0, 'opacity': 0.6, 'color': AppColors.secondary},
      {'h': 32.0, 'opacity': 0.4, 'color': AppColors.primary},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: bars.map((bar) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: 8,
          height: isActive ? bar['h'] as double : 20.0,
          decoration: BoxDecoration(
            color: (bar['color'] as Color).withOpacity(bar['opacity'] as double),
            borderRadius: BorderRadius.circular(9999),
          ),
        );
      }).toList(),
    );
  }
}

// ---- Translation Output Card ----
class TranslationOutputCard extends StatelessWidget {
  final String translationText;
  final VoidCallback onCopy;
  final VoidCallback onShare;
  final VoidCallback onSpeak;
  final VoidCallback onHistory;
  
  const TranslationOutputCard({
    super.key,
    required this.translationText,
    required this.onCopy,
    required this.onShare,
    required this.onSpeak,
    required this.onHistory,
  });

  @override
  Widget build(BuildContext context) {
    final displayText = translationText.isEmpty 
        ? 'Belum ada terjemahan\nLakukan gesture pada\nsmart glove untuk memulai'
        : translationText;
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.borderColor),
        borderRadius: BorderRadius.circular(48),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A191C1D),
            blurRadius: 40,
            offset: Offset(0, 20),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'HASIL\nTERJEMAHAN',
                style: TextStyle(
                  color: AppColors.textGray,
                  fontSize: 14,
                  fontFamily: 'Lexend',
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.4,
                  height: 1.43,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: onCopy,
                    icon: const Icon(Icons.copy_outlined, color: AppColors.textGray, size: 20),
                    padding: const EdgeInsets.all(8),
                    constraints: const BoxConstraints(),
                  ),
                  IconButton(
                    onPressed: onShare,
                    icon: const Icon(Icons.share_outlined, color: AppColors.textGray, size: 20),
                    padding: const EdgeInsets.all(8),
                    constraints: const BoxConstraints(),
                  ),
                  IconButton(
                    onPressed: onHistory,
                    icon: const Icon(Icons.history, color: AppColors.textGray, size: 20),
                    padding: const EdgeInsets.all(8),
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          Stack(
            children: [
              Text(
                displayText,
                style: TextStyle(
                  color: translationText.isEmpty ? AppColors.textGray : AppColors.textDark,
                  fontSize: translationText.isEmpty ? 24 : 30,
                  fontFamily: 'Lexend',
                  fontWeight: translationText.isEmpty ? FontWeight.w400 : FontWeight.w300,
                  height: 1.63,
                ),
              ),
              if (translationText.isNotEmpty)
                Positioned(
                  right: 0,
                  bottom: 8,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: 6,
                    height: 40,
                    color: AppColors.teal,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: onSpeak,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(9999),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.volume_up, color: Colors.white, size: 20),
                        SizedBox(width: 8),
                        Text(
                          'Putar Audio',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Lexend',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: onHistory,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  decoration: BoxDecoration(
                    color: AppColors.lightTeal,
                    borderRadius: BorderRadius.circular(9999),
                  ),
                  child: const Icon(Icons.history, color: AppColors.darkTeal, size: 22),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ---- Glove Health Card ----
class GloveHealthCard extends StatelessWidget {
  final double flexSensorHealth;
  final double imuPrecision;
  
  const GloveHealthCard({
    super.key,
    required this.flexSensorHealth,
    required this.imuPrecision,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.mintTeal,
        borderRadius: BorderRadius.circular(48),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Kesehatan Sarung Tangan',
                style: TextStyle(
                  color: Color(0xFF002020),
                  fontSize: 16,
                  fontFamily: 'Lexend',
                  fontWeight: FontWeight.w700,
                ),
              ),
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: AppColors.deepTeal.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  flexSensorHealth >= 0.8 && imuPrecision >= 0.8
                      ? Icons.check
                      : Icons.warning_amber_rounded,
                  color: AppColors.deepTeal,
                  size: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildHealthRow('SENSOR FLEKSI', '${(flexSensorHealth * 100).toInt()}%', flexSensorHealth),
          const SizedBox(height: 16),
          _buildHealthRow('PRESISI IMU', imuPrecision >= 0.8 ? 'Optimal' : 'Perlu Kalibrasi', imuPrecision),
        ],
      ),
    );
  }

  Widget _buildHealthRow(String label, String value, double progress) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Opacity(
              opacity: 0.6,
              child: Text(
                label,
                style: const TextStyle(
                  color: Color(0xFF002020),
                  fontSize: 12,
                  fontFamily: 'Public Sans',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                color: Color(0xFF002020),
                fontSize: 16,
                fontFamily: 'Lexend',
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          height: 8,
          decoration: BoxDecoration(
            color: AppColors.deepTeal.withOpacity(0.1),
            borderRadius: BorderRadius.circular(9999),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: progress,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.deepTeal,
                borderRadius: BorderRadius.circular(9999),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ==================== VOICE SETTINGS CARD (DIPERBAIKI) ====================
class VoiceSettingsCard extends StatelessWidget {
  final VoiceGender selectedGender;
  final TargetLanguage selectedLanguage;
  final Function(VoiceGender) onGenderChanged;
  final Function(TargetLanguage) onLanguageChanged;
  
  const VoiceSettingsCard({
    super.key,
    required this.selectedGender,
    required this.selectedLanguage,
    required this.onGenderChanged,
    required this.onLanguageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(48),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.teal.withOpacity(0.08),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(48),
                topRight: Radius.circular(48),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.teal.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(
                    Icons.record_voice_over_rounded,
                    color: AppColors.teal,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pengaturan Suara',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Lexend',
                          color: AppColors.textDark,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Sesuaikan suara dan bahasa output terjemahan',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textGray,
                          fontFamily: 'Public Sans',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Body
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Gender Selection
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: AppColors.borderColor),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(24),
                      onTap: () {
                        _showGenderSelectionDialog(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: AppColors.teal.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Center(
                                child: Icon(
                                  selectedGender.icon,
                                  color: AppColors.teal,
                                  size: 28,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Suara Natural',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Lexend',
                                      color: AppColors.textDark,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    selectedGender.displayName,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: AppColors.teal,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Lexend',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppColors.teal.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.chevron_right_rounded,
                                color: AppColors.teal,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Language Selection
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: AppColors.borderColor),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(24),
                      onTap: () {
                        _showLanguageSelectionDialog(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: AppColors.teal.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Center(
                                child: Text(
                                  selectedLanguage.flag,
                                  style: const TextStyle(fontSize: 32),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Bahasa Target',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Lexend',
                                      color: AppColors.textDark,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    selectedLanguage.displayName,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: AppColors.teal,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Lexend',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppColors.teal.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.chevron_right_rounded,
                                color: AppColors.teal,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  void _showGenderSelectionDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.borderColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              // Header
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: AppColors.borderColor),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Pilih Suara',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Lexend',
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: AppColors.cardBg,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(Icons.close, size: 18),
                      ),
                    ),
                  ],
                ),
              ),
              // Options
              _buildGenderOption(
                context: context,
                gender: VoiceGender.male,
                title: 'Pria',
                subtitle: 'Suara natural pria dewasa',
                icon: Icons.man_rounded,
              ),
              _buildGenderOption(
                context: context,
                gender: VoiceGender.female,
                title: 'Wanita',
                subtitle: 'Suara natural wanita dewasa',
                icon: Icons.woman_rounded,
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
  
  Widget _buildGenderOption({
    required BuildContext context,
    required VoiceGender gender,
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    final isSelected = selectedGender == gender;
    
    return InkWell(
      onTap: () {
        onGenderChanged(gender);
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.teal.withOpacity(0.08) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: isSelected 
              ? Border.all(color: AppColors.teal.withOpacity(0.3))
              : null,
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.teal : AppColors.cardBg,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Icon(
                icon,
                color: isSelected ? AppColors.teal : AppColors.textGray,
                size: 32,
              ),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Lexend',
                      color: isSelected ? AppColors.teal : AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textGray,
                      fontFamily: 'Public Sans',
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.teal,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 16,
                ),
              ),
          ],
        ),
      ),
    );
  }
  
  void _showLanguageSelectionDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.borderColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              // Header
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: AppColors.borderColor),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Pilih Bahasa',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Lexend',
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: AppColors.cardBg,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(Icons.close, size: 18),
                      ),
                    ),
                  ],
                ),
              ),
              // Options
              _buildLanguageOption(
                context: context,
                language: TargetLanguage.indonesian,
                title: 'Bahasa Indonesia',
                subtitle: 'Terjemahan ke bahasa Indonesia',
                flag: '🇮🇩',
              ),
              _buildLanguageOption(
                context: context,
                language: TargetLanguage.english,
                title: 'English',
                subtitle: 'Translate to English',
                flag: '🇬🇧',
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
  
  Widget _buildLanguageOption({
    required BuildContext context,
    required TargetLanguage language,
    required String title,
    required String subtitle,
    required String flag,
  }) {
    final isSelected = selectedLanguage == language;
    
    return InkWell(
      onTap: () {
        onLanguageChanged(language);
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.teal.withOpacity(0.08) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: isSelected 
              ? Border.all(color: AppColors.teal.withOpacity(0.3))
              : null,
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.teal : AppColors.cardBg,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Center(
                child: Text(
                  flag,
                  style: const TextStyle(fontSize: 32),
                ),
              ),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Lexend',
                      color: isSelected ? AppColors.teal : AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textGray,
                      fontFamily: 'Public Sans',
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.teal,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 16,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ---- Advanced AI Banner ----
class AdvancedAIBanner extends StatelessWidget {
  const AdvancedAIBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 256,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(48),
        color: Colors.grey[800],
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(48),
            child: Image.network(
              'https://placehold.co/342x257/1a3a4a/1a3a4a',
              width: double.infinity,
              height: 256,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(48),
                  color: const Color(0xFF1a3a4a),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(48),
              gradient: const LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Color(0xCC004D64), Color(0x00004D64)],
              ),
            ),
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Kalibrasi AI Lanjutan',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'Lexend',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Mempelajari gaya gestur unik Anda secara waktu nyata.',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 12,
                    fontFamily: 'Public Sans',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}