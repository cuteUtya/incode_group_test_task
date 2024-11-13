import 'package:flutter/material.dart';
import 'package:incode_group_test_task/game/presentation/providers/gave_provider.dart';
import 'package:incode_group_test_task/game/presentation/widgets/stats_widget.dart';

class GamePage extends StatefulWidget {
  const GamePage({
    super.key,
    required this.controller,
    required this.state,
  });

  final GameStatePlaying state;
  final GameController controller;

  @override
  createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StatsWidget(statistic: widget.state.gameStat),
      ],
    );
  }
}
