import 'package:flutter/material.dart';

class SearchNear extends StatelessWidget {
  const SearchNear({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: Center(child: Text('Shroida')),
      ),
    );
  }
}
