import 'package:flutter/material.dart';
import 'package:mvvm_project/app/constant.dart';
import 'package:mvvm_project/app/my_app.dart';
import 'package:mvvm_project/data/cache_model/model_cache.dart';

import 'app/di.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await initAppModule();
  Hive.registerAdapter<Model_Cache>(ModelCacheAdapter());
  await Hive.openBox<Model_Cache>('${Constant.localKey}');


  runApp(MyApp());
}
