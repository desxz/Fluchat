import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  String? email;

  String? name;
  String? surname;
  String? imageUrl;

  UserModel({
    this.email,
    this.name,
    this.surname,
    this.imageUrl,
  });

  UserModel fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
