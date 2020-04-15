

import 'package:covid_stats/core/model/covid_confirmed_response.dart';
import 'package:covid_stats/core/model/covid_response.dart';
import 'package:covid_stats/core/model/daily_response.dart';
import 'package:covid_stats/core/service/covid_services.dart';

class CovidRepository {

  final _covidService = CovidServices();


  Future<CovidResponse> doGetAllData() => _covidService.getAllData();
  Future<CovidResponse> doGetDataPerCountry(String iD) => _covidService.getDataPerCountry(iD);
  Future<CovidConfirmedDetailResponse> doGetConfirmedData() => _covidService.getAllConfirmedData();
  Future<CovidConfirmedDetailResponse> doGetRecoveredData() => _covidService.getAllRecovered();
  Future<CovidConfirmedDetailResponse> doGetDeathData() => _covidService.getAllDeath();
  Future<DailyResponse> doGetDailyResponse() => _covidService.getDailyResponse();


}