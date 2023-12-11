import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:study_state/state/my_home_state.dart';
import 'package:study_state/view_model/my_home_view_model.dart';

final myHomePageProvider =
    StateNotifierProvider<MyHomePageStateNotifier, MyHomePageState>(
        (ref) => MyHomePageStateNotifier());
