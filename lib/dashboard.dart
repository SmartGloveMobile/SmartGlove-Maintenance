import 'package:flutter/material.dart';
import 'library_screen.dart'; // Import library screen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeDashboard(),
    );
  }
}

class HomeDashboard extends StatelessWidget {
  const HomeDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          const HeaderSection(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: const [
                  MainContent(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ==================== CONSTANTS ====================
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
}

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

// ==================== MAIN CONTENT ====================
class MainContent extends StatelessWidget {
  const MainContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          SizedBox(height: 32),
          WelcomeSection(),
          SizedBox(height: 32),
          DeviceStatusCard(),
          SizedBox(height: 32),
          DeviceHealthCard(),
          SizedBox(height: 40),
          RecommendedTranslationsSection(),
          SizedBox(height: 40),
          TutorialCardsSection(),
          SizedBox(height: 32),
        ],
      ),
    );
  }
}

// ==================== WELCOME SECTION ====================
class WelcomeSection extends StatelessWidget {
  const WelcomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Hello, Friends',
          style: AppTextStyles.lexendW400_36,
        ),
        SizedBox(height: 8),
        Text(
          'Your glove is optimized and ready for use.',
          style: AppTextStyles.publicSansW400_16,
        ),
      ],
    );
  }
}

// ==================== DEVICE STATUS CARD ====================
class DeviceStatusCard extends StatelessWidget {
  const DeviceStatusCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary, AppColors.secondary],
        ),
        borderRadius: BorderRadius.circular(48),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              _DeviceStatusInfo(),
              _BatteryIndicator(),
            ],
          ),
          const SizedBox(height: 32),
          const _ActionButtons(),
        ],
      ),
    );
  }
}

class _DeviceStatusInfo extends StatelessWidget {
  const _DeviceStatusInfo();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Opacity(
          opacity: 0.8,
          child: Text(
            'DEVICE STATUS',
            style: AppTextStyles.publicSansW500_14Status.copyWith(
              color: Colors.white,
            ),
          ),
        ),
        Text(
          'Active',
          style: AppTextStyles.lexendW900_48.copyWith(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

class _BatteryIndicator extends StatelessWidget {
  const _BatteryIndicator();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.battery_charging_full,
            color: Colors.white,
            size: 20,
          ),
          const SizedBox(height: 4),
          Text(
            '85%',
            style: AppTextStyles.lexendW700_16.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class _ActionButtons extends StatelessWidget {
  const _ActionButtons();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: AppColors.lightTeal,
            borderRadius: BorderRadius.circular(9999),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.translate,
                color: AppColors.darkTeal,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Start Translation',
                style: AppTextStyles.lexendW700_16.copyWith(
                  color: AppColors.darkTeal,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(9999),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.tune,
                color: Colors.white,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Calibrate Sensors',
                style: AppTextStyles.lexendW600_16.copyWith(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ==================== DEVICE HEALTH CARD ====================
class DeviceHealthCard extends StatelessWidget {
  const DeviceHealthCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: const [
          BoxShadow(
            color: Color(0x08000000),
            blurRadius: 20,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Device Health', style: AppTextStyles.lexendW700_20),
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.teal.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle_outline,
                  color: AppColors.teal,
                  size: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildHealthMetric(
            icon: Icons.flash_on,
            label: 'Sensors',
            value: 'OPTIMAL',
            valueColor: AppColors.teal,
          ),
          const SizedBox(height: 12),
          _buildHealthMetric(
            icon: Icons.speed,
            label: 'Latency',
            value: '12ms',
            valueColor: AppColors.teal,
          ),
          const SizedBox(height: 12),
          _buildHealthMetric(
            icon: Icons.settings,
            label: 'Firmware',
            value: 'v2.4.1',
            valueColor: AppColors.textGray,
          ),
          const SizedBox(height: 20),
          const EfficiencyProgressBar(),
        ],
      ),
    );
  }

  Widget _buildHealthMetric({
    required IconData icon,
    required String label,
    required String value,
    required Color valueColor,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.textGray),
          const SizedBox(width: 12),
          Text(label, style: AppTextStyles.publicSansW500_14),
          const Spacer(),
          Text(
            value,
            style: AppTextStyles.lexendW700_12.copyWith(color: valueColor),
          ),
        ],
      ),
    );
  }
}

class EfficiencyProgressBar extends StatelessWidget {
  const EfficiencyProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: double.infinity,
              height: 6,
              decoration: BoxDecoration(
                color: const Color(0xFFE1E3E4),
                borderRadius: BorderRadius.circular(9999),
              ),
            ),
            FractionallySizedBox(
              widthFactor: 0.92,
              child: Container(
                height: 6,
                decoration: BoxDecoration(
                  color: AppColors.teal,
                  borderRadius: BorderRadius.circular(9999),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Text(
          'SYSTEM EFFICIENCY: 92%',
          style: AppTextStyles.publicSansW400_10,
        ),
      ],
    );
  }
}

// ==================== RECOMMENDED TRANSLATIONS SECTION ====================
class RecommendedTranslationsSection extends StatelessWidget {
  const RecommendedTranslationsSection({super.key});

  void _navigateToLibrary(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const GestureLibraryScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Recommended Translations', style: AppTextStyles.lexendW700_24),
            GestureDetector(
              onTap: () => _navigateToLibrary(context),
              child: Text(
                'View All',
                style: AppTextStyles.lexendW600_14.copyWith(
                  color: AppColors.teal,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'Most useful gestures for daily communication',
          style: AppTextStyles.publicSansW400_14Italic.copyWith(
            color: AppColors.textGray,
          ),
        ),
        const SizedBox(height: 24),
        _buildRecommendedItem(
          context: context,
          icon: Icons.waving_hand_outlined,
          title: 'Hello / Greetings',
          description: 'A standard flat palm wave performed at shoulder height',
          category: 'Greeting',
          borderColor: AppColors.teal,
        ),
        const SizedBox(height: 16),
        _buildRecommendedItem(
          context: context,
          icon: Icons.favorite_outline,
          title: 'Thank You',
          description: 'Flat hand moves from chin outward towards the listener',
          category: 'Polite',
          borderColor: AppColors.primary,
        ),
        const SizedBox(height: 16),
        _buildRecommendedItem(
          context: context,
          icon: Icons.help_outline,
          title: 'Help',
          description: 'Closed fist on a flat palm, moved upward twice',
          category: 'Emergency',
          borderColor: AppColors.darkTeal,
        ),
        const SizedBox(height: 16),
        _buildRecommendedItem(
          context: context,
          icon: Icons.water_drop_outlined,
          title: 'Water / Drink',
          description: 'Three fingers extended, index finger tapping the chin',
          category: 'Basic Need',
          borderColor: AppColors.lightTeal,
        ),
        const SizedBox(height: 16),
        _buildRecommendedItem(
          context: context,
          icon: Icons.restaurant_outlined,
          title: 'Eat / Food',
          description: 'Closed hand bringing fingertips toward the mouth',
          category: 'Basic Need',
          borderColor: AppColors.secondary,
        ),
      ],
    );
  }

  Widget _buildRecommendedItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String description,
    required String category,
    required Color borderColor,
  }) {
    return GestureDetector(
      onTap: () => _navigateToLibrary(context),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border(
            left: BorderSide(width: 4, color: borderColor),
          ),
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0C000000),
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.lightTeal.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: AppColors.teal, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.lexendW700_18.copyWith(
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: AppTextStyles.publicSansW400_14Italic,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: _getCategoryColor(category).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      category,
                      style: TextStyle(
                        fontSize: 10,
                        fontFamily: 'Public Sans',
                        fontWeight: FontWeight.w600,
                        color: _getCategoryColor(category),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.lightTeal.withOpacity(0.3),
                borderRadius: BorderRadius.circular(9999),
              ),
              child: const Icon(
                Icons.play_arrow,
                color: AppColors.teal,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Greeting':
        return AppColors.teal;
      case 'Polite':
        return AppColors.primary;
      case 'Emergency':
        return Colors.red.shade700;
      case 'Basic Need':
        return AppColors.darkTeal;
      default:
        return AppColors.textGray;
    }
  }
}

// ==================== TUTORIAL CARDS ====================
class TutorialCardsSection extends StatelessWidget {
  const TutorialCardsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        TutorialCard(
          title: 'Calibrating Precision',
          imageUrl: 'https://placehold.co/342x256/1a1a2e/ffffff',
        ),
        SizedBox(height: 16),
        TutorialCard(
          title: 'Intuitive Interaction',
          imageUrl: 'https://placehold.co/342x256/1a2e1a/ffffff',
        ),
      ],
    );
  }
}

class TutorialCard extends StatelessWidget {
  final String title;
  final String imageUrl;

  const TutorialCard({
    super.key,
    required this.title,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: Image.network(
              imageUrl,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: double.infinity,
                  height: 200,
                  color: Colors.grey[800],
                );
              },
            ),
          ),
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(0.7),
                  Colors.transparent,
                ],
              ),
            ),
            padding: const EdgeInsets.all(24),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'Lexend',
                  fontWeight: FontWeight.w700,
                  height: 1.4,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}