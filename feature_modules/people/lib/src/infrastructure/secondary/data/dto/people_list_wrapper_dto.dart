import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'people_dto.dart';

part 'people_list_wrapper_dto.g.dart';

@JsonSerializable()
class PeopleListWrapperDto extends Equatable {
  const PeopleListWrapperDto({
    required this.people,
    this.totalCount,
    this.pageSize,
    this.currentPage,
  });

  final List<PeopleDto> people;
  final int? totalCount;
  final int? pageSize;
  final int? currentPage;

  factory PeopleListWrapperDto.fromJson(Map<String, dynamic> json) => _$PeopleListWrapperDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PeopleListWrapperDtoToJson(this);

  @override
  List<Object?> get props => [people, totalCount, pageSize, currentPage];
}
