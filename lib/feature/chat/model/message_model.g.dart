// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatRoom _$ChatRoomFromJson(Map<String, dynamic> json) {
  return ChatRoom(
    senderId: json['senderId'] as String?,
    receiverId: json['receiverId'] as String?,
    messages:
        (json['messages'] as List<dynamic>?)?.map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$ChatRoomToJson(ChatRoom instance) => <String, dynamic>{
      'senderId': instance.senderId,
      'receiverId': instance.receiverId,
      'messages': instance.messages,
    };
