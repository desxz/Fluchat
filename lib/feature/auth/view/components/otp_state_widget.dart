import 'package:flutter/material.dart';

class OTPStateWidget extends StatelessWidget {
  const OTPStateWidget(
      {Key? key, this.controller, this.buttonText, this.onPressed})
      : super(key: key);
  final TextEditingController? controller;
  final String? buttonText;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: controller,
            decoration: InputDecoration(hintText: 'Verification code'),
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
