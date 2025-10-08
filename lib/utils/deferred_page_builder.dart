import 'package:flutter/material.dart';

class DeferredPageBuilder extends StatefulWidget{
  final Future<dynamic> Function() future;
  final Widget Function() page;

  const DeferredPageBuilder({super.key, required this.future, required this.page});

  @override
  State<StatefulWidget> createState() {
    return _DeferredPageBuilderState();
  }

}

class _DeferredPageBuilderState extends State<DeferredPageBuilder>{
  late final _loadedFuture = widget.future();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadedFuture,
      builder: (context, snapshot) => snapshot.connectionState==ConnectionState.done? widget.page() : Scaffold()
    );
  }
}