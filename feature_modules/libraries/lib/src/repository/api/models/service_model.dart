import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'service_model.g.dart';

@JsonSerializable()
class ServiceModel extends Equatable {
  const ServiceModel({
    required this.title,
    this.url,
  });

  final String title;
  final String? url;

  factory ServiceModel.fromJson(Map<String, dynamic> json) => _$ServiceModelFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceModelToJson(this);

  @override
  List<Object?> get props => [title, url];
}
