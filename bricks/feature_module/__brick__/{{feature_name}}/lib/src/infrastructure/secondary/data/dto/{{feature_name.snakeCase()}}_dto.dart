import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/model/{{feature_name.snakeCase()}}.dart';

part '{{feature_name.snakeCase()}}_dto.g.dart';

@JsonSerializable()
class {{feature_name.pascalCase()}}Dto extends Equatable{
  const {{feature_name.pascalCase()}}Dto({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  {{feature_name.pascalCase()}} toDomain() => {{feature_name.pascalCase()}}(
        id: id,
        name: name,
      );

  factory {{feature_name.pascalCase()}}Dto.fromJson(Map<String, dynamic> json) => _${{feature_name.pascalCase()}}DtoFromJson(json);

  Map<String, dynamic> toJson() => _${{feature_name.pascalCase()}}DtoToJson(this);

  @override
  List<Object?> get props => [id, name];
}
