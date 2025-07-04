class People {
  const People({
    required this.id,
    required this.name,
    required this.title,
  });

  final int id;
  final String name;
  final String title; // Position/Titel wie "Professor:in", "Wis. Mitarbeiter", etc.
}
