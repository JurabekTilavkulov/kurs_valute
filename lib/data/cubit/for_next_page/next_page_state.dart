part of 'next_page_cubit.dart';


class NextPageState{
  final String textString;
  final bool change;

  NextPageState({this.textString='',this.change=false});

  NextPageState copyWith({String? text,bool? change}){
    return NextPageState(
        textString: text??this.textString,
        change: change??this.change
    );
  }
}