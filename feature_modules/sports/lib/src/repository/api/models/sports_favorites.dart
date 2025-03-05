import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sports_favorites.g.dart';

@JsonSerializable()
class SportsFavorites extends Equatable {
  const SportsFavorites({required this.category, required this.favorites});

  final String category;
  final List<String> favorites;

  factory SportsFavorites.fromJson(Map<String, dynamic> json) => _$SportsFavoritesFromJson(json);

  Map<String, dynamic> toJson() => _$SportsFavoritesToJson(this);

  @override
  List<Object?> get props => [category, favorites];
}
