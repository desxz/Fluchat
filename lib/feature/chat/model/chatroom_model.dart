import 'package:json_annotation/json_annotation.dart';

part 'chatroom_model.g.dart';

@JsonSerializable()
class ChatRoom {
  String? id;
  List<String>? usersId;
  DateTime? creatingTime;

  ChatRoom({
    this.id,
    this.usersId,
    this.creatingTime,
  });

  ChatRoom fromJson(Map<String, dynamic> json) => _$ChatRoomFromJson(json);

  Map<String, dynamic> toJson() => _$ChatRoomToJson(this);
}
