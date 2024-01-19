import 'package:bloc/bloc.dart';


part 'next_page_state.dart';

class NextPageCubit extends Cubit<NextPageState> {
  NextPageCubit() : super(NextPageState(textString:'',change: false ));

  Future<void> convertToSUM({required String textString, required String birlik}) async{
    double javob=await double.parse(textString)*(double.parse(birlik));
    emit(state.copyWith(text: '${javob}'));
  }
  Future<void> convertFromSUMtoOther({required String textString, required String birlik}) async{
    double javob=await double.parse(textString)/(double.parse(birlik));
    emit(state.copyWith(text: '${javob}'));
  }
  Future<void> changePosition({required bool psn})async{
    emit(state.copyWith(change:await !psn));
  }
}