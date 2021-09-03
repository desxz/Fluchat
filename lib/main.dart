import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'product/constants/navigation_constants.dart';
import 'product/service/navigation/navigation_route.dart';
import 'product/service/navigation/navigation_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FluChat',
      debugShowCheckedModeBanner: false,
      initialRoute: NavigationConstants.AUTH,
      navigatorKey: NavigationService.instance.navigatorKey,
      onGenerateRoute: NavigationRoute.instance.generateRoute,
    );
  }
}
