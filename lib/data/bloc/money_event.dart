part of 'money_bloc.dart';

@immutable
abstract class MoneyEvent {}
class MoneyLoadedEvent extends MoneyEvent{
  final String dataTimeDay;

  MoneyLoadedEvent({required this.dataTimeDay});
}

