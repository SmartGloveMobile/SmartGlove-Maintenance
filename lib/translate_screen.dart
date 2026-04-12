import 'package:flutter/material.dart';

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

// ==================== COLORS (Sesuai dashboard.dart) ====================
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

// ==================== TEXT STYLES (Sesuai dashboard.dart) ====================
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

// ==================== MAIN PAGE ====================
class TranslatePage extends StatelessWidget {
  const TranslatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          const HeaderSection(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  SizedBox(height: 32),
                  TitleSection(),
                  SizedBox(height: 48),
                  ActiveStreamCard(),
                  SizedBox(height: 24),
                  TranslationOutputCard(),
                  SizedBox(height: 24),
                  GloveHealthCard(),
                  SizedBox(height: 24),
                  VoiceSettingsCard(),
                  SizedBox(height: 24),
                  AdvancedAIBanner(),
                  SizedBox(height: 32),
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
  const HeaderSection({super.key});

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
            decoration: const BoxDecoration(
              color: AppColors.teal,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            'Bluetooth Connected • 85%',
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
          'Translating\nMotion to Speech.',
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
          'Your Smart Glove is active. Sign now for\nreal-time interpretation.',
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
  const ActiveStreamCard({super.key});

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
                  const Icon(Icons.graphic_eq,
                      color: AppColors.teal, size: 20),
                  const SizedBox(width: 12),
                  const Text(
                    'ACTIVE STREAM',
                    style: TextStyle(
                      color: AppColors.teal,
                      fontSize: 14,
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.4,
                    ),
                  ),
                ],
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.lightTeal,
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: const Text(
                  'Latency: 12ms',
                  style: TextStyle(
                    color: AppColors.darkTeal,
                    fontSize: 12,
                    fontFamily: 'Public Sans',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            width: double.infinity,
            height: 120,
            decoration: BoxDecoration(
              color: AppColors.cardBg,
              borderRadius: BorderRadius.circular(32),
            ),
            child: const WaveformWidget(),
          ),
        ],
      ),
    );
  }
}

class WaveformWidget extends StatelessWidget {
  const WaveformWidget({super.key});

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
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3),
          child: Opacity(
            opacity: bar['opacity'] as double,
            child: Container(
              width: 8,
              height: bar['h'] as double,
              decoration: BoxDecoration(
                color: bar['color'] as Color,
                borderRadius: BorderRadius.circular(9999),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

// ---- Translation Output Card ----
class TranslationOutputCard extends StatelessWidget {
  const TranslationOutputCard({super.key});

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
                'TRANSLATION\nOUTPUT',
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
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: const Icon(Icons.copy_outlined,
                        color: AppColors.textGray, size: 20),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: const Icon(Icons.share_outlined,
                        color: AppColors.textGray, size: 20),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          Stack(
            children: [
              const Text(
                'Hello, my name is\nAlex. I am happy\nto meet you today.\nHow can I help? ',
                style: TextStyle(
                  color: AppColors.textDark,
                  fontSize: 30,
                  fontFamily: 'Lexend',
                  fontWeight: FontWeight.w300,
                  height: 1.63,
                ),
              ),
              Positioned(
                right: 0,
                bottom: 8,
                child: Opacity(
                  opacity: 0.5,
                  child: Container(
                    width: 6,
                    height: 40,
                    color: AppColors.teal,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24, vertical: 16),
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
                        'Play Audio',
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
              const SizedBox(width: 16),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24, vertical: 16),
                decoration: BoxDecoration(
                  color: AppColors.lightTeal,
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: const Icon(Icons.history,
                    color: AppColors.darkTeal, size: 22),
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
  const GloveHealthCard({super.key});

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
                'Glove Health',
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
                child: const Icon(Icons.check,
                    color: AppColors.deepTeal, size: 16),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildHealthRow('FLEX SENSORS', '100%', 1.0),
          const SizedBox(height: 16),
          _buildHealthRow('IMU PRECISION', 'Optimal', 0.9),
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

// ---- Voice Settings Card ----
class VoiceSettingsCard extends StatelessWidget {
  const VoiceSettingsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(48),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Voice Settings',
            style: TextStyle(
              color: AppColors.textDark,
              fontSize: 16,
              fontFamily: 'Lexend',
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 16),
          _buildSettingItem('Natural Voice', 'Male (British)',
              Icons.mic_outlined),
          const SizedBox(height: 16),
          _buildSettingItem('Target Language', 'English (US)',
              Icons.language_outlined),
        ],
      ),
    );
  }

  Widget _buildSettingItem(
      String title, String subtitle, IconData icon) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: const Color(0x33BFC8CD)),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.textDark,
                  fontSize: 14,
                  fontFamily: 'Public Sans',
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(
                  color: AppColors.textGray,
                  fontSize: 12,
                  fontFamily: 'Public Sans',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          Icon(icon, color: AppColors.teal, size: 22),
        ],
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
                  'Advanced AI Calibration',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'Lexend',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Learning your unique gesture style in real-time.',
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