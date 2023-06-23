import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    print('MyHomePage build');
    return ChangeNotifierProvider(
      create: (context) => MyHomePageState(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Flutter Demo Home Page'),
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              WidgetA(),
              WidgetB(),
              WidgetC(),
            ],
          ),
        ),
      ),
    );
  }
}

class MyHomePageState extends ChangeNotifier {
  int counter = 0;

  void increment() {
    counter++;
    notifyListeners();
  }

  void rebuild() {
    notifyListeners();
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
  const WidgetB({super.key});

  @override
  Widget build(BuildContext context) {
    print('WidgetB build');
    // final int counter =
    //     context.watch<MyHomePageState>().counter; //watchは値を取得して、変更を監視する
    final int counter = context.select<MyHomePageState, int>(
        (state) => state.counter); //selectは値が変更されたときだけ再描画
    return Text(
      '$counter',
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}

class WidgetC extends StatelessWidget {
  const WidgetC({super.key});

  @override
  Widget build(BuildContext context) {
    print('WidgetC build');
    final Function increment =
        context.read<MyHomePageState>().increment; //readは値を取得するだけ.変更を監視しない
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            increment();
          },
          child: const Text('カウント'),
        ),
        ElevatedButton(
          onPressed: () {
            context.read<MyHomePageState>().rebuild();
          },
          child: const Text('再描画'),
        ),
      ],
    );
  }
}
