
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mvvm_project/domain/model/model.dart';
import 'package:mvvm_project/presentation/onbording/onbording_screen.dart';
import 'package:mvvm_project/presentation/resources/constants/assets_manager.dart';
import 'package:mvvm_project/presentation/resources/constants/strings_manager.dart';
import 'package:mvvm_project/presentation/resources/constants/value_manager.dart';

class OnBordingPage extends StatelessWidget{

 late SliderObject sliderObject;


 OnBordingPage(this.sliderObject,{Key? key}):super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Column(
      children: <Widget>[
        SizedBox(height: AppSize.s40,),
        Padding(
          padding: const EdgeInsets.all(AppPading.p8),
          child: Text(
            sliderObject.tittle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppPading.p8),
          child: Text(
            sliderObject.subTittle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        SizedBox(height: AppSize.s60,),


        SvgPicture.asset(sliderObject.image),

      ],
    );
  }


}