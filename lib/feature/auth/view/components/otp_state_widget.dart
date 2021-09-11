import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/material.dart';

class OTPStateWidget extends StatelessWidget {
  const OTPStateWidget(
      {Key? key,
      this.controller,
      this.buttonText,
      this.onPressed,
      this.onPressedResendButton,
      this.duration})
      : super(key: key);
  final TextEditingController? controller;
  final String? buttonText;
  final VoidCallback? onPressed;
  final int? duration;
  final dynamic Function(Function, ButtonState?)? onPressedResendButton;

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
          SizedBox(
            height: 40,
          ),
          buildResendButtonWithTimer(context),
        ],
      ),
    );
  }

  ArgonTimerButton buildResendButtonWithTimer(BuildContext context) {
    return ArgonTimerButton(
      roundLoadingShape: true,
      height: 50,
      initialTimer: duration!,
      width: MediaQuery.of(context).size.width * 0.45,
      onTap: onPressedResendButton,
      child: Text(
        "Resend OTP",
        style: TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
      ),
      loader: (timeLeft) {
        return Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(50)),
          margin: EdgeInsets.all(5),
          alignment: Alignment.center,
          width: 40,
          height: 40,
          child: Text(
            "$timeLeft",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
        );
      },
      borderRadius: 5.0,
      color: Color(0xFF7866FE),
    );
  }
}
