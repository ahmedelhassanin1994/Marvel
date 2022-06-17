
import 'dart:async';

import 'package:mvvm_project/domain/model/model.dart';
import 'package:mvvm_project/presentation/base/baseviewmodel.dart';
import 'package:mvvm_project/presentation/resources/constants/assets_manager.dart';
import 'package:mvvm_project/presentation/resources/constants/strings_manager.dart';

class OnBordingViewModel extends BaseViewModel with OnBordingViewModelInputs,OnBordingViewModelOuts{

  // stream controllers
  final StreamController _streamController=StreamController<SlideViewObject>();
  late final List<SliderObject> _list ;
  int _currentindex=0;



  @override
  void dispose() {
    // TODO: implement dispose
    _streamController.close();
  }

  @override
  void start() {
    // TODO: implement start
    _list=_getSliderData();
    // send slider data in our view
    _postDataToView();
  }

  @override
  int goNext() {
    // TODO: implement goNext

    int nextIndex=_currentindex ++;
    if(nextIndex >= _list.length-1) {
      _currentindex = 0;
    }

    return _currentindex;

  }

  @override
  int goPrevios() {
    // TODO: implement goPrevios

    int previousindex=_currentindex --;
    if(previousindex == -1) {
      _currentindex = _list.length - 1;
    }

    return _currentindex;
  }

  @override
  void onPageChanged(int index) {
    // TODO: implement onPageChanged

    _currentindex =index;
    _postDataToView();
  }

  @override
  // TODO: implement inputSliderViewObject
  Sink get inputSliderViewObject => _streamController.sink;

  @override
  // TODO: implement outPutSliderView
  Stream<SlideViewObject> get outPutSliderView => _streamController.stream.map((SlideViewObject) => SlideViewObject);

  // private functions
  List<SliderObject>_getSliderData()=>[
    SliderObject(AppStrings.onBordingTittle1,AppStrings.onBordingSubTittle1,ImageAssets.onbording_logo1),
    SliderObject(AppStrings.onBordingTittle2,AppStrings.onBordingSubTittle2,ImageAssets.onbording_logo2),
    SliderObject(AppStrings.onBordingTittle3,AppStrings.onBordingSubTittle3,ImageAssets.onbording_logo3),
    SliderObject(AppStrings.onBordingTittle4,AppStrings.onBordingSubTittle4,ImageAssets.onbording_logo4),

  ];

  _postDataToView(){
    inputSliderViewObject.add(SlideViewObject(_list[_currentindex], _list.length, _currentindex));
  }

}

// inputs mean the orders that our view model will recive from our view
abstract class OnBordingViewModelInputs{

  void goNext(); // When user clicks on right arrow or swipe
  void goPrevios(); // when user clicks on left arrow or swipe
  void onPageChanged(int index);
  Sink get inputSliderViewObject; // this is the way to add data to the stream  ... stream input
}

// outputs mean data or result that will be sent from our view model to our view
abstract class OnBordingViewModelOuts{

  // will be implement it later
  Stream<SlideViewObject> get outPutSliderView;
}

class SlideViewObject{

 late SliderObject sliderObject;
 late int numOfSlides;
 late int currentIndex;

 SlideViewObject(this.sliderObject, this.numOfSlides, this.currentIndex);
}