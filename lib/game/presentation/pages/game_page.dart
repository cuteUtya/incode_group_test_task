import 'package:flutter/material.dart';
import 'package:incode_group_test_task/game/presentation/providers/game_provider.dart';
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
    return RefreshIndicator(
      onRefresh: () async {
        widget.controller.updatePersonage();
      },
      child: ListView(
        children: [
          StatsWidget(key: UniqueKey(), statistic: widget.state.gameStat),
          const SizedBox(height: 16),
          Image.network(
            widget.state.currentPersonage.image,
            height: MediaQuery.of(context).size.height / 4,
          ),
          const SizedBox(height: 8),
         Center(child:   Text(
            widget.state.currentPersonage.name,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),),
          ),
           Row(
            children: [
              _houseCard('Gryffindor'),
              _houseCard('Slytherin'),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              _houseCard('Ravenclaw'),
              _houseCard('Hufflepuff'),
            ],
          ),
          const SizedBox(height: 8),
          _houseCard('Not in the house')
        ],
      ),
    );
  }

  Widget _houseCard(String house) {
    return Expanded(
      child: InkWell(
        onTap: () => widget.controller.guessHouse(house),
        child: SizedBox(
          child: Card(
            margin: const EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  if (house != 'Not in the house')
                    Icon({
                      'Gryffindor': Icons.pets,
                      'Slytherin': Icons.bug_report,
                      'Ravenclaw': Icons.emoji_nature,
                      'Hufflepuff': Icons.cruelty_free
                    }[house]),
                  const SizedBox(height: 8),
                  Text(house),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
