import 'package:json_annotation/json_annotation.dart';

part 'message_model.g.dart';

@JsonSerializable()
class MessageModel {
  String? senderId;
  String? receiverId;
  String? message;
  DateTime? messageTime;

  MessageModel({
    this.senderId,
    this.receiverId,
    this.message,
    this.messageTime,
  });

  MessageModel fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$MessageModelToJson(this);
}
