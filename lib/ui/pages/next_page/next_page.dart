
import 'package:currency_symbols/currency_symbols.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurs_valute/data/model/model_money.dart';
import '../../../data/cubit/for_next_page/next_page_cubit.dart';






class NextPage extends StatelessWidget {

   NextPage({required this.modelMoney}) ;
   final ModelMoney modelMoney;
  final List<String> ccyList=[];

  @override
  Widget build(BuildContext context) {



    return BlocBuilder<NextPageCubit, NextPageState>(
  builder: (context, state) {
    print('state.change tepada:${state.change}');
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: () {

            Navigator.pop(context);
          },
          icon: Icon(Icons.backspace),),
        ),
        body: SafeArea(
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

                      if(state.change==false){
                        context.read<NextPageCubit>().convertToSUM(textString: await value,birlik:await modelMoney.rate??'0');
                      }

                      if(state.change==true){
                        context.read<NextPageCubit>().convertFromSUMtoOther(textString: await value, birlik: await modelMoney.rate??'0');
                      }





                    },
                  keyboardType: TextInputType.number,

                  decoration: InputDecoration(border: OutlineInputBorder()))),
                Container(
                  child: state.change?
                  Text('SUM',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)):
                  Text("${modelMoney.ccy}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),),
              ],),
              MaterialButton(onPressed: () async{

                context.read<NextPageCubit>().changePosition(psn: await state.change);

              }, child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.deepPurpleAccent),
                child: Text('change',style: TextStyle(color: Colors.white),),
              ),),


              Expanded(child: state.change?Text("${state.textString} ${modelMoney.ccy}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),):Text("${state.textString} SUM",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),))

            ]),
          ))




    );
  },
);
  }
}
