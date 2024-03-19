import 'package:get/get.dart';

class NextPageController extends GetxController{
  NextPageController(this._birlikMiqdor);
  String _birlikMiqdor;
  var _change=false.obs;
  var _textString=''.obs;
  var _qiymat=0.0.obs;
  var _enter_data='0'.obs;


  RxBool get change => _change;  // qaytadigan qiymat
  RxString get textString => _textString;
  RxDouble get qiymat => _qiymat;
  RxString get enter_data => _enter_data;

  changePosition(){
    change.value=!change.value;
    if(change.value==false){
      textChangeValutaToSumFunction(enter_data: _enter_data.value);
    }
    if(change.value==true){
      textChangeSumToValutFunction(enter_data: _enter_data.value);
    }
  }
  textChangeSumToValutFunction({required String enter_data}){
    _enter_data.value=enter_data;
    qiymat.value=double.parse(_enter_data.value)/double.parse(_birlikMiqdor);
  }
  textChangeValutaToSumFunction({required String enter_data}){
    _enter_data.value=enter_data;
    qiymat.value=double.parse(_enter_data.value)*double.parse(_birlikMiqdor);
  }
}