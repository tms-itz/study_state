import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:study_state/model/provider.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    print('MyHomePage build');
    return Scaffold(
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

class WidgetB extends ConsumerWidget {
  const WidgetB({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('WidgetB build');
    final int counter =
        ref.watch(myHomePageProvider).counter; //context => refに変更
    // final int counter = context.select<MyHomePageState, int>(
    //     (state) => state.counter); //selectは値が変更されたときだけ再描画
    return Text(
      '$counter',
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}

class WidgetC extends ConsumerWidget {
  const WidgetC({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('WidgetC build');
    final Function increment = ref
        .read(myHomePageProvider.notifier)
        .increment; //readは値を取得するだけ.変更を監視しない
    final Function rebuild = ref.read(myHomePageProvider.notifier).rebuild;

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
            rebuild(); //再描画すると０に戻る
          },
          child: const Text('再描画'),
        ),
      ],
    );
  }
}
