import 'package:equatable/equatable.dart';

class People extends Equatable {
  const People({
    required this.id,
    required this.name,
    required this.description,
    required this.url,
    required this.aliases,
    this.faviconUrl,
  });

  final String id;
  final String name;
  final String description;
  final String url;
  final String? faviconUrl;
  final List<String> aliases;

  @override
  List<Object?> get props => [id];
}
