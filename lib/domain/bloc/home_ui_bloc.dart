import 'package:find_your_pokemon_flutter_app/domain/api_global_interface.dart';
import 'package:flutter/foundation.dart';

class HomeUIBloc implements BLoC {
  ValueNotifier<bool> isFilterApplied = ValueNotifier<bool>(false);
  ValueNotifier<int> index = ValueNotifier<int>(0);

  // void applyFilter() {
  //   isFilterApplied.value = !isFilterApplied.value;
  // }

  // void changeIndex(int value) {
  //   index.value = value;
  // }

  @override
  void dispose() {
    isFilterApplied.dispose();
    index.dispose();
  }
}
