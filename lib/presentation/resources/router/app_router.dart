import 'package:flutter/material.dart';
import 'package:mvvm_project/domain/model/model.dart';
import 'package:mvvm_project/presentation/home/home_screen.dart';
import 'package:mvvm_project/presentation/home_details/home_details.dart';
import 'package:mvvm_project/presentation/onbording/onbording_screen.dart';
import 'package:mvvm_project/presentation/resources/constants/strings_manager.dart';
import 'package:mvvm_project/presentation/resources/router/router_path.dart';
import 'package:mvvm_project/presentation/splash/splashScreen.dart';
import 'package:page_transition/page_transition.dart';

import '../../../app/di.dart';

class RouteGenerator {

 static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.all_routs:
      // return PageTransition(child: SplashScreen(), type: PageTransitionType.scale);
        return _generateMaterialRoute(SplashScreen());

      case Routes.onBordingRoute:
      // return PageTransition(child: SplashScreen(), type: PageTransitionType.scale);
        return _generateMaterialRoute(OnBordingScreen());

      case Routes.home:
        initLoginModel();
        return _generateMaterialRoute(HomeScreen());
      case Routes.home_details:
        final model = settings.arguments as ResultsCharacters;

        return _generateMaterialRoute(HomeDetails(model));

        default:
         return unDefinedRoute();
    }
  }


  static Route<dynamic>unDefinedRoute(){
    return MaterialPageRoute(
      builder: (_)=>Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.noRouteFound),
        ),
        body: Center(child: Text(AppStrings.noRouteFound),),
      )
    );
  }
}




PageTransition _generateMaterialRoute(Widget screen) {
  return PageTransition(child: screen, type: PageTransitionType.rightToLeft);
}
