import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:incode_group_test_task/game/presentation/pages/personage_page.dart';
import 'package:incode_group_test_task/game/presentation/providers/game_provider.dart';
import 'package:incode_group_test_task/game/presentation/providers/navigation_provider.dart';
import 'package:incode_group_test_task/game/presentation/widgets/personage_list_item.dart';
import 'package:incode_group_test_task/game/presentation/widgets/stats_widget.dart';

class ListPage extends ConsumerStatefulWidget {
  const ListPage({
    super.key,
    required this.state,
  });
  final GameStatePlaying state;

  @override
  createState() => _ListPageState();
}

class _ListPageState extends ConsumerState<ListPage> {
  TextEditingController editingController = TextEditingController();
  String searchRequest = '';

  @override
  void initState() {
    editingController.addListener(
        () => setState(() => searchRequest = editingController.text));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        children: <Widget>[
              StatsWidget(
                statistic: widget.state.gameStat,
              ),
              const SizedBox(height: 12),
              TextField(
                decoration: const InputDecoration(border: OutlineInputBorder()),
                controller: editingController,
              ),
              const SizedBox(height: 12),
            ] +
            widget.state.list.values
                //Search
                .where(
                  (e) => searchRequest.isEmpty
                      ? true
                      : e.personage.name
                          .toLowerCase()
                          .contains(searchRequest.toLowerCase()),
                )
                .map((b) => PersonageListItem(
                      personage: b,
                      onClick: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (__) => PersonagePage(personage: b),
                        ),
                      ),
                      tryAgainClick: () {
                        ref.read(navigationProvider.notifier).setPage(0);
                        ref
                            .read(gameStateProvider.notifier)
                            .updatePersonage(newPersonage: b.personage);
                      },
                    ))
                .toList(),
      ),
    );
  }
}
