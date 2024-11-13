import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:incode_group_test_task/game/presentation/pages/game_page.dart';
import 'package:incode_group_test_task/game/presentation/pages/list_page.dart';
import 'package:incode_group_test_task/game/presentation/providers/game_provider.dart';
import 'package:incode_group_test_task/game/presentation/providers/navigation_provider.dart';

class GameRouter extends ConsumerStatefulWidget {
  const GameRouter({super.key});

  @override
  createState() => _GameRouterState();
}

class _GameRouterState extends ConsumerState<GameRouter> {

  @override
  Widget build(BuildContext context) {
    final currentTabIndex = ref.watch(navigationProvider);
    final state = ref.watch(gameStateProvider);
    final gameController = ref.read(gameStateProvider.notifier);
    final navigatorController = ref.read(navigationProvider.notifier);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(currentTabIndex == 0 ? 'Home Screen' : 'List Screen'),
        actions: [
          TextButton(
            onPressed: () => gameController.reset(),
            child: const Text('Reset'),
          )
        ],
      ),
      body: state is GameStateloading
          ? Container()
          : currentTabIndex == 0
              ? GamePage(
                  controller: gameController,
                  state: state as GameStatePlaying,
                )
              : ListPage(state: state as GameStatePlaying),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentTabIndex,
        onTap: (d) => setState(() => navigatorController.setPage(d)),
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
