part of 'money_bloc.dart';

@immutable
abstract class MoneyState {}

class MoneyInitialState extends MoneyState {}
class MoneySuccesslState extends MoneyState {
  List<ModelMoney> list;

  MoneySuccesslState({required this.list});
}
class MoneyFailureState extends MoneyState {}
