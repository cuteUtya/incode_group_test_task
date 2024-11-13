import 'package:incode_group_test_task/data/datasources/personage_datasource_abs.dart';
import 'package:incode_group_test_task/data/models/personage_model.dart';

import 'package:dio/dio.dart' ;

class PersonageRemoteDatasource implements PersonageDatasourceAbs {
  
  final apiEndPoint = 'https://hp-api.onrender.com/api/characters';

  @override
  Future<List<PersonageModel>> fetchPersonages() async {
    var responce = await Dio().get(apiEndPoint);
    var data = responce.data as List<dynamic>;
    return data.map((e) => PersonageModel.fromJson(e)).toList();
  }
}