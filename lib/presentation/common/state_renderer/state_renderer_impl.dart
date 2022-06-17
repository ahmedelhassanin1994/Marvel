
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_project/data/mapper/mapper.dart';
import 'package:mvvm_project/presentation/common/state_renderer/state_renderer.dart';
import 'package:mvvm_project/presentation/resources/constants/strings_manager.dart';

abstract class FlowState{
  StateRendererType  getStateRendererType();
  String getMessage();

}

// loading state (popup , full screen)
class LoadingState extends FlowState{

  StateRendererType stateRendererType;
  String message;


  LoadingState({required this.stateRendererType,String? message}):
  message=message ?? AppStrings.loading;

  @override
  String getMessage() =>message;
  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

// error state (popup , full loading )

class ErrorState extends FlowState{
  StateRendererType stateRendererType;
  String message;

  ErrorState({required this.stateRendererType,required this.message});
  @override
  String getMessage() =>message;
  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

// content state
class ContentState extends FlowState{

  ContentState();

  @override
  String getMessage() =>EMPTY;
  @override
  StateRendererType getStateRendererType() => StateRendererType.CONTENT_SCREEN_STATE;

}


// Empty state
class EmptyState extends FlowState{

  String message;

  EmptyState(this.message);

  @override
  String getMessage() =>message;
  @override
  StateRendererType getStateRendererType() => StateRendererType.EMPTY_SCREEN_STATE;

}

extension FlowStateExtension on FlowState{
  Widget getScreenWidget(BuildContext context,Widget contentScreenWidget, Function retryActionFunction){
      switch(this.runtimeType){
        case LoadingState :{
          if(getStateRendererType() == StateRendererType.POPUP_LOADING_STATE){

            // showing popup dailog
            showPopUp(context,getStateRendererType(),getMessage());


              // return the content ui of the screen
            return contentScreenWidget;
          }else{
            return StateRender(stateRendererType: getStateRendererType(),message: getMessage(), retryActionFunction: retryActionFunction);
          }
          break;
        }
        case ErrorState : {
          dismissDailog(context);

          if(getStateRendererType() == StateRendererType.POPUP_ERROR_STATE){

            // showing popup dailog
            showPopUp(context,getStateRendererType(),getMessage());


            // return the content ui of the screen
            return contentScreenWidget;
          }else{ // full screen error state
            return StateRender(stateRendererType: getStateRendererType(),message: getMessage(), retryActionFunction: retryActionFunction);
          }
        }case ContentState :{
        dismissDailog(context);
        return contentScreenWidget;
      }case EmptyState : {
        return StateRender(stateRendererType: getStateRendererType(),message: getMessage(), retryActionFunction: retryActionFunction);
      }

        default:
          {
            return contentScreenWidget;
          }

      }
  }

  dismissDailog(BuildContext context){
    if(_isThereCurrentDailog(context)){
      Navigator.of(context,rootNavigator: true).pop(true);
    }
  }

  _isThereCurrentDailog(BuildContext context) => ModalRoute.of(context)?.isCurrent !=true;

  showPopUp(BuildContext context,StateRendererType stateRendererType,String message){
    WidgetsBinding.instance.addPostFrameCallback((_) =>
     showDialog(context: context, builder: (BuildContext context) => StateRender(stateRendererType: stateRendererType,message: message,retryActionFunction: (){},))
    );
  }
}