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
  
  factory PrediksiModel.fromFirestore(Map<String, dynamic> data, String id) {
    return PrediksiModel(
      id: id,
      confidenceScore: (data['confidence_score'] ?? 0.0).toDouble(),
      hasilPrediksi: data['hasil_prediksi'] ?? '',
      inputSensor: List<double>.from(data['input_sensor'] ?? []),
      waktu: data['waktu'] is DateTime 
          ? data['waktu'] 
          : DateTime.parse(data['waktu'] ?? DateTime.now().toIso8601String()),
    );
  }
  
  Map<String, dynamic> toFirestore() {
    return {
      'confidence_score': confidenceScore,
      'hasil_prediksi': hasilPrediksi,
      'input_sensor': inputSensor,
      'waktu': waktu.toIso8601String(),
    };
  }
}