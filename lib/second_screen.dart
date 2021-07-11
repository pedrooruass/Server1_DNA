import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {

  final String title;
  final String infos;

  const SecondScreen({
    this.title,
    this.infos,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(infos),
        ),
      ]),
    );
  }
}
