import 'package:date_format/date_format.dart';
import 'package:get/get.dart';

import '../model/model_money.dart';
import '../net_service/net_service.dart';

class GetX_Controller extends GetxController{
  final NetWorkService netWorkService;
  GetX_Controller(this.netWorkService);
  var _vluta=<ModelMoney>[].obs;
  var _isLoading=false.obs;
  var _chislo=DateTime.now().obs;  // boshlang'ich qiymat beriladi

  RxList<ModelMoney> get vluta => _vluta;  // ishlov berilgan data qaytib jonatiladi
  RxBool get isLoading => _isLoading;
  Rx get chislo => _chislo;

  getValutaInfor()async {    //  tashqaridan malumot olib kiriladi
    isLoading.value=true;  // zagruzka bolayapti
    //DataTime ni String formatga aylantirib, InternetServicega jo'natiladi
    var response=await netWorkService.getInformation(formatDate(_chislo.value, [yyyy,'-',mm,'-',dd]));
    if(response!=null) {
      isLoading.value=false;
      _vluta=<ModelMoney>[].obs;  // oldingi listdan qolgan malumotlarni tozalaymiz
      _vluta.addAll(response);   // internetdan malumot olish
    }
    else isLoading.value=true; // zagruska tugadi

  }

  getChangedate(DateTime dateTime){
    chislo.value=dateTime;
    getValutaInfor();   // chislo o'zgargach funksiyani qayta ishga tushiradi
  }


}