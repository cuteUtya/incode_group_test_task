import 'package:flutter/material.dart';
import 'package:incode_group_test_task/game/presentation/providers/game_provider.dart';

class StatsWidget extends StatelessWidget {
  final GameStatistic statistic;

  const StatsWidget({
    super.key,
    required this.statistic,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _tile('Total', statistic.total.toString()),
        _tile('Success', statistic.success.toString()),
        _tile('Failed', statistic.failed.toString())
      ],
    );
  }

  Widget _tile(String name, String value) {
    return Card(

      child: Padding(padding: EdgeInsets.all(20), child:  Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(name),
        ],
      ),),
    );
  }
}
