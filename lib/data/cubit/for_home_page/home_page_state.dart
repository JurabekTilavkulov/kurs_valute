part of 'home_page_cubit.dart';

class HomePageState{

  final String? dateTime;

  HomePageState({this.dateTime=''});

  HomePageState copyWith({required String? dataTime}){
    return HomePageState(dateTime: dateTime??this.dateTime);
  }
}
