import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:top_accounts/core/models/account.dart';
import 'package:top_accounts/ui/views/home_view.dart';
import 'package:top_accounts/ui/views/account_view.dart';

const String initialRoute = "/";

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomeView());
      case 'account':
        var account = settings.arguments as Account;
        return MaterialPageRoute(builder: (_) => AccountView(account: account));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                child: Text('No route defined for ${settings.name}'),
              ),
            ));
    }
  }
}