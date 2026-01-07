class LocationModel {
  final double lat;
  final double lng;
  final String? landmark;

  LocationModel({required this.lat, required this.lng, this.landmark});

  factory LocationModel.fromMap(Map<String, dynamic> map) {
    return LocationModel(
      lat: map['lat']?.toDouble() ?? 0,
      lng: map['lng']?.toDouble() ?? 0,
      landmark: map['landmark'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'lat': lat, 'lng': lng, 'landmark': landmark};
  }
}
