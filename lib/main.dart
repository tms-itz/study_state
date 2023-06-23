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
  int counter = 0;

  void incrementCounter() {
    setState(() {
      counter++;
    });
  }

  void rebuild() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print('MyHomePage build');
    return MyHomePageInheritedWidget(
      data: this,
      counter: counter,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
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

class MyHomePageInheritedWidget extends InheritedWidget {
  const MyHomePageInheritedWidget({
    Key? key,
    required Widget child,
    required this.data,
    required this.counter,
  }) : super(key: key, child: child);

  final MyHomePageState data;
  final int counter;

  static MyHomePageState of(BuildContext context, {bool listen = true}) {
    if (listen) {
      return (context
              .dependOnInheritedWidgetOfExactType<MyHomePageInheritedWidget>()!)
          .data;
    } else {
      return (context
              .getElementForInheritedWidgetOfExactType<
                  MyHomePageInheritedWidget>()!
              .widget as MyHomePageInheritedWidget)
          .data;
    }
  }

  @override
  bool updateShouldNotify(MyHomePageInheritedWidget oldWidget) {
    return counter != oldWidget.counter; // カウンターの値が変わったら再描画
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
    final MyHomePageState state = MyHomePageInheritedWidget.of(context);

    return Text(
      '${state.counter}',
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}

class WidgetC extends StatelessWidget {
  const WidgetC({super.key});

  @override
  Widget build(BuildContext context) {
    print('WidgetC build');
    final MyHomePageState state =
        MyHomePageInheritedWidget.of(context, listen: false); //falseにすると再描画されない

    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            state.incrementCounter();
          },
          child: const Text('カウント'),
        ),
        ElevatedButton(
          onPressed: () {
            state.rebuild();
          },
          child: const Text('再描画'),
        )
      ],
    );
  }
}
