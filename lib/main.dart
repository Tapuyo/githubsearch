import 'package:flutter/material.dart';
import 'package:githubsearch/provider/profile.dart';
import 'package:githubsearch/routes/route_generator.dart';
import 'package:githubsearch/routes/routes.dart';
import 'package:githubsearch/splash_page.dart';
import 'package:githubsearch/ui/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ProfileProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
     MaterialApp(
       title: 'Work4uTutor',
       initialRoute: Routes.splash,
       onGenerateRoute: RouteGenerator.generateRoute,
       debugShowCheckedModeBanner: false,
       theme: ThemeData(
       fontFamily: "Nunito",
       canvasColor: Colors.white,
       primarySwatch: Colors.indigo,
     ),
       home: const SplashPage(),
     );
  }
}

