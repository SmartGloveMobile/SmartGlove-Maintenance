import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
      home: const GestureLibraryScreen(),
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
  static const textMuted = Color(0xFF70787E);
  static const chipBg = Color(0xFFECEEEF);
  static const divider = Color(0xFFE1E3E4);
  static const mintTeal = Color(0xFFA0F0F0);
  static const deepTeal = Color(0xFF004F4F);
  
  // Warna untuk kategori dinamis
  static const Map<String, Color> categoryColors = {
    'Salam': teal,
    'Kebutuhan Dasar': darkTeal,
    'Darurat': Color(0xFF93000A),
  };
  
  static const Map<String, Color> categoryBgColors = {
    'Salam': lightTeal,
    'Kebutuhan Dasar': chipBg,
    'Darurat': Color(0xFFFFDAD6),
  };
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
class GestureLibraryScreen extends StatelessWidget {
  const GestureLibraryScreen({super.key});

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
                  GestureLibraryBody(),
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

// ==================== GESTURE MODEL ====================
class GestureModel {
  final String id;
  final String nama;
  final String deskripsi;
  final String kategori;
  final String iconName;
  final int popularity;
  final DateTime createdAt;
  
  GestureModel({
    required this.id,
    required this.nama,
    required this.deskripsi,
    required this.kategori,
    required this.iconName,
    required this.popularity,
    required this.createdAt,
  });
  
  factory GestureModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return GestureModel(
      id: doc.id,
      nama: data['nama'] ?? '',
      deskripsi: data['deskripsi'] ?? '',
      kategori: data['kategori'] ?? '',
      iconName: data['icon'] ?? 'front_hand',
      popularity: data['popularity'] ?? 0,
      createdAt: (data['created_at'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
  
  IconData get icon {
    switch (iconName.toLowerCase()) {
      case 'front_hand':
        return Icons.front_hand_outlined;
      case 'water_drop':
        return Icons.water_drop_outlined;
      case 'add_circle':
        return Icons.add_circle_outline;
      case 'restaurant':
        return Icons.restaurant_outlined;
      case 'favorite':
        return Icons.favorite_outline;
      case 'help':
        return Icons.help_outline;
      default:
        return Icons.front_hand_outlined;
    }
  }
  
  Color get tagColor {
    return AppColors.categoryColors[kategori] ?? AppColors.textDark;
  }
  
  Color get tagBgColor {
    return AppColors.categoryBgColors[kategori] ?? AppColors.chipBg;
  }
}

// ==================== BODY ====================
class GestureLibraryBody extends StatefulWidget {
  const GestureLibraryBody({super.key});

  @override
  State<GestureLibraryBody> createState() => _GestureLibraryBodyState();
}

class _GestureLibraryBodyState extends State<GestureLibraryBody> {
  int _selectedFilter = 0;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  
  // Daftar kategori dinamis dari Firestore
  List<String> _filters = ['Semua'];

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  void _loadCategories() {
    FirebaseFirestore.instance.collection('gestures').snapshots().listen((snapshot) {
      final categories = <String>{};
      for (var doc in snapshot.docs) {
        final data = doc.data();
        final kategori = data['kategori'] ?? '';
        if (kategori.isNotEmpty) {
          categories.add(kategori);
        }
      }
      
      final newFilters = ['Semua', ...categories.toList()..sort()];
      if (mounted && (_filters.length != newFilters.length || 
          !_filters.asMap().entries.every((entry) => entry.value == newFilters[entry.key]))) {
        setState(() {
          _filters = newFilters;
          // Reset filter jika filter yang dipilih tidak ada lagi
          if (_selectedFilter >= _filters.length) {
            _selectedFilter = 0;
          }
        });
      }
    });
  }

  String _getFilterValue() {
    if (_selectedFilter == 0) return '';
    return _filters[_selectedFilter];
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32),

          // Search Bar
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: const Color(0xFFE1E3E4),
              borderRadius: BorderRadius.circular(9999),
            ),
            child: Row(
              children: [
                const Icon(Icons.search, color: Color(0xFF6B7280), size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value.toLowerCase().trim();
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: "Cari gerakan (misal 'Halo', 'Air')",
                      hintStyle: TextStyle(
                        color: Color(0xFF6B7280),
                        fontSize: 16,
                        fontFamily: 'Public Sans',
                        fontWeight: FontWeight.w400,
                      ),
                      border: InputBorder.none,
                      isDense: true,
                    ),
                  ),
                ),
                if (_searchQuery.isNotEmpty)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _searchQuery = '';
                        _searchController.clear();
                      });
                    },
                    child: const Icon(Icons.clear, color: Color(0xFF6B7280), size: 18),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Filter Tabs - Dynamic (hanya dari Firestore)
          if (_filters.length > 1)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(_filters.length, (i) {
                  final isActive = _selectedFilter == i;
                  return Padding(
                    padding: EdgeInsets.only(right: i < _filters.length - 1 ? 8 : 0),
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedFilter = i),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 16),
                        decoration: BoxDecoration(
                          color: isActive ? AppColors.primary : AppColors.white,
                          borderRadius: BorderRadius.circular(9999),
                        ),
                        child: Text(
                          _filters[i],
                          style: TextStyle(
                            color: isActive ? Colors.white : AppColors.textGray,
                            fontSize: 16,
                            fontFamily: 'Public Sans',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          const SizedBox(height: 40),

          // Library Catalog Header with Total Count
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('gestures').snapshots(),
            builder: (context, snapshot) {
              int totalGestures = snapshot.data?.docs.length ?? 0;
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Katalog Perpustakaan',
                    style: TextStyle(
                      color: AppColors.textDark,
                      fontSize: 24,
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w700,
                      height: 1.33,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.teal.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '$totalGestures Gerakan',
                      style: const TextStyle(
                        color: AppColors.teal,
                        fontSize: 14,
                        fontFamily: 'Public Sans',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 24),

          // Gesture Cards List from Firestore
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: _buildGestureStream(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  padding: const EdgeInsets.all(32),
                  child: const Center(
                    child: Column(
                      children: [
                        CircularProgressIndicator(
                          color: AppColors.teal,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Memuat library gesture...',
                          style: TextStyle(
                            color: AppColors.textGray,
                            fontFamily: 'Public Sans',
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              if (snapshot.hasError) {
                final errorMessage = snapshot.error.toString();
                if (errorMessage.contains('index')) {
                  return Container(
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.build_circle, size: 64, color: Colors.orange.shade400),
                        const SizedBox(height: 16),
                        const Text(
                          'Membuat index otomatis...',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Lexend',
                            color: AppColors.textDark,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Firestore sedang mengoptimalkan query.\nTunggu beberapa saat dan refresh halaman.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.textGray,
                            fontFamily: 'Public Sans',
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: () {
                            setState(() {});
                          },
                          icon: const Icon(Icons.refresh),
                          label: const Text('Refresh'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.teal,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                
                return Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.error_outline, size: 64, color: Colors.red.shade400),
                      const SizedBox(height: 16),
                      const Text(
                        'Gagal memuat data',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Lexend',
                          color: AppColors.textDark,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        errorMessage.length > 100 ? '${errorMessage.substring(0, 100)}...' : errorMessage,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: AppColors.textGray,
                          fontFamily: 'Public Sans',
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: () {
                          setState(() {});
                        },
                        icon: const Icon(Icons.refresh),
                        label: const Text('Coba Lagi'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.teal,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }

              final gestures = snapshot.data?.docs
                  .map((doc) => GestureModel.fromFirestore(doc))
                  .toList() ?? [];
              
              // Filter berdasarkan search query (case insensitive & trim whitespace)
              var filteredGestures = gestures.where((gesture) {
                if (_searchQuery.isEmpty) return true;
                final queryLower = _searchQuery.toLowerCase().trim();
                final namaLower = gesture.nama.toLowerCase();
                final deskripsiLower = gesture.deskripsi.toLowerCase();
                return namaLower.contains(queryLower) || 
                       deskripsiLower.contains(queryLower);
              }).toList();

              if (filteredGestures.isEmpty) {
                return Center(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 32),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          _searchQuery.isNotEmpty ? Icons.search_off : Icons.gesture_outlined,
                          size: 80,
                          color: AppColors.textMuted,
                        ),
                        const SizedBox(height: 24),
                        Text(
                          _searchQuery.isNotEmpty 
                              ? 'Tidak ada gerakan yang ditemukan'
                              : 'Belum ada gesture yang ditambahkan',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Lexend',
                            color: AppColors.textDark,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          _searchQuery.isNotEmpty 
                              ? 'Tidak ditemukan hasil untuk "$_searchQuery"'
                              : 'Silakan tambahkan gesture baru melalui menu admin',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: AppColors.textGray,
                            fontFamily: 'Public Sans',
                            fontSize: 14,
                          ),
                        ),
                        if (_searchQuery.isNotEmpty) ...[
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _searchQuery = '';
                                _searchController.clear();
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.teal,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: const Text('Hapus Pencarian'),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              }

              return Column(
                children: [
                  ...filteredGestures.map((gesture) => _buildGestureCard(gesture)),
                  
                  const SizedBox(height: 24),
                  
                  // Most Used This Week Card
                  if (gestures.isNotEmpty)
                    MostUsedCard(mostUsedGesture: _getMostUsedGesture(filteredGestures)),
                  
                  const SizedBox(height: 24),
                  
                  // Recent History Section
                  const RecentHistoryCard(),
                ],
              );
            },
          ),
          
          const SizedBox(height: 32),
        ],
      ),
    );
  }
  
  Stream<QuerySnapshot<Map<String, dynamic>>> _buildGestureStream() {
    CollectionReference<Map<String, dynamic>> gestures = 
        FirebaseFirestore.instance.collection('gestures');
    final filterValue = _getFilterValue();
    
    if (filterValue.isNotEmpty) {
      return gestures.where('kategori', isEqualTo: filterValue).snapshots();
    }
    
    return gestures.orderBy('popularity', descending: true).snapshots();
  }
  
  GestureModel? _getMostUsedGesture(List<GestureModel> gestures) {
    if (gestures.isEmpty) return null;
    return gestures.reduce((a, b) => a.popularity > b.popularity ? a : b);
  }

  Widget _buildGestureCard(GestureModel gesture) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.only(bottom: 2),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(Radius.circular(32)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.lightTeal,
                  shape: BoxShape.circle,
                ),
                child: Icon(gesture.icon, color: AppColors.teal, size: 28),
              ),
              if (gesture.kategori.isNotEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: gesture.tagBgColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    gesture.kategori.toUpperCase(),
                    style: TextStyle(
                      color: gesture.tagColor,
                      fontSize: 10,
                      fontFamily: 'Public Sans',
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 28),
          Text(
            gesture.nama,
            style: const TextStyle(
              color: AppColors.textDark,
              fontSize: 20,
              fontFamily: 'Lexend',
              fontWeight: FontWeight.w400,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            gesture.deskripsi,
            style: const TextStyle(
              color: AppColors.textGray,
              fontSize: 14,
              fontFamily: 'Public Sans',
              fontWeight: FontWeight.w400,
              height: 1.63,
            ),
          ),
        ],
      ),
    );
  }
}

// ==================== MOST USED CARD ====================
class MostUsedCard extends StatelessWidget {
  final GestureModel? mostUsedGesture;
  
  const MostUsedCard({super.key, this.mostUsedGesture});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 2),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.mintTeal,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: const BoxDecoration(
                  color: Color(0xFF002020),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.star, color: Colors.white, size: 22),
              ),
              const SizedBox(width: 16),
              const Text(
                'PALING SERING DIGUNAKAN MINGGU INI',
                style: TextStyle(
                  color: Color(0xFF002020),
                  fontSize: 12,
                  fontFamily: 'Public Sans',
                  fontWeight: FontWeight.w700,
                  height: 1.33,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            mostUsedGesture != null ? '"${mostUsedGesture!.nama}"' : 'Belum ada data',
            style: const TextStyle(
              color: Color(0xFF002020),
              fontSize: 30,
              fontFamily: 'Lexend',
              fontWeight: FontWeight.w400,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            mostUsedGesture != null ? mostUsedGesture!.deskripsi : 'Lakukan gesture untuk melihat statistik',
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
    );
  }
}

// ==================== RECENT HISTORY CARD (TANPA HARDCODE) ====================
class RecentHistoryCard extends StatelessWidget {
  const RecentHistoryCard({super.key});

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
            children: const [
              Icon(Icons.history, color: AppColors.textDark, size: 20),
              SizedBox(width: 8),
              Text(
                'Riwayat Terbaru',
                style: TextStyle(
                  color: AppColors.textDark,
                  fontSize: 20,
                  fontFamily: 'Lexend',
                  fontWeight: FontWeight.w700,
                  height: 1.4,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // History Items from Firestore (prediksi collection)
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('prediksi')
                .orderBy('waktu', descending: true)
                .limit(5)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(color: AppColors.teal),
                  ),
                );
              }

              if (snapshot.hasError) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Icon(Icons.error_outline, color: Colors.red.shade400),
                        const SizedBox(height: 8),
                        Text('Error: ${snapshot.error}'),
                      ],
                    ),
                  ),
                );
              }

              final docs = snapshot.data?.docs ?? [];
              
              if (docs.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32.0),
                    child: Column(
                      children: [
                        Icon(Icons.history, size: 48, color: AppColors.textMuted),
                        SizedBox(height: 12),
                        Text(
                          'Belum ada riwayat terjemahan',
                          style: TextStyle(
                            color: AppColors.textGray,
                            fontFamily: 'Public Sans',
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Lakukan gesture pada smart glove',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textMuted,
                            fontFamily: 'Public Sans',
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return Column(
                children: [
                  ...docs.take(3).map((doc) {
                    final data = doc.data() as Map<String, dynamic>;
                    final hasil = data['hasil_prediksi'] ?? 'Tidak diketahui';
                    final waktu = data['waktu'] is Timestamp 
                        ? (data['waktu'] as Timestamp).toDate()
                        : DateTime.parse(data['waktu'] ?? DateTime.now().toIso8601String());
                    
                    return _buildHistoryItem(
                      icon: _getIconForGesture(hasil),
                      title: hasil.length > 30 ? '${hasil.substring(0, 30)}...' : hasil,
                      subtitle: _formatRelativeTime(waktu),
                    );
                  }),
                  
                  const SizedBox(height: 32),

                  // Quick Tip
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: const Color(0x19006684),
                      border: Border.all(color: const Color(0x19004D64)),
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.lightbulb_outline,
                                color: AppColors.primary, size: 18),
                            SizedBox(width: 8),
                            Text(
                              'Tips Cepat',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 16,
                                fontFamily: 'Public Sans',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Untuk akurasi yang lebih baik saat\npenerjemahan, pertahankan gerakan Anda\ntegas dan jeda 0,5 detik di antara\ngerakan.',
                          style: TextStyle(
                            color: AppColors.textGray,
                            fontSize: 14,
                            fontFamily: 'Public Sans',
                            fontWeight: FontWeight.w400,
                            height: 1.63,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Storage Status - DINAMIS (tidak hardcoded)
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('prediksi')
                        .snapshots(),
                    builder: (context, snapshot) {
                      final totalPrediksi = snapshot.data?.docs.length ?? 0;
                      // Kapasitas maksimal diasumsikan 1000 data (bisa disesuaikan)
                      const maxCapacity = 1000;
                      final storagePercentage = (totalPrediksi / maxCapacity).clamp(0.0, 1.0);
                      final percentage = (storagePercentage * 100).toInt();
                      
                      // Warna progress bar berdasarkan persentase
                      Color progressColor;
                      if (percentage < 70) {
                        progressColor = AppColors.teal;
                      } else if (percentage < 85) {
                        progressColor = Colors.orange;
                      } else {
                        progressColor = Colors.red;
                      }
                      
                      // Waktu sinkronisasi terakhir (dari data terbaru)
                      String lastSync = 'Belum pernah sinkron';
                      if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                        final lastDoc = snapshot.data!.docs.first;
                        final lastTime = lastDoc['waktu'];
                        if (lastTime is Timestamp) {
                          lastSync = _formatRelativeTime(lastTime.toDate());
                        } else if (lastTime is String) {
                          try {
                            lastSync = _formatRelativeTime(DateTime.parse(lastTime));
                          } catch (e) {
                            lastSync = 'Baru saja';
                          }
                        }
                      }
                      
                      return Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius: BorderRadius.circular(32),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'STATUS PENYIMPANAN',
                                  style: TextStyle(
                                    color: AppColors.textMuted,
                                    fontSize: 10,
                                    fontFamily: 'Public Sans',
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                Text(
                                  '$percentage% TERISI',
                                  style: const TextStyle(
                                    color: AppColors.textMuted,
                                    fontSize: 10,
                                    fontFamily: 'Public Sans',
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            // Progress bar dinamis
                            Container(
                              width: double.infinity,
                              height: 4,
                              decoration: BoxDecoration(
                                color: AppColors.divider,
                                borderRadius: BorderRadius.circular(9999),
                              ),
                              child: FractionallySizedBox(
                                alignment: Alignment.centerLeft,
                                widthFactor: storagePercentage,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: progressColor,
                                    borderRadius: BorderRadius.circular(9999),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Center(
                              child: Text(
                                'Sinkronisasi terakhir: $lastSync',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColors.textGray,
                                  fontSize: 11,
                                  fontFamily: 'Public Sans',
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
  
  String _formatRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    
    if (difference.inMinutes < 1) {
      return 'Baru saja';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} menit lalu';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} jam lalu';
    } else if (difference.inDays == 1) {
      return 'Kemarin';
    } else {
      return '${difference.inDays} hari lalu';
    }
  }
  
  IconData _getIconForGesture(String gesture) {
    switch (gesture.toLowerCase()) {
      case 'halo':
      case 'salam':
        return Icons.waving_hand_outlined;
      case 'terima kasih':
        return Icons.favorite_outline;
      case 'tolong':
      case 'bantuan':
        return Icons.help_outline;
      case 'makan':
      case 'makanan':
        return Icons.restaurant_outlined;
      case 'air':
      case 'minum':
        return Icons.water_drop_outlined;
      default:
        return Icons.chat_bubble_outline;
    }
  }

  Widget _buildHistoryItem({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.divider,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.textGray, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.textDark,
                    fontSize: 16,
                    fontFamily: 'Public Sans',
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 12,
                    fontFamily: 'Public Sans',
                    fontWeight: FontWeight.w400,
                    height: 1.33,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: AppColors.textMuted, size: 20),
        ],
      ),
    );
  }
}