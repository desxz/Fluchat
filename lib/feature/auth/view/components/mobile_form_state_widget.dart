import 'package:flutter/material.dart';

class MobileFormStateWidget extends StatelessWidget {
  const MobileFormStateWidget(
      {Key? key, this.controller, this.buttonText, required this.onPressed})
      : super(key: key);
  final TextEditingController? controller;
  final String? buttonText;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            decoration: InputDecoration(hintText: 'Phone number'),
            controller: controller,
          ),
          TextButton(
            onPressed: onPressed,
            child: Text(buttonText ?? 'Null'),
          ),
        ],
      ),
    );
  }
}
