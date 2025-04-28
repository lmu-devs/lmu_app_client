import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'phone_model.dart';
import 'website_model.dart';

part 'contact_model.g.dart';

@JsonSerializable()
class ContactModel extends Equatable {
  const ContactModel({
    required this.phone,
    this.website,
  });

  final List<PhoneModel> phone;
  final WebsiteModel? website;

  factory ContactModel.fromJson(Map<String, dynamic> json) => _$ContactModelFromJson(json);

  Map<String, dynamic> toJson() => _$ContactModelToJson(this);

  @override
  List<Object?> get props => [phone, website];
}
