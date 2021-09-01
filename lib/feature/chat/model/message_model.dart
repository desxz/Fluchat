import 'package:json_annotation/json_annotation.dart';

part 'message_model.g.dart';

@JsonSerializable()
class ChatRoom {
  String? senderId;
  String? receiverId;
  List<String>? messages;

  ChatRoom({
    this.senderId,
    this.receiverId,
    this.messages,
  });

  ChatRoom fromJson(Map<String, dynamic> json) => _$ChatRoomFromJson(json);
  Map<String, dynamic> toJson() => _$ChatRoomToJson(this);
}
