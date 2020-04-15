import 'package:covid_stats/core/constant/url.dart';
import 'package:covid_stats/core/model/covid_confirmed_response.dart';
import 'package:covid_stats/core/model/covid_response.dart';
import 'package:covid_stats/core/model/daily_response.dart';
import 'package:dio/dio.dart';


class CovidServices {


  Future<CovidResponse> getAllData() async {
    try {
      print('request $covidUrl');
      Response response = await Dio().get(covidUrl);
      print('response ${response.toString()}');
      return CovidResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }


  Future<CovidConfirmedDetailResponse> getAllConfirmedData() async {
    try {
      print('request $covidUrl');
      Response response = await Dio().get(covidUrl+confirmed);
      print('response data ${response.toString()}');
      return CovidConfirmedDetailResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<CovidConfirmedDetailResponse> getAllRecovered() async {
    try {
      print('request $covidUrl');
      Response response = await Dio().get(covidUrl + recovered);
      print('response data ${response.toString()}');
      return CovidConfirmedDetailResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }


  Future<CovidConfirmedDetailResponse> getAllDeath() async {
    try {
      print('request $covidUrl');
      Response response = await Dio().get(covidUrl + deaths);
      print('response data ${response.toString()}');
      return CovidConfirmedDetailResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }


  Future<CovidResponse> getDataPerCountry(String iD) async {
    try {
      print('request $covidUrl');
      Response response = await Dio().get(covidUrl+countries+iD);
      print('response ${response.toString()}');
      return CovidResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<DailyResponse> getDailyResponse() async {
    try {
      print('request $covidUrl');
      Response response = await Dio().get(covidUrl+daily);
      print('response ${response.toString()}');
      return DailyResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

}