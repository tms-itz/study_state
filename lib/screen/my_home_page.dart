import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:provider/provider.dart';

import 'package:study_state/state/my_home_state.dart';
import 'package:study_state/view_model/my_home_view_model.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    print('MyHomePage build');
    return StateNotifierProvider<MyHomePageStateNotifier, MyHomePageState>(
      create: (context) => MyHomePageStateNotifier(),
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
    final int counter =
        context.watch<MyHomePageState>().counter; //StateNotifierの場合はwatchでもOK
    // final int counter = context.select<MyHomePageState, int>(
    //     (state) => state.counter); //selectは値が変更されたときだけ再描画
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
    final Function increment = context
        .read<MyHomePageStateNotifier>()
        .increment; //readは値を取得するだけ.変更を監視しない

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
            context.read<MyHomePageStateNotifier>().rebuild(); //再描画すると０に戻る
          },
          child: const Text('再描画'),
        ),
      ],
    );
  }
}
