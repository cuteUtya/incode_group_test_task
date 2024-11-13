import 'package:flutter/material.dart';
import 'package:incode_group_test_task/game/presentation/providers/game_provider.dart';

class PersonagePage extends StatelessWidget {
  final PersonageSaved personage;

  const PersonagePage({
    super.key,
    required this.personage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(personage.personage.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              personage.personage.image,
              width: MediaQuery.of(context).size.width * 0.45,
            ),
            const SizedBox(width: 10),
            if (personage.guessed)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('House: ${personage.personage.house}'),
                    Text(
                        'Date of birth: ${personage.personage.dateOfBirth ?? 'No one knows'}'),
                    Text('Actor: ${personage.personage.actor}'),
                    Text('Species: ${personage.personage.species}')
                  ],
                ),
              )
            else
              const Text(
                'Denied',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.redAccent),
              )
          ],
        ),
      ),
    );
  }
}
