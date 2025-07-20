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
  });

  final int id;
  final String name;
  final String surname;
  final String title;
  final String? academicDegree;
  final int facultyId;
  final String faculty;
  final String role;
  final String email;
  final String phone;
  final String website;
  final String room;
  final String consultation;

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
    );
  }
}
