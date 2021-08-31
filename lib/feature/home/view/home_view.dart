import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: CircleAvatar(
                    radius: 30,
                    child: CachedNetworkImage(imageUrl: ''),
                  ),
                ),
                itemCount: 12,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Expanded(
                flex: 8,
                child: ListView.builder(
                    itemCount: 30,
                    itemBuilder: (context, index) => Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 24,
                              child: CachedNetworkImage(imageUrl: ''),
                            ),
                            title: Text('Kemal Güneş'),
                            subtitle: Text('.D'),
                            trailing: Text('12:20'),
                          ),
                        ))),
          ],
        ),
      ),
    );
  }
}
