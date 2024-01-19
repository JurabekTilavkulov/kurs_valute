import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:kurs_valute/data/model/model_money.dart';
import 'package:meta/meta.dart';

import '../net_service/net_service.dart';

part 'money_event.dart';
part 'money_state.dart';

class MoneyBloc extends Bloc<MoneyEvent, MoneyState> {

  final NetWorkService netWorkService;

  MoneyBloc({required this.netWorkService}) : super(MoneyInitialState()) {
    on<MoneyLoadedEvent>((event, emit) async{
      List<ModelMoney>? list=await netWorkService.getInformation(event.dataTimeDay);
      if(list!=null){
        emit(MoneySuccesslState(list: list));
      }
      else emit(MoneyFailureState());
    });

  }
}
