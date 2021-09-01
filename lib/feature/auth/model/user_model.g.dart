// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return UserModel(
    userid: json['userid'] as String?,
    email: json['email'] as String?,
    password: json['password'] as String?,
    name: json['name'] as String?,
    surname: json['surname'] as String?,
    imageUrl: json['imageUrl'] as String?,
  );
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'userid': instance.userid,
      'email': instance.email,
      'password': instance.password,
      'name': instance.name,
      'surname': instance.surname,
      'imageUrl': instance.imageUrl,
    };
