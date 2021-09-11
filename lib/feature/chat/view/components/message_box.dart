import 'package:flutter/material.dart';

import '../../../auth/model/user_model.dart';

class MessageBox extends StatelessWidget {
  const MessageBox({
    Key? key,
    required this.user,
    required this.color,
    required this.message,
    required this.time,
    required this.statusIcon,
  }) : super(key: key);

  final UserModel user;
  final Color color;
  final String message;
  final DateTime time;
  final IconData statusIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      constraints: BoxConstraints(
        minWidth: MediaQuery.of(context).size.width / 5,
        maxWidth: MediaQuery.of(context).size.width * 0.75,
        minHeight: 40,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: Colors.white, fontSize: 16),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                time.hour.toString() +
                    ':' +
                    (time.minute.toString() == '0'
                        ? '00'
                        : time.minute.toString()),
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: Colors.grey.shade600,
                      fontSize: 14,
                    ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                width: 5,
              ),
              Icon(
                statusIcon,
                color: Colors.black,
                size: 16,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
