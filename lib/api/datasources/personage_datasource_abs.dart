import 'package:incode_group_test_task/api/data/models/personage_model.dart';

abstract class PersonageDatasourceAbs {
  Future<List<PersonageModel>> fetchPersonages();
}