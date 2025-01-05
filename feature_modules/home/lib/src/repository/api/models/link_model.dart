import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'link_model.g.dart';

@JsonSerializable()
class LinkModel extends Equatable {
  final String title;
  final String url;

  const LinkModel({
    required this.title,
    required this.url,
  });

  factory LinkModel.fromJson(Map<String, dynamic> json) => _$LinkModelFromJson(json);

  Map<String, dynamic> toJson() => _$LinkModelToJson(this);

  @override
  List<Object?> get props => [title, url];
}