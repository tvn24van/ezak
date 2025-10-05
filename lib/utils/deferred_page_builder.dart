import 'package:flutter/material.dart';

class DeferredPageBuilder extends StatelessWidget{
  final Future<dynamic> Function() future;
  final Widget Function() page;

  const DeferredPageBuilder({super.key, required this.future, required this.page});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future(),
      builder: (context, snapshot) => snapshot.connectionState==ConnectionState.done? page() : Scaffold()
    );
  }

}