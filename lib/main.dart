import 'package:assignment/Screens/home_screen.dart';
import 'package:assignment/Screens/map_screen.dart';
import 'package:flutter/material.dart';
import 'Utils/utils.dart';

void main() async {
  runApp(
    const Assignment(),
  );
}

class Assignment extends StatelessWidget {
  const Assignment({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        Utils.homeScreenRoute: (context) => const HomeScreen(), // Default route
        Utils.mapScreenRoute: (context) =>
            MapScreen(), // Example of another route
      },
    );
  }
}
