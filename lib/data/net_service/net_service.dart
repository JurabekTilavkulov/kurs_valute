import 'package:dio/dio.dart';
import 'package:kurs_valute/data/model/model_money.dart';
import 'package:retrofit/http.dart';
part 'net_service.g.dart';
//https://cbu.uz/uz/arkhiv-kursov-valyut/json/all/2018-12-11/
@RestApi(baseUrl: 'https://cbu.uz/uz/arkhiv-kursov-valyut/json/all')
abstract class NetWorkService{
  factory NetWorkService(Dio dio,{String baseUrl})=_NetWorkService;

  @GET('/{chislo}/')
  Future<List<ModelMoney>?> getInformation(
      @Path() String chislo,
      );
}