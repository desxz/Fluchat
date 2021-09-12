import 'package:json_annotation/json_annotation.dart';

part 'chatroom_model.g.dart';

@JsonSerializable()
class ChatRoom {
  String? id;
  List<Map<String, dynamic>?>? users;
  //DateTime? creatingTime;
  DateTime? lastMessage;

  ChatRoom({
    this.id,
    this.users,
    //this.creatingTime,
    this.lastMessage,
  });

  ChatRoom fromJson(Map<String, dynamic> json) => _$ChatRoomFromJson(json);

  Map<String, dynamic> toJson() => _$ChatRoomToJson(this);
}
