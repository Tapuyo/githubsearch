import 'dart:async';

import 'package:flutter/material.dart';
import 'package:githubsearch/ui/home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.push(
          context,
          PageRouteBuilder(
              transitionDuration: const Duration(seconds: 3),
              pageBuilder: (_, __, ___) => const HomePage()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
            child:
                Hero(tag: 'github', child: Image.asset('assets/loading.gif'))),
      ),
    );
  }
}
