import 'package:flutter/material.dart';

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
  static const guideCard = Color(0xFFE7E8E9);
}

// ==================== SENSOR CALIBRATION PAGE ====================
class SensorCalibrationPage extends StatelessWidget {
  const SensorCalibrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  SizedBox(height: 32),
                  _CalibrationTitleSection(),
                  SizedBox(height: 32),
                  _KeepHandFlatCard(),
                  SizedBox(height: 16),
                  _FingerFlexCard(),
                  SizedBox(height: 16),
                  _MPUDataCard(),
                  SizedBox(height: 16),
                  _CalibrationGuideCard(),
                  SizedBox(height: 16),
                  _ProTipCard(),
                  SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
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
          Row(
            children: [
              // Tombol Kembali
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(9999),
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: AppColors.primary,
                    size: 16,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Logo
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
                style: TextStyle(
                  fontFamily: 'Lexend',
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                  height: 1.4,
                  letterSpacing: -0.5,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          // Status Bluetooth
          Container(
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
                  'Bluetooth Terhubung • 85%',
                  style: TextStyle(
                    fontFamily: 'Lexend',
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    height: 1.43,
                    letterSpacing: -0.35,
                    color: AppColors.primary,
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

// ==================== BAGIAN JUDUL ====================
class _CalibrationTitleSection extends StatelessWidget {
  const _CalibrationTitleSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label atas
        const Text(
          'PENGATURAN SISTEM',
          style: TextStyle(
            color: AppColors.teal,
            fontSize: 12,
            fontFamily: 'Lexend',
            fontWeight: FontWeight.w400,
            height: 1.33,
            letterSpacing: 1.20,
          ),
        ),
        const SizedBox(height: 8),
        // Judul utama
        const Text(
          'Kalibrasi\nSensor',
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 36,
            fontFamily: 'Lexend',
            fontWeight: FontWeight.w400,
            height: 1.25,
          ),
        ),
        const SizedBox(height: 12),
        // Deskripsi
        const Text(
          'Sinkronkan sensor fleksibel dan orientasi\nSmart Glove Anda untuk akurasi\nterjemahan yang presisi.',
          style: TextStyle(
            color: AppColors.textGray,
            fontSize: 16,
            fontFamily: 'Public Sans',
            fontWeight: FontWeight.w400,
            height: 1.56,
          ),
        ),
        const SizedBox(height: 24),
        // Indikator langkah
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Langkah 2',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 28,
                          fontFamily: 'Lexend',
                          fontWeight: FontWeight.w700,
                          height: 1.20,
                        ),
                      ),
                      TextSpan(
                        text: '/4',
                        style: TextStyle(
                          color: Color(0x6670787E),
                          fontSize: 28,
                          fontFamily: 'Lexend',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: 192,
                  height: 8,
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFE1E3E4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9999),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        width: 96,
                        height: 8,
                        decoration: ShapeDecoration(
                          color: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9999),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

// ==================== KARTU TELAPAK TANGAN DATAR ====================
class _KeepHandFlatCard extends StatelessWidget {
  const _KeepHandFlatCard();

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
            color: Color(0x07191C1D),
            blurRadius: 40,
            offset: Offset(0, -10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Posisikan Tangan Datar',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 24,
              fontFamily: 'Lexend',
              fontWeight: FontWeight.w400,
              height: 1.33,
            ),
          ),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: Text(
              'Letakkan telapak tangan di permukaan datar.\nHindari gerakan jari selama 3 detik.',
              style: TextStyle(
                color: AppColors.textGray,
                fontSize: 16,
                fontFamily: 'Public Sans',
                fontWeight: FontWeight.w400,
                height: 1.50,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
            decoration: ShapeDecoration(
              color: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9999),
              ),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.sensors, color: Colors.white, size: 18),
                SizedBox(width: 10),
                Text(
                  'Mulai Kalibrasi Netral',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Lexend',
                    fontWeight: FontWeight.w600,
                    height: 1.50,
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

// ==================== KARTU FLEKSIBEL JARI ====================
class _FingerFlexCard extends StatelessWidget {
  const _FingerFlexCard();

  static const _fingers = [
    _FingerData('JEMPOL', 12),
    _FingerData('TELUNJUK', 5),
    _FingerData('TENGAH', 8),
    _FingerData('MANIS', 4),
    _FingerData('KELINGKING', 15),
  ];

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
          // Header
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.bar_chart_rounded,
                    color: AppColors.teal, size: 18),
              ),
              const SizedBox(width: 12),
              const Text(
                'Fleksibel Jari (Resistif)',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 16,
                  fontFamily: 'Lexend',
                  fontWeight: FontWeight.w700,
                  height: 1.50,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Batang progress
          Column(
            children: _fingers
                .map((f) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _FingerBarRow(data: f),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _FingerData {
  final String label;
  final int percent;
  const _FingerData(this.label, this.percent);
}

class _FingerBarRow extends StatelessWidget {
  final _FingerData data;
  const _FingerBarRow({required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              data.label,
              style: const TextStyle(
                color: AppColors.textGray,
                fontSize: 12,
                fontFamily: 'Public Sans',
                fontWeight: FontWeight.w700,
                height: 1.33,
              ),
            ),
            Text(
              '${data.percent}%',
              style: const TextStyle(
                color: AppColors.teal,
                fontSize: 12,
                fontFamily: 'Lexend',
                fontWeight: FontWeight.w700,
                height: 1.33,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Container(
          width: double.infinity,
          height: 12,
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: const Color(0xFFE1E3E4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9999),
            ),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: data.percent / 100,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.teal,
                borderRadius: BorderRadius.circular(9999),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ==================== KARTU DATA MPU ====================
class _MPUDataCard extends StatelessWidget {
  const _MPUDataCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: ShapeDecoration(
        color: AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(48),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.track_changes_rounded,
                    color: AppColors.lightTeal, size: 18),
              ),
              const SizedBox(width: 12),
              const Text(
                'Data MPU (FNL-01)',
                style: TextStyle(
                  color: AppColors.lightTeal,
                  fontSize: 16,
                  fontFamily: 'Lexend',
                  fontWeight: FontWeight.w700,
                  height: 1.50,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Widget kompas
          const Center(child: _CompassWidget()),
          const SizedBox(height: 24),
          // Baris metrik
          Row(
            children: [
              Expanded(
                child: _MPUMetricBox(label: 'PITCH', value: '2.4°'),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _MPUMetricBox(label: 'ROLL', value: '-0.8°'),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _MPUMetricBox(label: 'YAW', value: '182°'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CompassWidget extends StatelessWidget {
  const _CompassWidget();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 128,
      height: 128,
      child: CustomPaint(
        painter: _CompassPainter(),
      ),
    );
  }
}

class _CompassPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final outerRadius = size.width / 2;

    // Cincin luar
    final ringPaint = Paint()
      ..color = Colors.white.withOpacity(0.20)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawCircle(center, outerRadius - 1, ringPaint);

    // Elips dalam (indikator kemiringan)
    final ovalPaint = Paint()
      ..color = Colors.white.withOpacity(0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawOval(
      Rect.fromCenter(center: center, width: 80, height: 40),
      ovalPaint,
    );

    // Jarum
    final needlePaint = Paint()
      ..color = AppColors.mintTeal
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(0.26);
    canvas.drawLine(const Offset(0, 0), const Offset(0, -48), needlePaint);
    canvas.restore();

    // Titik tengah
    final dotPaint = Paint()..color = Colors.white;
    canvas.drawCircle(center, 8, dotPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _MPUMetricBox extends StatelessWidget {
  final String label;
  final String value;
  const _MPUMetricBox({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.10),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Opacity(
            opacity: 0.60,
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFFA2E1FF),
                fontSize: 10,
                fontFamily: 'Public Sans',
                fontWeight: FontWeight.w700,
                height: 1.50,
                letterSpacing: 0.8,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: 'Lexend',
              fontWeight: FontWeight.w500,
              height: 1.30,
            ),
          ),
        ],
      ),
    );
  }
}

// ==================== KARTU PANDUAN KALIBRASI ====================
class _CalibrationGuideCard extends StatelessWidget {
  const _CalibrationGuideCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.guideCard,
        borderRadius: BorderRadius.circular(48),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Panduan Kalibrasi',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 16,
              fontFamily: 'Lexend',
              fontWeight: FontWeight.w400,
              height: 1.50,
            ),
          ),
          const SizedBox(height: 16),
          _GuideItem(
            text: 'Netral: Posisikan tangan datar untuk pembacaan sinyal dasar.',
            isDone: true,
          ),
          const SizedBox(height: 12),
          _GuideItem(
            text: 'Kepalan: Tekuk semua jari untuk mengatur resistansi maksimum.',
            isDone: false,
          ),
          const SizedBox(height: 12),
          _GuideItem(
            text: 'Rentang: Gerakkan tangan membentuk angka delapan untuk mengkalibrasi MPU.',
            isDone: false,
          ),
        ],
      ),
    );
  }
}

class _GuideItem extends StatelessWidget {
  final String text;
  final bool isDone;
  const _GuideItem({required this.text, required this.isDone});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isDone ? 1.0 : 0.50,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 22,
            height: 22,
            margin: const EdgeInsets.only(top: 1),
            decoration: BoxDecoration(
              color: isDone ? AppColors.teal : Colors.transparent,
              border: Border.all(
                color: AppColors.teal,
                width: 2,
              ),
              shape: BoxShape.circle,
            ),
            child: isDone
                ? const Icon(Icons.check, color: Colors.white, size: 13)
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: AppColors.textDark,
                fontSize: 14,
                fontFamily: 'Public Sans',
                fontWeight: isDone ? FontWeight.w500 : FontWeight.w400,
                height: 1.43,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ==================== KARTU TIPS PROFESIONAL ====================
class _ProTipCard extends StatelessWidget {
  const _ProTipCard();

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
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: AppColors.deepTeal.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.lightbulb_outline,
                    color: AppColors.deepTeal, size: 16),
              ),
              const SizedBox(width: 10),
              const Text(
                'Tips Profesional',
                style: TextStyle(
                  color: Color(0xFF002020),
                  fontSize: 16,
                  fontFamily: 'Lexend',
                  fontWeight: FontWeight.w400,
                  height: 1.50,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'Untuk hasil terbaik, pastikan sarung tangan pas di ujung jari Anda. Sensor yang longgar dapat menyebabkan "goyangan" pada terjemahan.',
            style: TextStyle(
              color: Color(0xFF002020),
              fontSize: 14,
              fontFamily: 'Public Sans',
              fontWeight: FontWeight.w400,
              height: 1.63,
            ),
          ),
          const SizedBox(height: 12),
          // Area gambar sarung tangan
          Opacity(
            opacity: 0.85,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                width: double.infinity,
                height: 120,
                color: AppColors.darkTeal,
                child: const Center(
                  child: Icon(
                    Icons.front_hand_outlined,
                    color: AppColors.lightTeal,
                    size: 64,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}