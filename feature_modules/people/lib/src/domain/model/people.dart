class People {
  const People({
    required this.id,
    required this.name,
    required this.surname,
    required this.title,
    this.academicDegree,
    required this.faculty,
    required this.role,
    required this.email,
    required this.phone,
    required this.website,
    required this.room,
    required this.consultation,
  });

  final int id;
  final String name;
  final String surname;
  final String title; // Position/Titel wie "Professor:in", "Wis. Mitarbeiter", etc.
  final String? academicDegree; // Optional: "Prof. Dr.", "Dr.", etc.
  final String faculty; // Fakultät
  final String role; // Rolle in der Fakultät
  final String email;
  final String phone;
  final String website;
  final String room;
  final String consultation; // Sprechstunde
}
