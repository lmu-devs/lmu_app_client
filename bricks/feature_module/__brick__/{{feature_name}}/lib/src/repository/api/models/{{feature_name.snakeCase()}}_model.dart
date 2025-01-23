import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part '{{feature_name.snakeCase()}}_model.g.dart';

@JsonSerializable()
class {{feature_name.pascalCase()}}Model extends Equatable {
  const {{feature_name.pascalCase()}}Model({required this.name}); 

  final String name;

  @override
  List<Object> get props => [name];

  factory {{feature_name.pascalCase()}}Model.fromJson(Map<String, dynamic> json) => _${{feature_name.pascalCase()}}ModelFromJson(json);

  Map<String, dynamic> toJson() => _${{feature_name.pascalCase()}}ModelToJson(this);
}