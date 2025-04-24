import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'library_model.g.dart';

@JsonSerializable()
class LibraryModel extends Equatable {
  const LibraryModel();

  @override
  List<Object> get props => [
  ];

  factory LibraryModel.fromJson(Map<String, dynamic> json) => _$LibraryModelFromJson(json);

  Map<String, dynamic> toJson() => _$LibraryModelToJson(this);
}
