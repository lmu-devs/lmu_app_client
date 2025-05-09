class Benefit {
  const Benefit({
    required this.title,
    required this.description,
    required this.url,
    required this.aliases,
    this.faviconUrl,
    this.imageUrl,
  });

  final String title;
  final String description;
  final String url;
  final String? faviconUrl;
  final String? imageUrl;
  final List<String> aliases;
}
