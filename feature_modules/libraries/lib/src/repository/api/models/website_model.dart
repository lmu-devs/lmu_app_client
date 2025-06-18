import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'website_model.g.dart';

@JsonSerializable()
class WebsiteModel extends Equatable {
  const WebsiteModel({
    required this.title,
    required this.url,
  });

  factory WebsiteModel.fromJson(Map<String, dynamic> json) => _$WebsiteModelFromJson(json);

  final String title;
  final String url;

  Map<String, dynamic> toJson() => _$WebsiteModelToJson(this);

  @override
  List<Object?> get props => [title, url];
}
