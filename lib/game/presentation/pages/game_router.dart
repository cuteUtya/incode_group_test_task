import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:incode_group_test_task/game/presentation/pages/game_page.dart';
import 'package:incode_group_test_task/game/presentation/providers/game_provider.dart';

class GameRouter extends ConsumerStatefulWidget {
  const GameRouter({super.key});

  @override
  createState() => _GameRouterState();
}

class _GameRouterState extends ConsumerState<GameRouter> {
  int currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(gameStateProvider);
    final controller = ref.read(gameStateProvider.notifier);


    return Scaffold(
      appBar: AppBar(
        title: Text(currentTabIndex == 0 ? 'Home Screen' : 'List Screen'),
        actions: [
          TextButton(onPressed: () => controller.reset(), child: Text('Reset'))
        ],
      ),
      body: state is GameStateloading
          ? Container()
          : currentTabIndex == 0
              ? GamePage(
                  controller: controller,
                  state: state as GameStatePlaying,
                )
              : Container(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentTabIndex,
        onTap: (d) => setState(() => currentTabIndex = d),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'List',
          )
        ],
      ),
    );
  }
}
