import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_project/app/app_prefs.dart';
import 'package:mvvm_project/presentation/resources/constants/assets_manager.dart';
import 'package:mvvm_project/presentation/resources/constants/color_manager.dart';
import 'package:mvvm_project/presentation/resources/constants/fonts_manager.dart';
import 'package:mvvm_project/presentation/resources/constants/strings_manager.dart';
import 'package:mvvm_project/presentation/resources/constants/styles_manger.dart';
import 'package:mvvm_project/presentation/resources/router/router_path.dart';

import '../../app/di.dart';




class SplashScreen extends StatefulWidget {

  @override
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {


  Timer? _timer;
  AppPreferences _sharedPreferences=instance<AppPreferences>();


  _startDelay(){
    _timer=Timer(Duration(seconds: 5), _goNext);
  }

   _goNext(){
        _sharedPreferences.isOnBordingScreenView().then((isBordingScreenView){
          if(isBordingScreenView){
            Navigator.pushReplacementNamed(context, Routes.home);

          }else{
            Navigator.pushReplacementNamed(context, Routes.onBordingRoute);

          }
        });

   }

  @override
  void initState() {
    _startDelay();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _timer?.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    // TODO: implement build
    return Scaffold(
      backgroundColor:ColorManager.dark,

      body:Center(
        child: Text(
            AppStrings.tittle,
            style: getSemiBoldStyle(fontSize: FontSize.s38,color: ColorManager.primary),
        ),
      ),
    );

  }
}
