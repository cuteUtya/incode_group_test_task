import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:incode_group_test_task/data/datasources/personage_remote_datasource.dart';
import 'package:incode_group_test_task/data/models/personage_model.dart';
import 'package:incode_group_test_task/data/repositories/personage_repo.dart';

abstract class PersonageProviderState {}
class PersonageProviderStateLoading extends PersonageProviderState {}
class PersonageProviderStateReady extends PersonageProviderState {}

class ServiceStateNotifier extends StateNotifier<PersonageProviderState> {
  final PersonageRepo repo = PersonageRepo(PersonageRemoteDatasource());

  ServiceStateNotifier(): super(PersonageProviderStateLoading()) {
    repo.init().then((_) {
      state = PersonageProviderStateReady();
    });
  }

  PersonageModel getRandomPersonage() {
    return repo.next();
  }
}
 