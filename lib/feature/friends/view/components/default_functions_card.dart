import 'package:flutter/material.dart';

class DefaultFunctionsCard extends StatelessWidget {
  const DefaultFunctionsCard(
      {Key? key, this.title, this.onPressed, this.leading, this.trailing})
      : super(key: key);

  final Widget? title;
  final VoidCallback? onPressed;
  final Widget? leading;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: ListTile(
        title: title ?? SizedBox(),
        leading: ClipRRect(
          child: CircleAvatar(child: leading, radius: 20),
        ),
        trailing: trailing,
      ),
    );
  }
}
