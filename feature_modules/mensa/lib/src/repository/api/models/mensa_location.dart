class MensaLocation {
  final String name;
  final double latitude;
  final double longitude;

  MensaLocation({
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  factory MensaLocation.fromJson(Map<String, dynamic> json) {
    return MensaLocation(
      name: json['name'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
