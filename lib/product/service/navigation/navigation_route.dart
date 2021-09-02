import 'package:flutter/material.dart';

import '../../../feature/auth/model/user_model.dart';
import '../../../feature/auth/view/login_view.dart';
import '../../../feature/auth/view/register_view.dart';
import '../../../feature/chat/view/chat_view.dart';
import '../../../feature/friends/view/friends_view.dart';
import '../../../feature/home/view/home_view.dart';
import '../../constants/navigation_constants.dart';

class NavigationRoute {
  static final NavigationRoute _instance = NavigationRoute._init();
  static NavigationRoute get instance => _instance;

  NavigationRoute._init();

  Route<dynamic> generateRoute(RouteSettings settings) {
    var arguments = settings.arguments;
    switch (settings.name) {
      case NavigationConstants.REGISTER:
        return normalNavigate(RegisterView());
      case NavigationConstants.LOGIN:
        return normalNavigate(LoginView());
      case NavigationConstants.HOME:
        return normalNavigate(HomeView());
      case NavigationConstants.USERS:
        return normalNavigate(FriendsView());
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
