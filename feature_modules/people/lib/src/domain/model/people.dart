class People {
  const People({
    required this.id,
    required this.name,
    required this.surname,
    required this.title,
    this.academicDegree,
    required this.facultyId,
    required this.faculty,
    required this.role,
    required this.email,
    required this.phone,
    required this.website,
    required this.room,
    required this.consultation,
    this.isFavorite = false,
  });

  final int id;
  final String name;
  final String surname;
  final String title; // Position/Titel wie "Professor:in", "Wis. Mitarbeiter", etc.
  final String? academicDegree; // Optional: "Prof. Dr.", "Dr.", etc.
  final int facultyId; // Fakultäts-ID
  final String faculty; // Fakultät
  final String role; // Rolle in der Fakultät
  final String email;
  final String phone;
  final String website;
  final String room;
  final String consultation; // Sprechstunde
  final bool isFavorite; // Favorisiert

  /// Create a copy with updated favorite status
  People copyWith({
    int? id,
    String? name,
    String? surname,
    String? title,
    String? academicDegree,
    int? facultyId,
    String? faculty,
    String? role,
    String? email,
    String? phone,
    String? website,
    String? room,
    String? consultation,
    bool? isFavorite,
  }) {
    return People(
      id: id ?? this.id,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      title: title ?? this.title,
      academicDegree: academicDegree ?? this.academicDegree,
      facultyId: facultyId ?? this.facultyId,
      faculty: faculty ?? this.faculty,
      role: role ?? this.role,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      website: website ?? this.website,
      room: room ?? this.room,
      consultation: consultation ?? this.consultation,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
