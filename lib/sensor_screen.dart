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
      home: const SensorCalibrationPage(),
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
  static const guideCard = Color(0xFFE7E8E9);
  static const textMuted = Color(0xFF70787E); // TAMBAHKAN INI
}

// ==================== SENSOR CALIBRATION PAGE ====================
class SensorCalibrationPage extends StatefulWidget {
  const SensorCalibrationPage({super.key});

  @override
  State<SensorCalibrationPage> createState() => _SensorCalibrationPageState();
}

class _SensorCalibrationPageState extends State<SensorCalibrationPage> {
  bool _isCalibrating = false;
  
  // Nilai sensor (akan diupdate dari provider)
  List<int> _flexValues = [0, 0, 0, 0, 0];
  double _pitch = 0.0;
  double _roll = 0.0;
  double _yaw = 0.0;
  
  // Status kalibrasi untuk guide
  bool _isNeutralCalibrated = false;
  bool _isFistCalibrated = false;
  bool _isRangeCalibrated = false;

  @override
  void initState() {
    super.initState();
    _loadSensorData();
  }
  
  void _loadSensorData() {
    final provider = Provider.of<SmartGloveProvider>(context, listen: false);
    
    // Ambil data dari provider jika ESP32 terhubung
    if (provider.isEsp32Connected) {
      // Simulasi data flex sensor (nanti akan diganti dengan data real dari ESP32)
      // Nilai ini akan diupdate secara periodik
      _updateSensorData();
    }
  }
  
  void _updateSensorData() {
    final provider = Provider.of<SmartGloveProvider>(context, listen: false);
    
    // Untuk sementara menggunakan data simulasi karena ESP32 belum mengirim data flex
    // Nanti akan diganti dengan: _flexValues = provider.flexSensorValues;
    
    // Simulasi data flex sensor berdasarkan status koneksi
    if (provider.isEsp32Connected) {
      // Jika terhubung, tampilkan data yang lebih realistis
      _flexValues = [65, 42, 38, 25, 18];
      _pitch = 2.4;
      _roll = -0.8;
      _yaw = 182.0;
    } else {
      _flexValues = [0, 0, 0, 0, 0];
      _pitch = 0.0;
      _roll = 0.0;
      _yaw = 0.0;
    }
    
    if (mounted) {
      setState(() {});
    }
  }
  
  void _startCalibration() async {
    setState(() {
      _isCalibrating = true;
    });
    
    // Simulasi proses kalibrasi (nanti akan terhubung ke ESP32)
    await Future.delayed(const Duration(seconds: 2));
    
    setState(() {
      _isNeutralCalibrated = true;
      // Update nilai flex setelah kalibrasi netral
      _flexValues = [12, 8, 5, 3, 2];
    });
    
    await Future.delayed(const Duration(seconds: 2));
    
    setState(() {
      _isFistCalibrated = true;
      // Update nilai flex setelah kalibrasi kepalan
      _flexValues = [95, 92, 88, 85, 82];
    });
    
    await Future.delayed(const Duration(seconds: 2));
    
    setState(() {
      _isRangeCalibrated = true;
      _isCalibrating = false;
      // Update nilai MPU setelah kalibrasi
      _pitch = 0.5;
      _roll = 0.3;
      _yaw = 0.0;
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Kalibrasi selesai! Sensor telah disesuaikan.'),
        backgroundColor: AppColors.teal,
      ),
    );
  }
  
  void _resetCalibration() {
    setState(() {
      _isNeutralCalibrated = false;
      _isFistCalibrated = false;
      _isRangeCalibrated = false;
      _flexValues = [0, 0, 0, 0, 0];
      _pitch = 0.0;
      _roll = 0.0;
      _yaw = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SmartGloveProvider>(context);
    
    // Update data sensor secara berkala jika ESP32 terhubung
    if (provider.isEsp32Connected && !_isCalibrating) {
      _updateSensorData();
    }
    
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          _buildHeader(context, provider),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 32),
                  const _CalibrationTitleSection(),
                  const SizedBox(height: 32),
                  _KeepHandFlatCard(
                    isCalibrating: _isCalibrating,
                    isNeutralCalibrated: _isNeutralCalibrated,
                    onCalibrate: _startCalibration,
                  ),
                  const SizedBox(height: 16),
                  _FingerFlexCard(
                    flexValues: _flexValues,
                    isConnected: provider.isEsp32Connected,
                  ),
                  const SizedBox(height: 16),
                  _MPUDataCard(
                    pitch: _pitch,
                    roll: _roll,
                    yaw: _yaw,
                    isConnected: provider.isEsp32Connected,
                  ),
                  const SizedBox(height: 16),
                  _CalibrationGuideCard(
                    isNeutralCalibrated: _isNeutralCalibrated,
                    isFistCalibrated: _isFistCalibrated,
                    isRangeCalibrated: _isRangeCalibrated,
                  ),
                  const SizedBox(height: 16),
                  const _ProTipCard(),
                  const SizedBox(height: 16),
                  // Tombol Reset Kalibrasi
                  if (_isNeutralCalibrated || _isFistCalibrated || _isRangeCalibrated)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 32),
                      child: GestureDetector(
                        onTap: _resetCalibration,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(9999),
                            border: Border.all(color: AppColors.borderColor),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.refresh, color: AppColors.textGray, size: 18),
                              SizedBox(width: 10),
                              Text(
                                'Reset Kalibrasi',
                                style: TextStyle(
                                  color: AppColors.textGray,
                                  fontSize: 16,
                                  fontFamily: 'Lexend',
                                  fontWeight: FontWeight.w600,
                                  height: 1.50,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, SmartGloveProvider provider) {
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
                  style: const TextStyle(
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
      ],
    );
  }
}

// ==================== KARTU TELAPAK TANGAN DATAR ====================
class _KeepHandFlatCard extends StatelessWidget {
  final bool isCalibrating;
  final bool isNeutralCalibrated;
  final VoidCallback onCalibrate;
  
  const _KeepHandFlatCard({
    required this.isCalibrating,
    required this.isNeutralCalibrated,
    required this.onCalibrate,
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
          if (!isNeutralCalibrated)
            GestureDetector(
              onTap: isCalibrating ? null : onCalibrate,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                decoration: ShapeDecoration(
                  color: isCalibrating ? Colors.grey : AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9999),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (isCalibrating)
                      const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    else
                      const Icon(Icons.sensors, color: Colors.white, size: 18),
                    const SizedBox(width: 10),
                    Text(
                      isCalibrating ? 'Mengkalibrasi...' : 'Mulai Kalibrasi Netral',
                      style: const TextStyle(
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
            ),
          if (isNeutralCalibrated)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
              decoration: ShapeDecoration(
                color: AppColors.teal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9999),
                ),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle, color: Colors.white, size: 18),
                  SizedBox(width: 10),
                  Text(
                    'Kalibrasi Netral Selesai',
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
  final List<int> flexValues;
  final bool isConnected;
  
  const _FingerFlexCard({
    required this.flexValues,
    required this.isConnected,
  });

  @override
  Widget build(BuildContext context) {
    final fingers = [
      _FingerData('JEMPOL', flexValues[0]),
      _FingerData('TELUNJUK', flexValues[1]),
      _FingerData('TENGAH', flexValues[2]),
      _FingerData('MANIS', flexValues[3]),
      _FingerData('KELINGKING', flexValues[4]),
    ];

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
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.bar_chart_rounded,
                  color: isConnected ? AppColors.teal : AppColors.textGray,
                  size: 18,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Fleksibel Jari (Resistif)',
                style: TextStyle(
                  color: isConnected ? AppColors.primary : AppColors.textGray,
                  fontSize: 16,
                  fontFamily: 'Lexend',
                  fontWeight: FontWeight.w700,
                  height: 1.50,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          if (!isConnected)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: Column(
                  children: [
                    Icon(Icons.bluetooth_disabled, size: 48, color: AppColors.textGray),
                    SizedBox(height: 12),
                    Text(
                      'Tunggu koneksi ESP32...',
                      style: TextStyle(color: AppColors.textGray),
                    ),
                  ],
                ),
              ),
            )
          else
            Column(
              children: fingers
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
  final int value;
  const _FingerData(this.label, this.value);
}

class _FingerBarRow extends StatelessWidget {
  final _FingerData data;
  const _FingerBarRow({required this.data});

  @override
  Widget build(BuildContext context) {
    // Normalisasi nilai (asumsi max 100 untuk flex sensor)
    final percentage = (data.value / 100.0).clamp(0.0, 1.0);
    final percentInt = (percentage * 100).toInt();
    
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
              '$percentInt%',
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
            widthFactor: percentage,
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
  final double pitch;
  final double roll;
  final double yaw;
  final bool isConnected;
  
  const _MPUDataCard({
    required this.pitch,
    required this.roll,
    required this.yaw,
    required this.isConnected,
  });

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
          if (!isConnected)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: Column(
                  children: [
                    Icon(Icons.sensors_off, size: 48, color: AppColors.lightTeal),
                    SizedBox(height: 12),
                    Text(
                      'Menunggu data sensor...',
                      style: TextStyle(color: AppColors.lightTeal),
                    ),
                  ],
                ),
              ),
            )
          else
            Center(
              child: _CompassWidget(yaw: yaw, pitch: pitch, roll: roll),
            ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: _MPUMetricBox(
                  label: 'PITCH',
                  value: isConnected ? '${pitch.toStringAsFixed(1)}°' : '--',
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _MPUMetricBox(
                  label: 'ROLL',
                  value: isConnected ? '${roll.toStringAsFixed(1)}°' : '--',
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _MPUMetricBox(
                  label: 'YAW',
                  value: isConnected ? '${yaw.toStringAsFixed(0)}°' : '--',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CompassWidget extends StatelessWidget {
  final double yaw;
  final double pitch;
  final double roll;
  
  const _CompassWidget({
    required this.yaw,
    required this.pitch,
    required this.roll,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 128,
      height: 128,
      child: CustomPaint(
        painter: _CompassPainter(yaw: yaw, pitch: pitch, roll: roll),
      ),
    );
  }
}

class _CompassPainter extends CustomPainter {
  final double yaw;
  final double pitch;
  final double roll;
  
  const _CompassPainter({
    required this.yaw,
    required this.pitch,
    required this.roll,
  });

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

    // Elips dalam (indikator kemiringan berdasarkan pitch & roll)
    final ovalPaint = Paint()
      ..color = Colors.white.withOpacity(0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    
    final tiltX = (roll / 90).clamp(-0.5, 0.5);
    final tiltY = (pitch / 90).clamp(-0.5, 0.5);
    
    canvas.drawOval(
      Rect.fromCenter(
        center: center + Offset(tiltX * 20, tiltY * 20),
        width: 80,
        height: 40,
      ),
      ovalPaint,
    );

    // Jarum berdasarkan yaw
    final needlePaint = Paint()
      ..color = AppColors.mintTeal
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(yaw * 3.14159 / 180);
    canvas.drawLine(const Offset(0, 0), const Offset(0, -48), needlePaint);
    canvas.restore();

    // Titik tengah
    final dotPaint = Paint()..color = Colors.white;
    canvas.drawCircle(center, 8, dotPaint);
    
    // Label arah mata angin
    final textPainter = TextPainter(
      text: const TextSpan(
        text: 'N',
        style: TextStyle(color: Colors.white70, fontSize: 12),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(center.dx - 4, center.dy - 58));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
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
  final bool isNeutralCalibrated;
  final bool isFistCalibrated;
  final bool isRangeCalibrated;
  
  const _CalibrationGuideCard({
    required this.isNeutralCalibrated,
    required this.isFistCalibrated,
    required this.isRangeCalibrated,
  });

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
            isDone: isNeutralCalibrated,
          ),
          const SizedBox(height: 12),
          _GuideItem(
            text: 'Kepalan: Tekuk semua jari untuk mengatur resistansi maksimum.',
            isDone: isFistCalibrated,
          ),
          const SizedBox(height: 12),
          _GuideItem(
            text: 'Rentang: Gerakkan tangan membentuk angka delapan untuk mengkalibrasi MPU.',
            isDone: isRangeCalibrated,
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