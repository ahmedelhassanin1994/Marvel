

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:mvvm_project/app/constant.dart';
import 'package:mvvm_project/app/di.dart';
import 'package:mvvm_project/domain/usecase/home_usecase.dart';
import 'package:mvvm_project/presentation/base/baseviewmodel.dart';
import 'package:mvvm_project/presentation/common/freezed_data_classes.dart';
import 'package:mvvm_project/presentation/common/state_renderer/state_renderer.dart';
import 'package:mvvm_project/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

import 'package:mvvm_project/presentation/home/home_page_state.dart';

class CharactersViewModel extends ChangeNotifier {


  LoginUseCase _loginUseCase;


  CharactersViewModel(this._loginUseCase);


  @override
  void dispose() {
    // TODO: implement dispose

  }

  @override
  void start() {
    // TODO: implement start
    _state=HomeLoadingState();
  }


  HomeState _state = HomeInitialState();

  HomeState get state => _state;


  Future<void> getCharacters() async {
    notifyListeners();

    final hash = md5.convert(utf8.encode("1${Constant.privateKey}${Constant.publicKey}"));

    ( await _loginUseCase.execute(CharactersUseCaseInput(Constant.publicKey,'$hash','1',20))).fold(
            (failure) => {

            _state = HomeFailureState(message: failure.message),
             notifyListeners(),

        }, (data) => {

    if (data.data_characters.results!.isEmpty) {
        _state = HomeEmptyState(),
  } else {
    _state = HomeSuccessState(data),
    },
    notifyListeners(),
    });

  }
}

