
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_project/presentation/resources/constants/theme_manager.dart';
import 'package:mvvm_project/presentation/resources/router/app_router.dart';
import 'package:mvvm_project/presentation/resources/router/router_path.dart';

class MyApp extends StatefulWidget{

 MyApp._internal();
 static final MyApp instance=MyApp._internal();
 factory MyApp()=>instance;

 @override
  _MyAppState createState() => _MyAppState();

}

class _MyAppState extends State<MyApp>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      onGenerateRoute: RouteGenerator.getRoute,
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.all_routs,
      theme: getApplicationTheme(),
    );
  }


}