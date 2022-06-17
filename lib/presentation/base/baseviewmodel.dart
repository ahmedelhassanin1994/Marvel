
import 'dart:async';

import 'package:mvvm_project/presentation/common/state_renderer/state_renderer_impl.dart';

abstract class BaseViewModel extends BaseViewModelInputs with BaseViewModelOutPuts{

  //shared variables and function that will be used through any view model

   StreamController  _inputStreamController =StreamController<FlowState>.broadcast();

   @override
  void dispose() {
    // TODO: implement dispose
    _inputStreamController.close()
    ;
  }
  @override
  // TODO: implement inputState
  Sink get inputState => _inputStreamController.sink;
   @override
  // TODO: implement outPutState
  Stream<FlowState> get outPutState => _inputStreamController.stream.map((flowState) => flowState);

}

abstract class BaseViewModelInputs{

 void start(); // will be called while init . of view model
 void dispose(); // will be  called when viewmodel dispose
 Sink get inputState;

}

abstract class BaseViewModelOutPuts{

Stream<FlowState> get outPutState;
//shared variables and function that will be used through any view model

}