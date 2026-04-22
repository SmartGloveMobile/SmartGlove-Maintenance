import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'dashboard.dart';
import 'translate_screen.dart';
import 'library_screen.dart';
import 'settings_screen.dart';
import 'splash_screen.dart';
import 'providers/smart_glove_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inisialisasi Firebase dengan penanganan duplicate app
  try {
    // Cek apakah sudah ada instance Firebase
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      print('Firebase initialized successfully');
    } else {
      print('Firebase already initialized, using existing instance');
    }
  } catch (e) {
    print('Firebase initialization error: $e');
    // Jika error karena duplicate, lanjutkan saja
    if (e.toString().contains('duplicate-app')) {
      print('Duplicate app detected, continuing...');
    } else {
      rethrow;
    }
  }
  
  // Konfigurasi Realtime Database
  try {
    final database = FirebaseDatabase.instance;
    database.setPersistenceEnabled(true);
    print('Realtime Database configured');
  } catch (e) {
    print('Realtime Database config error: $e');
  }
  
  runApp(const SmartGloveApp());
}

class SmartGloveApp extends StatelessWidget {
  const SmartGloveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SmartGloveProvider()..connect(),
        ),
      ],
      child: MaterialApp(
        title: 'Smart Glove Translator',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.teal,
          fontFamily: 'Public Sans',
          scaffoldBackgroundColor: const Color(0xFFF8F9FA),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}

// ==================== MAIN WRAPPER WITH BOTTOM NAVIGATION ====================
class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  static final GlobalKey<_MainWrapperState> navigatorKey = GlobalKey<_MainWrapperState>();

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeDashboard(),
    const TranslatePage(),
    const GestureLibraryScreen(),
    const DeviceConnectivityScreen(),
  ];

  void changeIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: MainWrapper.navigatorKey,
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(48),
            topRight: Radius.circular(48),
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0x0C191C1D),
              blurRadius: 40,
              offset: Offset(0, -10),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(0, Icons.home_rounded, 'Home'),
                _buildNavItem(1, Icons.translate_rounded, 'Translate'),
                _buildNavItem(2, Icons.menu_book_outlined, 'Library'),
                _buildNavItem(3, Icons.settings_outlined, 'Settings'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isActive = _currentIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              color: isActive ? const Color(0xFF006A6A) : Colors.transparent,
              borderRadius: BorderRadius.circular(9999),
            ),
            child: Icon(
              icon,
              color: isActive ? Colors.white : const Color(0xFF40484B),
              size: 22,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isActive ? const Color(0xFF006A6A) : const Color(0xFF40484B),
              fontSize: 12,
              fontFamily: 'Public Sans',
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}