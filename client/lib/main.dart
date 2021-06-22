import 'package:client/rest_client.dart';
import 'package:client/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const appName = 'Image Search with Natural Language';

void main() {
  runApp(MultiProvider(providers: [
    Provider(
      create: (context) => RestClient(),
    ),
  ], child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      initialRoute: MainScreen.routeName,
      debugShowCheckedModeBanner: false,
      routes: {
        MainScreen.routeName: (context) => MainScreen(),
      },
    );
  }
}
