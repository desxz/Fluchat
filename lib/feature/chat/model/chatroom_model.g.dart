// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chatroom_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatRoom _$ChatRoomFromJson(Map<String, dynamic> json) {
  return ChatRoom(
    id: json['id'] as String?,
    usersId:
        (json['usersId'] as List<dynamic>?)?.map((e) => e as String).toList(),
    creatingTime: json['creatingTime'] == null
        ? null
        : DateTime.parse(json['creatingTime'] as String),
  );
}

Map<String, dynamic> _$ChatRoomToJson(ChatRoom instance) => <String, dynamic>{
      'id': instance.id,
      'usersId': instance.usersId,
      'creatingTime': instance.creatingTime?.toIso8601String(),
    };
