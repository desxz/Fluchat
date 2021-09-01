import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../product/service/navigation/navigation_service.dart';
import '../../auth/model/user_model.dart';

class ChatView extends StatelessWidget {
  const ChatView({Key? key, this.user}) : super(key: key);

  final UserModel? user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: IconButton(
            onPressed: () => NavigationService.instance.navigateToPop(),
            icon: Icon(Icons.arrow_back)),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
                radius: 20,
                child: CachedNetworkImage(imageUrl: user?.imageUrl ?? '')),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.07,
            ),
            Text('${user?.name} ${user?.surname}'),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.phone)),
          IconButton(onPressed: () {}, icon: Icon(Icons.videocam)),
        ],
      ),
      body: Column(
        children: [
          Expanded(child: Container()),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder().copyWith(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: IconButton(onPressed: () {}, icon: Icon(Icons.send)),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
