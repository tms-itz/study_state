import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:study_state/state/my_home_state.dart';
import 'package:study_state/view_model/my_home_view_model.dart';

final myHomePageProvider =
    StateNotifierProvider<MyHomePageStateNotifier, MyHomePageState>(
        (ref) => MyHomePageStateNotifier());

final dogImageProvider = StateProvider((ref) =>
    'https://images.dog.ceo/breeds/schnauzer-miniature/n02097047_3534.jpg');
