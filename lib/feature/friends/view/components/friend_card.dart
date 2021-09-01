import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FriendCard extends StatelessWidget {
  FriendCard({
    Key? key,
    this.name,
    this.surname,
    this.imageUrl,
  }) : super(key: key);

  final String? name;
  final String? surname;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name ?? 'Text'),
      subtitle: Text(surname ?? 'Text'),
      leading: CircleAvatar(
        radius: 36,
        child: CachedNetworkImage(imageUrl: imageUrl ?? 'Text'),
      ),
    );
  }
}
