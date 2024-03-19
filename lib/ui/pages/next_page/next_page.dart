
import 'package:currency_symbols/currency_symbols.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kurs_valute/data/model/model_money.dart';
import '../../../data/getx_controller/next_page_controller.dart';


class NextPage extends StatelessWidget {

   NextPage({required this.modelMoney}) ;
   final ModelMoney modelMoney;
  final List<String> ccyList=[];


  @override
  Widget build(BuildContext context) {
    NextPageController controller=Get.put(NextPageController(modelMoney.rate!));  // pul birligini controllerga jonatish
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: () {

           Get.back();
          },
          icon: Icon(Icons.backspace),),
        ),
        body: Obx(() => SafeArea(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*09,
              child: Column(children: [
                Text('${cSymbol(modelMoney.ccy.toString())}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.deepOrangeAccent)),
                Text('1 ${modelMoney.ccy}=${modelMoney.rate} SUM',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        padding: EdgeInsets.all(8),
                        width: MediaQuery.of(context).size.width*0.8,
                        child: TextField(
                            onChanged: (value) async{

                              if(controller.change==false){
                                controller.textChangeValutaToSumFunction(enter_data: value);
                               // context.read<NextPageCubit>().convertToSUM(textString: await value,birlik:await modelMoney.rate??'0');
                              }

                              if(controller.change==true){
                                controller.textChangeSumToValutFunction(enter_data: value);
                                //context.read<NextPageCubit>().convertFromSUMtoOther(textString: await value, birlik: await modelMoney.rate??'0');
                              }

                            },
                            keyboardType: TextInputType.number,

                            decoration: InputDecoration(border: OutlineInputBorder()))),
                    Container(
                      child: controller.change==true ?
                      Text('SUM',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)):
                      Text("${modelMoney.ccy}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),),
                  ],),
                MaterialButton(onPressed: () async{

                  controller.changePosition();

                }, child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.deepPurpleAccent),
                  child: Text('change',style: TextStyle(color: Colors.white),),
                ),),


                Expanded(child: controller.change==true
                    ? Text("${controller.qiymat.value.round()/100} ${modelMoney.ccy}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)
                    : Text("${controller.qiymat.value.round()/100} SUM",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),))

              ]),
            )))

);
  }
}
