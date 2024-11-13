import 'dart:math';

import 'package:incode_group_test_task/api/datasources/personage_datasource_abs.dart';
import 'package:incode_group_test_task/api/data/models/personage_model.dart';

class PersonageRepo {
  final PersonageDatasourceAbs datasource;

  PersonageRepo(this.datasource);

  List<PersonageModel>? personages;

  Future<void> init() async {
    personages = await datasource.fetchPersonages();
  }

  final Random _random = Random();

  PersonageModel next() {
    if (personages == null){
      throw Exception('Please init your PersonageRepo firstly');
    }

    return personages![_random.nextInt(personages!.length)];
  }
}
