import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:top_accounts/locator.dart';
import 'package:top_accounts/ui/router.dart' as Router;

import 'core/models/account.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        title: 'Top Accounts',
        theme: ThemeData(),
        initialRoute: '/',
        onGenerateRoute: Router.Router.generateRoute,
      );
  }
}
