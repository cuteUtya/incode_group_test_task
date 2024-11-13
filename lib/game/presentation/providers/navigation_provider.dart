import 'package:flutter_riverpod/flutter_riverpod.dart';

class NavigationProvider extends StateNotifier<int> {
  NavigationProvider() : super(0);

  void setPage(int index) {
    state = index;
  }
}

final navigationProvider =
    StateNotifierProvider<NavigationProvider, int>((ref) {
  return NavigationProvider();
});
