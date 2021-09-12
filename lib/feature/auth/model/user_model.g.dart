// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return UserModel(
    userid: json['userid'] as String?,
    phoneNumber: json['phoneNumber'] as String?,
    nameSurname: json['nameSurname'] as String?,
    statusMessage: json['statusMessage'] as String?,
    imageUrl: json['imageUrl'] as String?,
  );
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'userid': instance.userid,
      'phoneNumber': instance.phoneNumber,
      'nameSurname': instance.nameSurname,
      'statusMessage': instance.statusMessage,
      'imageUrl': instance.imageUrl,
    };
