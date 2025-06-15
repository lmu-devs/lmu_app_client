import 'package:equatable/equatable.dart';

class People extends Equatable {
  const People({
    required this.id,
    required this.name,
    required this.description,
    required this.url,
    required this.email,
    required this.phone,
    required this.office,
    required this.aliases,
    this.faviconUrl,
  });

  final String id;
  final String name;
  final String url;
  final String? faviconUrl;
  final List<String> aliases;
  final String description;
  final String email;
  final String phone;
  final String office;

  @override
  List<Object?> get props => [id];
}
