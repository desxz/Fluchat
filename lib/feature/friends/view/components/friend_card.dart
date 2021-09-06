import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FriendCard extends StatelessWidget {
  FriendCard({
    Key? key,
    this.name,
    this.surname,
    this.imageUrl,
    this.onPressed,
  }) : super(key: key);

  final String? name;
  final String? surname;
  final String? imageUrl;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: ListTile(
        title: Text(name ?? 'Text'),
        subtitle: Text(surname ?? 'Text'),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            placeholder: (context, data) =>
                CircularProgressIndicator.adaptive(),
            imageUrl: imageUrl ?? 'Text',
            width: 40,
            height: 40,
          ),
        ),
      ),
    );
  }
}
