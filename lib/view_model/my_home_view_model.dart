import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:study_state/state/my_home_state.dart';

class MyHomePageStateNotifier extends StateNotifier<MyHomePageState> {
  MyHomePageStateNotifier() : super(const MyHomePageState()); //初期値を設定

  void increment() {
    state = state.copyWith(state.counter + 1); //stateは現在の状態を表す
  }

  void rebuild() {
    state = const MyHomePageState();
  }
  
}
