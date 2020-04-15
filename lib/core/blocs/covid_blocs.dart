import 'package:covid_stats/core/blocs/base_bloc.dart';
import 'package:covid_stats/core/model/covid_confirmed_response.dart';
import 'package:covid_stats/core/model/covid_response.dart';
import 'package:covid_stats/core/model/daily_response.dart';
import 'package:covid_stats/core/service/covid_repository.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';

class CovidBlocs extends BaseBloc {
  var logger = Logger();
  final _repository = CovidRepository();

  final _covidSubject = BehaviorSubject<CovidResponse>();

  Function(CovidResponse) get covidSink => _covidSubject.sink.add;
  Stream<CovidResponse> get covidStream => _covidSubject.stream;

  final _confirmedStatsSubject = BehaviorSubject<CovidConfirmedDetailResponse>();
  Function(CovidConfirmedDetailResponse) get confirmedStatsSink => _confirmedStatsSubject.sink.add;
  Stream<CovidConfirmedDetailResponse> get confirmedStatsStream => _confirmedStatsSubject.stream;


  final _covidCountrySubject = BehaviorSubject<CovidResponse>();
  Function(CovidResponse) get covidCountrySink => _covidCountrySubject.sink.add;
  Stream<CovidResponse> get covidCountryStream => _covidCountrySubject.stream;

  final _covidDailySubject = BehaviorSubject<DailyResponse>();
  Function(DailyResponse) get covidDailySink => _covidDailySubject.sink.add;
  Stream<DailyResponse> get covidDailyStream => _covidDailySubject.stream;

  Future<CovidResponse> getCovidStats({
    Function(CovidResponse response) onSuccess,
    Function(CovidResponse response) onFailure,
  }) async {
    setBusy();

    final response = await _repository.doGetAllData();
    if(response != null){
      if (onSuccess != null) onSuccess(response);
      covidSink(response);
    }else{
      if (onFailure != null) onFailure(response);
    }
    setIdle();
  }


  Future<CovidConfirmedDetailResponse> getConfirmedStats({
    Function(CovidConfirmedDetailResponse response) onSuccess,
    Function(CovidConfirmedDetailResponse response) onFailure,
  }) async {
    setBusy();

    final response = await _repository.doGetConfirmedData();
    if(response != null){
      if (onSuccess != null) onSuccess(response);
      confirmedStatsSink(response);
    }else{
      if (onFailure != null) onFailure(response);
    }
    setIdle();
  }


  Future<CovidConfirmedDetailResponse> getRecoveredStats({
    Function(CovidConfirmedDetailResponse response) onSuccess,
    Function(CovidConfirmedDetailResponse response) onFailure,
  }) async {
    setBusy();

    final response = await _repository.doGetRecoveredData();
    if(response != null){
      if (onSuccess != null) onSuccess(response);
      confirmedStatsSink(response);
    }else{
      if (onFailure != null) onFailure(response);
    }
    setIdle();
  }


  Future<CovidConfirmedDetailResponse> getDeathStats({
    Function(CovidConfirmedDetailResponse response) onSuccess,
    Function(CovidConfirmedDetailResponse response) onFailure,
  }) async {
    setBusy();

    final response = await _repository.doGetDeathData();
    if(response != null){
      if (onSuccess != null) onSuccess(response);
      confirmedStatsSink(response);
    }else{
      if (onFailure != null) onFailure(response);
    }
    setIdle();
  }


  Future<CovidResponse> getDataPerCountry({
    String iD,
    Function(CovidResponse response) onSuccess,
    Function(CovidResponse response) onFailure,
  }) async {
    setBusy();

    final response = await _repository.doGetDataPerCountry(iD);
    if(response != null){
      if (onSuccess != null) onSuccess(response);
      covidCountrySink(response);
    }else{
      if (onFailure != null) onFailure(response);
    }
    setIdle();
  }



  Future<DailyResponse> getDailyStats({

    Function(DailyResponse response) onSuccess,
    Function(DailyResponse response) onFailure,
  }) async {
    setBusy();

    final response = await _repository.doGetDailyResponse();
    if(response != null){
      if (onSuccess != null) onSuccess(response);
      covidDailySink(response);
    }else{
      if (onFailure != null) onFailure(response);
    }
    setIdle();
  }










  @override
  void dispose() {
    // TODO: implement dispose
    _covidSubject?.close();
    _covidCountrySubject?.close();
    _confirmedStatsSubject?.close();
    _covidDailySubject?.close();
    super.dispose();
  }
}
