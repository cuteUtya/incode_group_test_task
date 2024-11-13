import 'package:flutter/material.dart';
import 'package:incode_group_test_task/game/presentation/providers/game_provider.dart';

class PersonageListItem extends StatelessWidget {
  final PersonageSaved personage;
  final void Function() tryAgainClick;
  final void Function() onClick;

  const PersonageListItem({
    super.key,
    required this.personage,
    required this.tryAgainClick,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onClick(),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Image.network(
              personage.personage.image,
              height: 72,
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  personage.personage.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('Attempts: ${personage.guessesCount}')
              ],
            ),
            const Spacer(),
            if (!personage.guessed)
              IconButton(
                onPressed: () => tryAgainClick(),
                icon: const Icon(Icons.repeat),
              ),
            const SizedBox(width: 16),
            Icon(
              personage.guessed ? Icons.check_circle : Icons.close,
              size: 30,
              color: personage.guessed ? Colors.green : Colors.red,
            )
          ],
        ),
      ),
    );
  }
}
