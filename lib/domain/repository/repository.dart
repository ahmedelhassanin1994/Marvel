
import 'package:dartz/dartz.dart';
import 'package:mvvm_project/data/network/failure.dart';
import 'package:mvvm_project/data/request/request.dart';
import 'package:mvvm_project/domain/model/model.dart';

abstract class Repository{
  Future <Either<Failure,ModelCharacters>> get_Characters(CharactersRequest charactersRequest);
}