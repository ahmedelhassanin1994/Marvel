

// flutter pub run build_runner build --delete-conflicting-outputs

import 'package:freezed_annotation/freezed_annotation.dart';
part 'freezed_data_classes.freezed.dart';


@freezed
class LoginObject with _$LoginObject{

  factory LoginObject(String emaile,String password)=_LoginObject;

}