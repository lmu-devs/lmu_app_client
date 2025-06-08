import 'package:equatable/equatable.dart';

class Benefit extends Equatable {
  const Benefit({
    required this.id,
    required this.title,
    required this.description,
    required this.url,
    required this.aliases,
    this.faviconUrl,
    this.imageUrl,
  });

  final String id;
  final String title;
  final String description;
  final String url;
  final String? faviconUrl;
  final String? imageUrl;
  final List<String> aliases;

  @override
  List<Object?> get props => [id];
}
