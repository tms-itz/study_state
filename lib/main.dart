import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  late MyHomePageLogic myHomePageLogic;

  @override
  void initState() {
    super.initState();
    myHomePageLogic = MyHomePageLogic();
  }

  @override
  Widget build(BuildContext context) {
    print('MyHomePage build');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const WidgetA(),
            WidgetB(myHomePageLogic),
            WidgetC(myHomePageLogic),
          ],
        ),
      ),
    );
  }
}

class MyHomePageLogic {
  MyHomePageLogic() {
    _counterController.sink.add(_counter);
  }

  final StreamController<int> _counterController = StreamController<int>();
  int _counter = 0;
  Stream<int> get count => _counterController.stream;

  void incrementCounter() {
    _counter++;
    _counterController.sink.add(_counter);
  }

  void dispose() {
    _counterController.close();
  }
}

class WidgetA extends StatelessWidget {
  const WidgetA({super.key});

  @override
  Widget build(BuildContext context) {
    print('WidgetA build');
    return const Text('You have pushed the button this many times:');
  }
}

class WidgetB extends StatelessWidget {
  const WidgetB(this.myHomePageLogic, {super.key});
  final MyHomePageLogic myHomePageLogic;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
        stream: myHomePageLogic.count,
        builder: (context, snapshot) {
          print('WidgetB build');
          return Text(
            '${snapshot.data}',
            style: Theme.of(context).textTheme.headlineMedium,
          );
        });
  }
}

class WidgetC extends StatelessWidget {
  const WidgetC(this.myHomePageLogic, {super.key});
  final MyHomePageLogic myHomePageLogic;

  @override
  Widget build(BuildContext context) {
    print('WidgetC build');
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            myHomePageLogic.incrementCounter();
          },
          child: const Text('カウント'),
        ),
      ],
    );
  }
}
