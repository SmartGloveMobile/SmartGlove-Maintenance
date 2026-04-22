import 'package:cloud_firestore/cloud_firestore.dart';

class PrediksiService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  // Stream untuk mendapatkan prediksi terbaru
  Stream<List<PrediksiModel>> getLatestPredictions({int limit = 5}) {
    return _firestore
        .collection('prediksi')
        .orderBy('waktu', descending: true)
        .limit(limit)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => PrediksiModel.fromFirestore(doc))
            .toList());
  }
  
  // Stream untuk semua prediksi
  Stream<List<PrediksiModel>> getAllPredictions() {
    return _firestore
        .collection('prediksi')
        .orderBy('waktu', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => PrediksiModel.fromFirestore(doc))
            .toList());
  }
  
  // Menambahkan prediksi baru
  Future<void> addPrediction({
    required double confidenceScore,
    required String hasilPrediksi,
    required List<double> inputSensor,
    DateTime? waktu,
  }) async {
    try {
      await _firestore.collection('prediksi').add({
        'confidence_score': confidenceScore,
        'hasil_prediksi': hasilPrediksi,
        'input_sensor': inputSensor,
        'waktu': (waktu ?? DateTime.now()).toIso8601String(),
      });
    } catch (e) {
      print('Error adding prediction: $e');
      rethrow;
    }
  }
  
  // Mendapatkan statistik prediksi
  Future<PredictionStats> getPredictionStats() async {
    final snapshot = await _firestore.collection('prediksi').get();
    final docs = snapshot.docs;
    
    if (docs.isEmpty) {
      return PredictionStats(
        total: 0,
        averageConfidence: 0.0,
        mostCommonPrediction: 'Tidak ada data',
      );
    }
    
    double totalConfidence = 0;
    Map<String, int> predictionCount = {};
    
    for (var doc in docs) {
      final data = doc.data();
      final confidence = (data['confidence_score'] ?? 0.0).toDouble();
      totalConfidence += confidence;
      
      String hasil = data['hasil_prediksi'] ?? 'Unknown';
      predictionCount[hasil] = (predictionCount[hasil] ?? 0) + 1;
    }
    
    String mostCommon = predictionCount.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;
    
    return PredictionStats(
      total: docs.length,
      averageConfidence: totalConfidence / docs.length,
      mostCommonPrediction: mostCommon,
    );
  }
}

// Model untuk data prediksi
class PrediksiModel {
  final String id;
  final double confidenceScore;
  final String hasilPrediksi;
  final List<double> inputSensor;
  final DateTime waktu;
  
  PrediksiModel({
    required this.id,
    required this.confidenceScore,
    required this.hasilPrediksi,
    required this.inputSensor,
    required this.waktu,
  });
  
  factory PrediksiModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return PrediksiModel(
      id: doc.id,
      confidenceScore: (data['confidence_score'] ?? 0.0).toDouble(),
      hasilPrediksi: data['hasil_prediksi'] ?? '',
      inputSensor: List<double>.from(data['input_sensor'] ?? []),
      waktu: data['waktu'] is DateTime 
          ? data['waktu'] 
          : DateTime.parse(data['waktu'] ?? DateTime.now().toIso8601String()),
    );
  }
}

// Stats model
class PredictionStats {
  final int total;
  final double averageConfidence;
  final String mostCommonPrediction;
  
  PredictionStats({
    required this.total,
    required this.averageConfidence,
    required this.mostCommonPrediction,
  });
}