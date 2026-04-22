import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'library_screen.dart';
import 'sensor_screen.dart';
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
    final provider = Provider.of<SmartGloveProvider>(context);
    
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
          _buildConnectionStatus(provider),
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

  Widget _buildConnectionStatus(SmartGloveProvider provider) {
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
              color: provider.isEsp32Connected ? AppColors.teal : Colors.red,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            provider.isEsp32Connected 
                ? 'ESP32 Terhubung • ${provider.batteryLevel}%'
                : 'Menunggu ESP32...',
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
          LatestPredictionSection(),
          SizedBox(height: 32),
          FeatureCardsSection(),
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
          'Halo, Teman-teman',
          style: AppTextStyles.lexendW400_36,
        ),
        SizedBox(height: 8),
        Text(
          'Sarung tangan Anda sudah optimal dan siap digunakan.',
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
    final provider = Provider.of<SmartGloveProvider>(context);
    
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
            children: [
              const Expanded(
                child: _DeviceStatusInfo(),
              ),
              _BatteryIndicator(batteryLevel: provider.batteryLevel),
            ],
          ),
          const SizedBox(height: 32),
          _ActionButtons(),
        ],
      ),
    );
  }
}

class _DeviceStatusInfo extends StatelessWidget {
  const _DeviceStatusInfo();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SmartGloveProvider>(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Opacity(
          opacity: 0.8,
          child: const Text(
            'STATUS PERANGKAT',
            style: TextStyle(
              fontFamily: 'Public Sans',
              fontWeight: FontWeight.w500,
              fontSize: 14,
              height: 1.43,
              letterSpacing: 1.4,
              color: Colors.white,
            ),
          ),
        ),
        Text(
          provider.isEsp32Connected ? 'Terhubung' : 'Terputus',
          style: const TextStyle(
            fontFamily: 'Lexend',
            fontWeight: FontWeight.w900,
            fontSize: 48,
            height: 1,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        if (provider.isEsp32Connected)
          Text(
            'Tegangan: ${provider.batteryVoltage.toStringAsFixed(2)}V',
            style: const TextStyle(
              fontFamily: 'Public Sans',
              fontSize: 12,
              color: Colors.white70,
            ),
          ),
      ],
    );
  }
}

class _BatteryIndicator extends StatelessWidget {
  final int batteryLevel;
  
  const _BatteryIndicator({required this.batteryLevel});

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
            '$batteryLevel%',
            style: const TextStyle(
              fontFamily: 'Lexend',
              fontWeight: FontWeight.w700,
              fontSize: 16,
              height: 1.5,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButtons extends StatelessWidget {
  const _ActionButtons();

  void _navigateToCalibration(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SensorCalibrationPage()),
    );
  }

  void _startTranslation(BuildContext context) {
    final provider = Provider.of<SmartGloveProvider>(context, listen: false);
    
    // Cek status koneksi ESP32
    if (!provider.isEsp32Connected) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            '❌ ESP32 tidak terhubung! Periksa koneksi Bluetooth/WiFi.',
            style: TextStyle(fontSize: 14),
          ),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    
    // Jika terhubung, mulai terjemahan
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          '🎤 Memulai terjemahan... Lakukan gesture pada smart glove.',
          style: TextStyle(fontSize: 14),
        ),
        backgroundColor: AppColors.teal,
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SmartGloveProvider>(context);
    
    return Column(
      children: [
        GestureDetector(
          onTap: () => _startTranslation(context),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: provider.isEsp32Connected ? AppColors.lightTeal : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(9999),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.translate,
                  color: provider.isEsp32Connected ? AppColors.darkTeal : Colors.grey.shade600,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Mulai Terjemahan',
                  style: TextStyle(
                    fontFamily: 'Lexend',
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    height: 1.5,
                    color: provider.isEsp32Connected ? AppColors.darkTeal : Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        GestureDetector(
          onTap: () => _navigateToCalibration(context),
          child: Container(
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
                const Text(
                  'Kalibrasi Sensor',
                  style: TextStyle(
                    fontFamily: 'Lexend',
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    height: 1.5,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ==================== DEVICE HEALTH CARD ====================
class DeviceHealthCard extends StatelessWidget {
  const DeviceHealthCard({super.key});

  String _formatUptime(int seconds) {
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    }
    return '${minutes}m';
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SmartGloveProvider>(context);
    
    // Tentukan status sensor berdasarkan koneksi
    final sensorStatus = provider.isEsp32Connected 
        ? (provider.sensorStatus.isNotEmpty ? provider.sensorStatus : 'OPTIMAL')
        : 'TIDAK TERHUBUNG';
    final statusColor = provider.isEsp32Connected ? AppColors.teal : Colors.red;
    
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
              const Text('Kesehatan Perangkat', style: AppTextStyles.lexendW700_20),
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.teal.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  provider.isEsp32Connected ? Icons.check_circle_outline : Icons.warning_amber_rounded,
                  color: provider.isEsp32Connected ? AppColors.teal : Colors.orange,
                  size: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildHealthMetric(
            icon: Icons.flash_on,
            label: 'Sensor',
            value: sensorStatus,
            valueColor: statusColor,
          ),
          const SizedBox(height: 12),
          _buildHealthMetric(
            icon: Icons.speed,
            label: 'Latensi',
            value: provider.isEsp32Connected ? '${provider.latency}ms' : '--',
            valueColor: AppColors.teal,
          ),
          const SizedBox(height: 12),
          _buildHealthMetric(
            icon: Icons.wifi,
            label: 'Kekuatan Sinyal',
            value: provider.isEsp32Connected ? '${provider.wifiStrength} dBm' : '--',
            valueColor: provider.wifiStrength > -50 ? AppColors.teal : Colors.orange,
          ),
          const SizedBox(height: 12),
          _buildHealthMetric(
            icon: Icons.settings,
            label: 'Firmware',
            value: provider.isEsp32Connected ? provider.firmwareVersion : '--',
            valueColor: AppColors.textGray,
          ),
          const SizedBox(height: 12),
          _buildHealthMetric(
            icon: Icons.timer,
            label: 'Uptime',
            value: provider.isEsp32Connected ? _formatUptime(provider.uptime) : '--',
            valueColor: AppColors.textGray,
          ),
          const SizedBox(height: 20),
          EfficiencyProgressBar(
            efficiency: provider.isEsp32Connected ? provider.systemEfficiency : 0.0,
          ),
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
  final double efficiency;
  
  const EfficiencyProgressBar({super.key, required this.efficiency});

  @override
  Widget build(BuildContext context) {
    final efficiencyPercent = (efficiency * 100).toInt();
    
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
              widthFactor: efficiency,
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
        Text(
          'EFISIENSI SISTEM: $efficiencyPercent%',
          style: AppTextStyles.publicSansW400_10,
        ),
      ],
    );
  }
}

// ==================== LATEST PREDICTION SECTION ====================
class LatestPredictionSection extends StatelessWidget {
  const LatestPredictionSection({super.key});

  DateTime _parseWaktu(dynamic waktuData) {
    if (waktuData == null) return DateTime.now();
    if (waktuData is DateTime) return waktuData;
    if (waktuData is Timestamp) return waktuData.toDate();
    if (waktuData is String) {
      try {
        return DateTime.parse(waktuData);
      } catch (e) {
        return DateTime.now();
      }
    }
    return DateTime.now();
  }

  String _getGestureIcon(String hasil) {
    switch (hasil.toLowerCase()) {
      case 'terima kasih':
        return '🙏';
      case 'halo':
      case 'salam':
        return '👋';
      case 'tolong':
      case 'bantuan':
        return '🆘';
      case 'makan':
      case 'makanan':
        return '🍽️';
      case 'air':
      case 'minum':
        return '💧';
      default:
        return '🤚';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Prediksi Terbaru',
          style: AppTextStyles.lexendW700_24,
        ),
        const SizedBox(height: 4),
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('prediksi')
              .orderBy('waktu', descending: true)
              .limit(5)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Center(child: CircularProgressIndicator()),
              );
            }

            if (snapshot.hasError) {
              return Container(
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline, color: Colors.red, size: 24),
                      const SizedBox(height: 4),
                      Text(
                        'Error: ${snapshot.error}',
                        style: const TextStyle(color: Colors.red, fontSize: 11),
                      ),
                    ],
                  ),
                ),
              );
            }

            final docs = snapshot.data?.docs ?? [];
            if (docs.isEmpty) {
              return Container(
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.inbox_outlined, size: 32, color: AppColors.textGray),
                      SizedBox(height: 4),
                      Text(
                        'Belum ada data prediksi',
                        style: TextStyle(color: AppColors.textGray, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              );
            }

            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: docs.length,
              itemBuilder: (context, index) {
                final data = docs[index].data() as Map<String, dynamic>;
                
                double confidence = 0.0;
                if (data['confidence_score'] != null) {
                  if (data['confidence_score'] is double) {
                    confidence = data['confidence_score'];
                  } else if (data['confidence_score'] is int) {
                    confidence = (data['confidence_score'] as int).toDouble();
                  } else if (data['confidence_score'] is num) {
                    confidence = (data['confidence_score'] as num).toDouble();
                  }
                }
                
                final hasil = data['hasil_prediksi'] ?? 'Tidak diketahui';
                final waktu = _parseWaktu(data['waktu']);
                final confidencePercent = (confidence * 100).toStringAsFixed(1);
                
                Color confidenceColor;
                if (confidence >= 0.8) {
                  confidenceColor = Colors.green;
                } else if (confidence >= 0.6) {
                  confidenceColor = Colors.orange;
                } else {
                  confidenceColor = Colors.red;
                }

                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.lightTeal),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.03),
                        blurRadius: 4,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: AppColors.teal.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            _getGestureIcon(hasil),
                            style: const TextStyle(fontSize: 26),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              hasil,
                              style: AppTextStyles.lexendW700_18.copyWith(
                                color: AppColors.textDark,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: confidenceColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.trending_up,
                                        size: 11,
                                        color: confidenceColor,
                                      ),
                                      const SizedBox(width: 3),
                                      Text(
                                        '$confidencePercent%',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: confidenceColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  _formatDateTime(waktu),
                                  style: AppTextStyles.publicSansW400_10.copyWith(
                                    fontSize: 9,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final date = DateTime(dateTime.year, dateTime.month, dateTime.day);
    
    if (date == today) {
      return 'Hari ini, ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    } else if (date == today.subtract(const Duration(days: 1))) {
      return 'Kemarin, ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    } else {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    }
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
        Padding(
          padding: const EdgeInsets.only(right: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  'Rekomendasi Terjemahan',
                  style: AppTextStyles.lexendW700_24,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () => _navigateToLibrary(context),
                child: Text(
                  'Lihat Semua',
                  style: AppTextStyles.lexendW600_14.copyWith(
                    color: AppColors.teal,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Gesture paling berguna untuk komunikasi sehari-hari',
          style: AppTextStyles.publicSansW400_14Italic.copyWith(
            color: AppColors.textGray,
          ),
        ),
        const SizedBox(height: 24),
        _buildRecommendedItem(
          context: context,
          icon: Icons.waving_hand_outlined,
          title: 'Halo / Salam',
          description: 'Gerakan telapak tangan datar setinggi bahu',
          category: 'Salam',
          borderColor: AppColors.teal,
        ),
        const SizedBox(height: 16),
        _buildRecommendedItem(
          context: context,
          icon: Icons.favorite_outline,
          title: 'Terima Kasih',
          description: 'Gerakan tangan datar dari dagu ke arah lawan bicara',
          category: 'Sopan Santun',
          borderColor: AppColors.primary,
        ),
        const SizedBox(height: 16),
        _buildRecommendedItem(
          context: context,
          icon: Icons.help_outline,
          title: 'Tolong / Bantuan',
          description: 'Kepalan tangan di atas telapak tangan datar, digerakkan ke atas dua kali',
          category: 'Darurat',
          borderColor: AppColors.darkTeal,
        ),
        const SizedBox(height: 16),
        _buildRecommendedItem(
          context: context,
          icon: Icons.water_drop_outlined,
          title: 'Air / Minum',
          description: 'Tiga jari diluruskan, jari telunjuk mengetuk dagu',
          category: 'Kebutuhan Dasar',
          borderColor: AppColors.lightTeal,
        ),
        const SizedBox(height: 16),
        _buildRecommendedItem(
          context: context,
          icon: Icons.restaurant_outlined,
          title: 'Makan / Makanan',
          description: 'Tangan tertutup membawa ujung jari ke arah mulut',
          category: 'Kebutuhan Dasar',
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
          ],
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Salam':
        return AppColors.teal;
      case 'Sopan Santun':
        return AppColors.primary;
      case 'Darurat':
        return Colors.red.shade700;
      case 'Kebutuhan Dasar':
        return AppColors.darkTeal;
      default:
        return AppColors.textGray;
    }
  }
}

// ==================== FEATURE CARDS SECTION ====================
class FeatureCardsSection extends StatelessWidget {
  const FeatureCardsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FeatureCard(
          title: 'Panduan Gesture',
          subtitle: 'Pelajari 30+ gesture dasar',
          description: 'Panduan lengkap gesture SIBI (Sistem Isyarat Bahasa Indonesia)',
          icon: Icons.menu_book_rounded,
          gradient: const LinearGradient(
            colors: [Color(0xFF006A6A), Color(0xFF008080)],
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const GestureLibraryScreen()),
            );
          },
        ),
        const SizedBox(height: 16),
        FeatureCard(
          title: 'Mode Praktik',
          subtitle: 'Latihan gesture interaktif',
          description: 'Latih gesture Anda dan dapatkan umpan balik real-time',
          icon: Icons.fitness_center_rounded,
          gradient: const LinearGradient(
            colors: [Color(0xFF004D64), Color(0xFF006684)],
          ),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Mode praktik akan segera hadir!')),
            );
          },
        ),
      ],
    );
  }
}

class FeatureCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String description;
  final IconData icon;
  final Gradient gradient;
  final VoidCallback onTap;

  const FeatureCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.icon,
    required this.gradient,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 130,
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(28),
        ),
        child: Stack(
          children: [
            Positioned(
              right: -20,
              bottom: -20,
              child: Icon(
                icon,
                size: 110,
                color: Colors.white.withOpacity(0.08),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Icon(icon, color: Colors.white, size: 22),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Lexend',
                              ),
                            ),
                            Text(
                              subtitle,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    description,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 12,
                      fontFamily: 'Public Sans',
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}