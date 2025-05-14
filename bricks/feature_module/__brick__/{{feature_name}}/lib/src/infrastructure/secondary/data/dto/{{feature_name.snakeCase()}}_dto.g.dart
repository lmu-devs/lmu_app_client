// GENERATED CODE - DO NOT MODIFY BY HAND

part of '{{feature_name.snakeCase()}}_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

{{feature_name.pascalCase()}}Dto _${{feature_name.pascalCase()}}DtoFromJson(Map<String, dynamic> json) => {{feature_name.pascalCase()}}Dto(
      id: json['id'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _${{feature_name.pascalCase()}}DtoToJson({{feature_name.pascalCase()}}Dto instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
