import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  String? userid;
  String? phoneNumber;
  String? name;
  String? surname;
  String? imageUrl;

  UserModel({
    this.userid,
    this.phoneNumber,
    this.name,
    this.surname,
    this.imageUrl =
        'https://cdn.mos.cms.futurecdn.net/THCiUmVZcgxHodGCK3EyYo-480-80.jpg',
  });

  UserModel fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
