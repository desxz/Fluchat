// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageModel _$MessageModelFromJson(Map<String, dynamic> json) {
  return MessageModel(
    senderId: json['senderId'] as String?,
    receiverId: json['receiverId'] as String?,
    message: json['message'] as String?,
    messageTime: json['messageTime'] == null
        ? null
        : DateTime.parse(json['messageTime'] as String),
  );
}

Map<String, dynamic> _$MessageModelToJson(MessageModel instance) =>
    <String, dynamic>{
      'senderId': instance.senderId,
      'receiverId': instance.receiverId,
      'message': instance.message,
      'messageTime': instance.messageTime?.toIso8601String(),
    };
