import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mvvm_project/data/mapper/mapper.dart';
import 'package:mvvm_project/data/network/failure.dart';
import 'package:mvvm_project/presentation/resources/constants/assets_manager.dart';
import 'package:mvvm_project/presentation/resources/constants/color_manager.dart';
import 'package:mvvm_project/presentation/resources/constants/fonts_manager.dart';
import 'package:mvvm_project/presentation/resources/constants/strings_manager.dart';
import 'package:mvvm_project/presentation/resources/constants/styles_manger.dart';
import 'package:mvvm_project/presentation/resources/constants/value_manager.dart';

enum StateRendererType {
  // pop State
  POPUP_LOADING_STATE,
  POPUP_ERROR_STATE,

  //FULL SCREEN STATE
  FULL_SCREEN_LOADING_STATE,
  FULL_SCREEN_ERROR_STATE,
  CONTENT_SCREEN_STATE, // THE UI OF THE SCREEN
  EMPTY_SCREEN_STATE, // EMPTY VIEW WHEN WE RECIVE NO DATA FROM API SIDE

}

class StateRender extends StatelessWidget {
  StateRendererType stateRendererType;
  String Message;
  String Tittle;
  Function retryActionFunction;

  StateRender(
      {Key? key,
      required this.stateRendererType,
      Failure? failure,
      String? message,
      String? tittle,
      required this.retryActionFunction})
      : Message = message ?? AppStrings.loading,
        Tittle = tittle ?? EMPTY,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _getStateWidget(context);
  }

  Widget _getStateWidget(BuildContext context) {

    switch (stateRendererType) {
      case StateRendererType.POPUP_LOADING_STATE:
        return _getPopDailog(context,[_getAnimatedImage(JsonAssets.loading)]);

      case StateRendererType.POPUP_ERROR_STATE:
        return _getPopDailog(context,[_getAnimatedImage(JsonAssets.error),_getMessage(Message),_getRetryButton(AppStrings.ok,context)]);

      case StateRendererType.FULL_SCREEN_LOADING_STATE:
       return _getItemColumn([_getAnimatedImage(JsonAssets.loading),_getMessage(Message)]);
      case StateRendererType.FULL_SCREEN_ERROR_STATE:
        return _getItemColumn([_getAnimatedImage(JsonAssets.error),_getMessage(Message),_getRetryButton(AppStrings.retry_again,context)]);

      case StateRendererType.CONTENT_SCREEN_STATE:
        return  Container();

      case StateRendererType.EMPTY_SCREEN_STATE:
        return _getItemColumn([_getAnimatedImage(JsonAssets.empty),_getMessage(Message),_getRetryButton(AppStrings.retry_again,context)]);


      default:
        Container();
    }

    return Container();
  }


  Widget _getDailogContent(BuildContext context,List<Widget> children){
    return Column(
     mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,

    );
  }

  Widget _getPopDailog(BuildContext context,List<Widget> children){
    return Dialog(
     shape: RoundedRectangleBorder(
       borderRadius: BorderRadius.circular(AppSize.s14),
     ),
      elevation: AppSize.s1_5,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(AppSize.s14),
          boxShadow: [
            BoxShadow(color: Colors.black26,blurRadius: AppSize.s14,
            offset: Offset(AppSize.s0,AppSize.s12) // BoxShadow
            ),
            ],
        ),
        child: _getDailogContent(context, children),
      ),
    );
  }

  Widget _getItemColumn(List<Widget> children) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: children),
    );
  }

  Widget _getAnimatedImage(String animationName) {
    return SizedBox(
      height: AppSize.s100,
      width: AppSize.s100,
      child:Lottie.asset(animationName) , // child json image
    );
  }


  Widget _getMessage(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPading.p18),
        child: Text(
          "$message",
          style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s16),
        ),
      ),
    );
  }

  Widget _getRetryButton(String buttonTitle,BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPading.p18),
      child: SizedBox(
         width: AppSize.s180,
        child: ElevatedButton(
          onPressed: (){

            if(stateRendererType == StateRendererType.FULL_SCREEN_LOADING_STATE){
               retryActionFunction.call(); // to call api
            }else{

              Navigator.of(context).pop(); // pop state error so we need to dismiss the dailog

            }
          },
         child:Text( "$buttonTitle",
          style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s16)),
        ),
      ),
    );
  }
}
