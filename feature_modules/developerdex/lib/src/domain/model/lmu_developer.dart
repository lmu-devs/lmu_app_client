class LmuDeveloper {
  const LmuDeveloper({
    required this.id,
    required this.name,
    required this.asset,
    this.encounterPercentage = 0.0,
  });

  final String id;
  final String name;
  final String asset;
  final double encounterPercentage;
}
