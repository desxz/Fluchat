import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  String? userid;
  String? phoneNumber;
  String? nameSurname;
  String? statusMessage;
  String? imageUrl;

  UserModel({
    this.userid,
    this.phoneNumber,
    this.nameSurname,
    this.statusMessage = 'May the force be with you.',
    this.imageUrl = 'http://www.gazeteguncel.com/d/news/185912.jpg',
  });

  UserModel fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
