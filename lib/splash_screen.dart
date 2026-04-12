import 'package:flutter/material.dart';

void main() {
  runApp(const SmartGloveApp());
}

class SmartGloveApp extends StatelessWidget {
  const SmartGloveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF004D64),
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF004D64), Color(0xFF006684)],
          ),
        ),
        child: Stack(
          children: [
            // Efek Dekorasi Lingkaran (Background)
            _buildBackgroundCircle(top: -100, right: -100, color: const Color(0xFF006A6A), opacity: 0.2),
            _buildBackgroundCircle(bottom: -100, left: -100, color: const Color(0xFF004D64), opacity: 0.3),
            
            // Konten Utama
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    // Logo Placeholder
                    _buildLogoBox(),
                    const SizedBox(height: 32),
                    // Judul Proyek
                    const Text(
                      'Smart Glove',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: -1,
                      ),
                    ),
                    const Text(
                      'SIGN LANGUAGE TRANSLATOR',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xCCA2E1FF),
                        fontWeight: FontWeight.w500,
                        letterSpacing: 2,
                      ),
                    ),
                    const Spacer(),
                    // Status Koneksi & Firebase
                    _buildStatusFooter(),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk dekorasi background agar kode tidak menumpuk di build utama
  Widget _buildBackgroundCircle({double? top, double? bottom, double? left, double? right, required Color color, required double opacity}) {
    return Positioned(
      top: top, bottom: bottom, left: left, right: right,
      child: Opacity(
        opacity: opacity,
        child: Container(
          width: 350,
          height: 350,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }

  Widget _buildLogoBox() {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: const Icon(Icons.front_hand, size: 60, color: Colors.white), // Ganti dengan Image.asset jika ada logo
    );
  }

  Widget _buildStatusFooter() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Color(0xFFA0F0F0),
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(color: Color(0xFFA0F0F0), blurRadius: 8)],
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Bluetooth Connectivity Initializing...',
              style: TextStyle(color: Color(0xE5A2E1FF), fontSize: 12),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: Colors.white.withOpacity(0.1))),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSmallStatus('FIREBASE AUTH'),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Icon(Icons.circle, size: 4, color: Colors.white24),
              ),
              _buildSmallStatus('READY'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSmallStatus(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white.withOpacity(0.7),
        fontSize: 10,
        fontWeight: FontWeight.bold,
        letterSpacing: 1,
      ),
    );
  }
}