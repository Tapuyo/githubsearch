import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:githubsearch/splash_page.dart';
import 'package:githubsearch/ui/home_page.dart';

import 'routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    //final args = settings.arguments;

    switch (settings.name) {
      case Routes.splash:
        return CupertinoPageRoute(builder: (_) => const SplashPage());

      case Routes.home:
        return CupertinoPageRoute(builder: (_) => const HomePage());

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return CupertinoPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Error'),
        ),
      );
    });
  }
}
