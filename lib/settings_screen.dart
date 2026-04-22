import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
      home: const DeviceConnectivityScreen(),
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
  static const lightBlue = Color(0xFFA2E1FF);
  static const mintTeal = Color(0xFFA0F0F0);
  static const deepTeal = Color(0xFF004F4F);
  static const divider = Color(0xFFE7E8E9);
  static const borderColor = Color(0x1A000000);
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

// ==================== MAIN SCREEN ====================
class DeviceConnectivityScreen extends StatelessWidget {
  const DeviceConnectivityScreen({super.key});

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
                children: [
                  const SizedBox(height: 32),
                  const TitleSection(),
                  const SizedBox(height: 32),
                  const PairingStatusCard(),
                  const SizedBox(height: 24),
                  const AvailableDevicesCard(),
                  const SizedBox(height: 24),
                  const NetworkSecurityCard(),
                  const SizedBox(height: 24),
                  const TroubleshootCard(),
                  const SizedBox(height: 24),
                  const ScienceBannerCard(),
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

// ==================== TITLE SECTION ====================
class TitleSection extends StatelessWidget {
  const TitleSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Konektivitas',
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 36,
            fontFamily: 'Lexend',
            fontWeight: FontWeight.w400,
            height: 1.11,
            letterSpacing: -1.8,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Hubungkan gerakan fisik Anda dengan\ndunia digital Anda secara mulus.',
          style: TextStyle(
            color: AppColors.textGray,
            fontSize: 16,
            fontFamily: 'Public Sans',
            fontWeight: FontWeight.w400,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

// ==================== PAIRING STATUS CARD ====================
class PairingStatusCard extends StatelessWidget {
  const PairingStatusCard({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SmartGloveProvider>(context);
    
    final isConnected = provider.isEsp32Connected;
    final statusText = isConnected ? 'Terhubung' : 'Memasangkan';
    final statusColor = isConnected ? AppColors.deepTeal : const Color(0xFF002020);
    final deviceName = isConnected 
        ? 'Smart Glove (ESP32 - ${provider.firmwareVersion})' 
        : 'Smart Glove (Menunggu Koneksi)';
    final progressValue = isConnected ? 1.0 : (provider.latency > 0 ? 0.9 : 0.53);
    final statusMessage = isConnected 
        ? 'Terhubung dengan aman • Latensi ${provider.latency}ms' 
        : provider.isConnected 
            ? 'Mencoba jabat tangan aman...' 
            : 'Menunggu koneksi ke Firebase...';
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.mintTeal,
        borderRadius: BorderRadius.circular(48),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'STATUS SAAT INI',
            style: TextStyle(
              color: AppColors.deepTeal,
              fontSize: 10,
              fontFamily: 'Public Sans',
              fontWeight: FontWeight.w400,
              letterSpacing: 1.0,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    statusText,
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 30,
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w700,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    deviceName,
                    style: const TextStyle(
                      color: AppColors.deepTeal,
                      fontSize: 16,
                      fontFamily: 'Public Sans',
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.4),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isConnected ? Icons.bluetooth_connected : Icons.bluetooth,
                  color: AppColors.deepTeal,
                  size: 22,
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Container(
            width: double.infinity,
            height: 6,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(9999),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: progressValue,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.teal,
                  borderRadius: BorderRadius.circular(9999),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            statusMessage,
            style: const TextStyle(
              color: AppColors.deepTeal,
              fontSize: 12,
              fontFamily: 'Public Sans',
              fontWeight: FontWeight.w400,
              height: 1.33,
            ),
          ),
        ],
      ),
    );
  }
}

// ==================== AVAILABLE DEVICES CARD ====================
class AvailableDevicesCard extends StatelessWidget {
  const AvailableDevicesCard({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SmartGloveProvider>(context);
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0C000000),
            blurRadius: 2,
            offset: Offset(0, 1),
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
                'Perangkat Tersedia',
                style: TextStyle(
                  color: AppColors.textDark,
                  fontSize: 18,
                  fontFamily: 'Lexend',
                  fontWeight: FontWeight.w700,
                  height: 1.56,
                ),
              ),
              GestureDetector(
                onTap: () {
                  provider.connect();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Memindai perangkat...'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
                child: Icon(Icons.refresh_rounded,
                    color: AppColors.teal, size: 20),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Smart Glove Device - Status berdasarkan koneksi ESP32
          GestureDetector(
            onTap: () {
              if (!provider.isEsp32Connected) {
                provider.connect();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Menghubungkan ke Smart Glove...'),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: provider.isEsp32Connected 
                    ? AppColors.teal.withOpacity(0.1)
                    : AppColors.cardBg,
                borderRadius: BorderRadius.circular(48),
                border: provider.isEsp32Connected
                    ? Border.all(color: AppColors.teal, width: 1)
                    : null,
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: provider.isEsp32Connected 
                          ? AppColors.teal.withOpacity(0.2)
                          : AppColors.statusLight,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.front_hand_outlined,
                      color: provider.isEsp32Connected ? AppColors.teal : AppColors.primary,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Smart Glove (ESP32)',
                          style: TextStyle(
                            color: AppColors.textDark,
                            fontSize: 14,
                            fontFamily: 'Lexend',
                            fontWeight: FontWeight.w400,
                            height: 1.43,
                          ),
                        ),
                        Text(
                          provider.isEsp32Connected 
                              ? 'Terhubung • Sinyal ${provider.wifiStrength} dBm'
                              : provider.isConnected
                                  ? 'Di Sekitar • Sinyal Kuat'
                                  : 'Menunggu koneksi...',
                          style: TextStyle(
                            color: provider.isEsp32Connected ? AppColors.teal : AppColors.textGray,
                            fontSize: 12,
                            fontFamily: 'Public Sans',
                            fontWeight: FontWeight.w400,
                            height: 1.33,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (provider.isEsp32Connected)
                    const Icon(Icons.check_circle, color: AppColors.teal, size: 20)
                  else
                    const Icon(Icons.chevron_right, color: AppColors.textGray, size: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ==================== NETWORK SECURITY CARD ====================
class NetworkSecurityCard extends StatelessWidget {
  const NetworkSecurityCard({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SmartGloveProvider>(context);
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(48),
            ),
            child: const Icon(Icons.shield_outlined,
                color: AppColors.lightBlue, size: 22),
          ),
          const SizedBox(height: 16),
          const Text(
            'Keamanan Jaringan',
            style: TextStyle(
              color: AppColors.lightBlue,
              fontSize: 18,
              fontFamily: 'Lexend',
              fontWeight: FontWeight.w400,
              height: 1.56,
            ),
          ),
          const SizedBox(height: 8),
          Opacity(
            opacity: 0.8,
            child: Text(
              provider.isEsp32Connected
                  ? 'Data Anda dilindungi oleh enkripsi end-to-end\nAES-256 selama setiap transmisi gerakan.\nKoneksi: ${provider.wifiStrength} dBm'
                  : 'Data Anda dilindungi oleh enkripsi end-to-end\nAES-256 selama setiap transmisi gerakan.',
              style: const TextStyle(
                color: AppColors.lightBlue,
                fontSize: 14,
                fontFamily: 'Public Sans',
                fontWeight: FontWeight.w400,
                height: 1.43,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.1),
              borderRadius: BorderRadius.circular(9999),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  provider.isEsp32Connected ? Icons.shield : Icons.shield_outlined,
                  color: AppColors.lightBlue,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  provider.isEsp32Connected ? 'ENKRIPSI AKTIF' : 'ENKRIPSI SIAP',
                  style: const TextStyle(
                    color: AppColors.lightBlue,
                    fontSize: 12,
                    fontFamily: 'Public Sans',
                    fontWeight: FontWeight.w700,
                    height: 1.33,
                    letterSpacing: -0.3,
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

// ==================== TROUBLESHOOT CARD ====================
class TroubleshootCard extends StatelessWidget {
  const TroubleshootCard({super.key});

  void _showTroubleshootDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Pemecahan Masalah Koneksi',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Lexend',
                ),
              ),
              const SizedBox(height: 16),
              _buildTroubleshootItem(
                '1. Pastikan ESP32 menyala',
                'Periksa LED indikator pada perangkat',
              ),
              _buildTroubleshootItem(
                '2. Periksa koneksi WiFi',
                'Pastikan ESP32 terhubung ke jaringan WiFi',
              ),
              _buildTroubleshootItem(
                '3. Restart aplikasi',
                'Tutup dan buka kembali aplikasi',
              ),
              _buildTroubleshootItem(
                '4. Cek koneksi Firebase',
                'Pastikan aplikasi terhubung ke Firebase',
              ),
              _buildTroubleshootItem(
                '5. Reset perangkat',
                'Tekan tombol reset pada ESP32 selama 5 detik',
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.teal,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text('Tutup'),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTroubleshootItem(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: AppColors.textGray,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(
          color: const Color(0x4CBFC8CD),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(48),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Tidak dapat menemukan sarung tangan Anda?',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 16,
              fontFamily: 'Lexend',
              fontWeight: FontWeight.w700,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 12),
          const Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: Text(
              'Tekan dan tahan tombol pairing pada tali pergelangan\ntangan selama 3 detik hingga LED berkedip biru.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textGray,
                fontSize: 14,
                fontFamily: 'Public Sans',
                fontWeight: FontWeight.w400,
                height: 1.43,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => _showTroubleshootDialog(context),
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 32, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.teal,
                borderRadius: BorderRadius.circular(9999),
              ),
              child: const Text(
                'Pemecahan Masalah Koneksi',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Public Sans',
                  fontWeight: FontWeight.w700,
                  height: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ==================== SCIENCE BANNER CARD ====================
class ScienceBannerCard extends StatelessWidget {
  const ScienceBannerCard({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SmartGloveProvider>(context);
    
    return Container(
      width: double.infinity,
      height: 256,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(48),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF1a3a4a),
            const Color(0xFF0d2a38),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Decorative elements (no hardcoded image URL)
          Positioned(
            right: -50,
            top: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: AppColors.teal.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            left: -30,
            bottom: -30,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: AppColors.lightBlue.withOpacity(0.05),
                shape: BoxShape.circle,
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
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Ilmu di Balik Jangkauan',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Lexend',
                    fontWeight: FontWeight.w700,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  provider.isEsp32Connected
                      ? 'Latensi ${provider.latency}ms untuk penerjemahan waktu nyata.\nKoneksi aman dengan firmware ${provider.firmwareVersion}'
                      : 'Protokol latensi submilidetik untuk\npenerjemahan waktu nyata.',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 14,
                    fontFamily: 'Public Sans',
                    fontWeight: FontWeight.w400,
                    height: 1.43,
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