import 'package:currency_symbols/currency_symbols.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../data/bloc/money_bloc.dart';
import '../../../data/cubit/for_home_page/home_page_cubit.dart';
import '../../../data/model/model_money.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<MoneyBloc>(context).add(MoneyLoadedEvent(dataTimeDay: '${formatDate(DateTime.now(), [yyyy,'-',mm,'-',dd])}'));



    return BlocBuilder<MoneyBloc, MoneyState>(
      builder: (context, state) {

        print('state: ${state}');
        debugPrint("state debug ${state}");
        print('${formatDate(DateTime.now(), [yyyy,'-',mm,'-',dd])}');


        if(state is MoneyInitialState){
          return Scaffold(
            body: SafeArea(child: Center(child: CircularProgressIndicator(),),),
          );
        }
        else if(state is MoneySuccesslState){
          return BlocBuilder<HomePageCubit, HomePageState>(
            builder: (contextH, stateH) {
              return Scaffold(
                body: SafeArea(
                  child: Column(
                    children: [

                      TextButton(onPressed: () {
                        showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2018),
                            lastDate:DateTime.now()).then((value) {
                              print("vu value:${value?.day}");
                              if(value!=null)
                              BlocProvider.of<MoneyBloc>(context).add(MoneyLoadedEvent(dataTimeDay: '${formatDate(value, [yyyy,'-',mm,'-',dd])}'));
                              //Navigator.pop(context);
                            },);
                        },
                          child: Text('${state.list[0].date}')),

                      Container(
                        padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height*0.89,
                        child: ListView.builder(
                          itemCount: state.list.length,
                          itemBuilder: (context, index) {
                            return buildItemList(context,index,state.list);
                            },),
                  )




                ],
              ),
            ),
          );
  },
);
        }
        else if( state is MoneyFailureState){
          return Scaffold(body: Center(child: Text("Error"),),);
        }
        else return Scaffold(body: Center(child: Text("Error"),),);
      },
    );
  }
  Widget buildItemList(BuildContext context,int index, List<ModelMoney> list){
    return InkWell(onTap: () {

      Navigator.pushNamed(context, '/NextPage',arguments: list[index]);

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
