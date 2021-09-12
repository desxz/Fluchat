// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chatroom_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatRoom _$ChatRoomFromJson(Map<String, dynamic> json) {
  return ChatRoom(
    id: json['id'] as String?,
    users: (json['users'] as List<dynamic>?)
        ?.map((e) => e as Map<String, dynamic>?)
        .toList(),
    lastMessage: json['lastMessage'] == null
        ? null
        : DateTime.parse(json['lastMessage'] as String),
  );
}

Map<String, dynamic> _$ChatRoomToJson(ChatRoom instance) => <String, dynamic>{
      'id': instance.id,
      'users': instance.users,
      'lastMessage': instance.lastMessage?.toIso8601String(),
    };
