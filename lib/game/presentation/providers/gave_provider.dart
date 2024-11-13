import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:incode_group_test_task/api/datasources/personage_remote_datasource.dart';
import 'package:incode_group_test_task/api/data/models/personage_model.dart';
import 'package:incode_group_test_task/api/data/repositories/personage_repo.dart';

abstract class GameState {}

class GameStateloading extends GameState {}

class GameStatePlaying extends GameState {
  PersonageModel currentPersonage;
  GameStatistic gameStat;
  Map<PersonageModel, int> list = {};

  GameStatePlaying({
    required this.currentPersonage,
    required this.gameStat,
  });
}

class GameStatistic {
  int total;
  int success;
  int failed;

  GameStatistic({
    required this.total,
    required this.failed,
    required this.success,
  });

  void _update({required bool guessed}) {
    total++;
    if (guessed) {
      success++;
    } else {
      failed++;
    }
  }

  static GameStatistic zero = GameStatistic(
    total: 0,
    failed: 0,
    success: 0,
  );
}

class GameController extends StateNotifier<GameState> {
  final PersonageRepo repo = PersonageRepo(PersonageRemoteDatasource());

  GameController() : super(GameStateloading()) {
    repo.init().then((_) {
      state = GameStatePlaying(
        currentPersonage: repo.next(),
        gameStat: GameStatistic.zero,
      );
    });
  }

  void updatePersonage() {
    if (state is GameStatePlaying) {
      state = (state as GameStatePlaying)..currentPersonage = repo.next();
      return;
    }

    throw Exception('You cannot update personage when game is loading');
  }

  void guessHouse(String house) {
    if (state is GameStatePlaying) {
      var playingState = state as GameStatePlaying;
      bool guessed = playingState.currentPersonage.house == house;
      playingState.gameStat._update(guessed: guessed);

      if (playingState.list[playingState.currentPersonage] == null) {
        playingState.list[playingState.currentPersonage] = 0;
      }

      if (!guessed) {
        playingState.list[playingState.currentPersonage] =
            playingState.list[playingState.currentPersonage]! + 1;
      }

      updatePersonage();
      return;
    }

    throw Exception('You cannot start playing until game is not loaded');
  }
}

final gameStateProvider =
    StateNotifierProvider<GameController, GameState>((ref) {
  return GameController();
});
