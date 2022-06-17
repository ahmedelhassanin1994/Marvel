
import 'package:dartz/dartz.dart';
import 'package:mvvm_project/data/network/failure.dart';
import 'package:mvvm_project/data/request/request.dart';
import 'package:mvvm_project/domain/model/model.dart';
import 'package:mvvm_project/domain/repository/repository.dart';
import 'package:mvvm_project/domain/usecase/base_usecase.dart';

class LoginUseCase implements BaseCase<CharactersUseCaseInput,ModelCharacters>{

 late Repository _repository;

 LoginUseCase(this._repository);

  @override
  Future<Either<Failure, ModelCharacters>> execute(CharactersUseCaseInput input) async{
    // TODO: implement execute
   return  await _repository.get_Characters(CharactersRequest(input.api_key,input.ts,input.hash,input.limit));
  }

}

class CharactersUseCaseInput{
  late String api_key;
  late String hash;
  late String ts;
  late int limit;

  CharactersUseCaseInput(this.api_key, this.hash, this.ts, this.limit);
}