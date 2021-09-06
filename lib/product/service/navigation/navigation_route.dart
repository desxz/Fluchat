import 'package:flutter/material.dart';

import '../../../feature/auth/model/user_model.dart';
import '../../../feature/auth/view/verification_view.dart';
import '../../../feature/calls/view/calls_view.dart';
import '../../../feature/chat/view/chat_view.dart';
import '../../../feature/friends/view/friends_view.dart';
import '../../../feature/home/view/home_view.dart';
import '../../../feature/layout/tab/view/tab_view.dart';
import '../../../feature/splash/view/splash_view.dart';
import '../../constants/navigation_constants.dart';

class NavigationRoute {
  static final NavigationRoute _instance = NavigationRoute._init();
  static NavigationRoute get instance => _instance;

  NavigationRoute._init();

  Route<dynamic> generateRoute(RouteSettings settings) {
    var arguments = settings.arguments;
    switch (settings.name) {
      case NavigationConstants.AUTH:
        return normalNavigate(VerificationView());
      case NavigationConstants.HOME:
        return normalNavigate(HomeView());
      case NavigationConstants.FRIENDS:
        return normalNavigate(FriendsView());
      case NavigationConstants.CALLS:
        return normalNavigate(CallsView());
      case NavigationConstants.SPLASH:
        return normalNavigate(SplashView());
      case NavigationConstants.TAB:
        return normalNavigate(TabView(
            //  user: arguments as User,
            ));
      case NavigationConstants.CHAT:
        return normalNavigate(ChatView(
          user: arguments as UserModel,
        ));

      default:
        return MaterialPageRoute(
          builder: (context) => NotFoundNavigationWidget(),
        );
    }
  }

  MaterialPageRoute normalNavigate(Widget widget) {
    return MaterialPageRoute(
      builder: (context) => widget,
    );
  }
}

class NotFoundNavigationWidget extends StatelessWidget {
  const NotFoundNavigationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.red,
        child: Center(
          child: Text('NAVIGATION\nNOT\nFOUND!',
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(color: Colors.white)),
        ),
      ),
    );
  }
}
