import 'package:currency_symbols/currency_symbols.dart';
import 'package:date_format/date_format.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:kurs_valute/data/net_service/net_service.dart';
import '../../../data/getx_controller/getx_controller.dart';
import '../../../data/model/model_money.dart';

class MyHomePage extends StatelessWidget {

  MyHomePage({Key? key}) : super(key: key);
  GetX_Controller controller=Get.put(GetX_Controller(NetWorkService(Dio())))..getValutaInfor();
  @override
  Widget build(BuildContext context) {
    print("DateTime type :${DateTime.now().runtimeType}");

    return Obx(() => builtBody(context));

  }
  builtBody(BuildContext context) {
    if(controller.isLoading.value) {
      return Scaffold(body: Center(child: CircularProgressIndicator(),));
    }
    else {
      return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              TextButton(onPressed: () {
                showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1990),
                    lastDate:DateTime.now()).then((value) {
                  print("vu value:${formatDate(value!, [yyyy,'-',mm,'-',dd])}");
                  if(value!=null){
                    controller.getChangedate(value);
                  }
                  print("Value type: ${value.runtimeType}"); // DateTime

                },);

              },
                  child: Text('${controller.vluta[0].date}')),//${state.list[0].date}

              Container(
                padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height*0.89,
                child: ListView.builder(
                  itemCount: controller.vluta.length,
                  itemBuilder: (context, index) {
                    return buildItemList(context,index,controller.vluta);
                  },),
              )




            ],
          ),
        ),
        //   );
        // },
      );
    }
  }

  Widget buildItemList(BuildContext context,int index, List<ModelMoney> list){
    print("list:${list[index].date}");
    return InkWell(onTap: () {

      Get.toNamed('/NextPage',arguments: list[index]);

    },
    child: Container(
      margin: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width*0.5,
      decoration: BoxDecoration(
        color: index%2==00? Color(0xFF9EECF6):Color(0xFFA2F6C9),
        borderRadius: BorderRadius.circular(10)
      ),
      child: Column(

        children: [
          Text('${cSymbol(list[index].ccy.toString())}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.deepOrangeAccent)),
          Text(' ${list[index].ccyNmEN}',style: TextStyle(fontWeight: FontWeight.bold),),
          Text('1 ${list[index].ccy}=${list[index].rate} SUM',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
          Text(' ${list[index].ccyNmUZC}',style: TextStyle(fontWeight: FontWeight.bold)),
          Text(' ${list[index].ccyNmRU}',style: TextStyle(fontWeight: FontWeight.bold)),
          Text('diff ${list[index].diff}',style: TextStyle(fontWeight: FontWeight.bold)),

        ],
      ),
    ),);
  }

}
