


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mvvm_project/app/app_prefs.dart';
import 'package:mvvm_project/app/di.dart';
import 'package:mvvm_project/presentation/onbording/onbordin_viewmodel.dart';
import 'package:mvvm_project/presentation/onbording/onbording_page.dart';
import 'package:mvvm_project/presentation/resources/constants/assets_manager.dart';
import 'package:mvvm_project/presentation/resources/constants/color_manager.dart';
import 'package:mvvm_project/presentation/resources/constants/strings_manager.dart';
import 'package:mvvm_project/presentation/resources/constants/value_manager.dart';
import 'package:mvvm_project/presentation/resources/router/router_path.dart';




class OnBordingScreen extends StatefulWidget {

  @override
  _OnBordingScreen createState() => _OnBordingScreen();
}

class _OnBordingScreen extends State<OnBordingScreen> {

 PageController _pageController=PageController(initialPage: 0);
late SlideViewObject slideViewObject;
 OnBordingViewModel _viewModel=new OnBordingViewModel();
 AppPreferences _sharedPreferences=instance<AppPreferences>();



 _bind(){
   _viewModel.start();
   _sharedPreferences.setOnBordingScreenView();
 }



  @override
  void initState() {
     _bind();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _viewModel.dispose();
    super.dispose();
  }


 Widget _getProperCircle(int index,int _currentindex) {
   if(index ==_currentindex){
     return SvgPicture.asset(ImageAssets.circleIcon); // selected slider
   }else{
     return SvgPicture.asset(ImageAssets.solidCircle); // unselected slider
   }
 }


   Widget _getBottomSheetWidget( SlideViewObject slideViewObject){
    return Container(
      color: ColorManager.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.all(AppPading.p14),
            child: GestureDetector(
              child: SizedBox(
                height: AppSize.s20,
                width: AppSize.s20,
                child: SvgPicture.asset(ImageAssets.rightArrow),
              ),
              onTap: (){
               _pageController.animateToPage(_viewModel.goPrevios(), duration: Duration(milliseconds: AppDurationConstant.d300), curve: Curves.bounceOut);
              },
            ),
          ),

          Row(
           children: [

             for(int i=0;i<slideViewObject.numOfSlides;i++)
               Padding(
                 padding: EdgeInsets.all(AppPading.p14),
                 child: _getProperCircle(i,slideViewObject.currentIndex),)

           ],
          ),
          Padding(
            padding: EdgeInsets.all(AppPading.p14),
            child: GestureDetector(
              child: SizedBox(
                height: AppSize.s20,
                width: AppSize.s20,
                child: SvgPicture.asset(ImageAssets.leftArrow),
              ),
              onTap: (){

                _pageController.animateToPage(_viewModel.goNext(), duration: Duration(milliseconds: AppDurationConstant.d300), curve: Curves.bounceOut);

              },
            ),
          )
        ],
      ),
    );
 }

 Widget _getContentWidget(SlideViewObject? data){
   if(data==null){
     return Container();
   }
   else
   return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        backgroundColor:ColorManager.white,
        elevation: AppSize.s0,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: ColorManager.white,
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark
        ),
      ),

      bottomSheet: Container(
        color: ColorManager.white,
        height: AppSize.s100,
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(onPressed: (){
                Navigator.pushReplacementNamed(context, Routes.login);

              },
                  child:Text(AppStrings.skip,textAlign: TextAlign.end,style: Theme.of(context).textTheme.subtitle2,)

              ),
            ),
            // add layout indicator and arrow
            _getBottomSheetWidget(data),
          ],
        ),
      ),

      body:PageView.builder(
          controller: _pageController,
          itemCount: data.hashCode,
          onPageChanged: (index){
            _viewModel.onPageChanged(index);
          },
          itemBuilder: (context,index){

            return OnBordingPage(data.sliderObject);
          }

      )
  );

 }
  @override
  Widget build(BuildContext context) {
      Size size = MediaQuery.of(context).size;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    // TODO: implement build
    return StreamBuilder<SlideViewObject>(
      stream: _viewModel.outPutSliderView,
      builder: (context,snapShot){

        return _getContentWidget(snapShot.data);
      },


    );

  }
}

