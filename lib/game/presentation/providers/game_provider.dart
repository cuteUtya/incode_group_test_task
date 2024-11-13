import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:incode_group_test_task/api/datasources/personage_remote_datasource.dart';
import 'package:incode_group_test_task/api/data/models/personage_model.dart';
import 'package:incode_group_test_task/api/data/repositories/personage_repo.dart';

abstract class GameState {}

class GameStateloading extends GameState {}

class GameStatePlaying extends GameState {
  PersonageModel currentPersonage;
  GameStatistic gameStat;
  Map<PersonageModel, PersonageSaved> list = {};

  GameStatePlaying(
      {required this.currentPersonage,
      required this.gameStat,
      required this.list});
}

class PersonageSaved {
  int guessesCount;
  bool guessed;
  PersonageModel personage;

  PersonageSaved({
    this.guessed = false,
    this.guessesCount = 0,
    required this.personage,
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

  static GameStatistic zero() => GameStatistic(
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
          gameStat: GameStatistic.zero(),
          list: {});
    });
  }

  void updatePersonage({PersonageModel? newPersonage}) {
    if (state is GameStatePlaying) {
      state = GameStatePlaying(
        currentPersonage: newPersonage ?? repo.next(),
        gameStat: (state as GameStatePlaying).gameStat,
        list: (state as GameStatePlaying).list,
      );
      return;
    }

    throw Exception('You cannot update personage when game is loading');
  }

  void reset() {
    state = GameStatePlaying(
      currentPersonage: repo.next(),
      gameStat: GameStatistic.zero(),
      list: {},
    );
  }

  void guessHouse(String house) {
    if (state is GameStatePlaying) {
      var playingState = state as GameStatePlaying;
      late bool guessed;

      if (house == 'Not in the house' &&
              playingState.currentPersonage.house.isEmpty ||
          house == playingState.currentPersonage.house) {
        guessed = true;
      } else {
        guessed = false;
      }

      //Update score
      playingState.gameStat._update(guessed: guessed);

      //A1dd personage to the list, or update guess count
      if (playingState.list[playingState.currentPersonage] == null) {
        playingState.list[playingState.currentPersonage] =
            PersonageSaved(personage: playingState.currentPersonage);
      }

      if (guessed) {
        playingState.list[playingState.currentPersonage]!.guessed = true;
      } else {
        playingState.list[playingState.currentPersonage]!.guessesCount++;
      }

      //Next personage
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
