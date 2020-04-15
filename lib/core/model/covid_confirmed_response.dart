class CovidConfirmedDetailResponse {
  final List<CovidConfirmedResp> detailData;

  CovidConfirmedDetailResponse({
    this.detailData,
  });

  factory CovidConfirmedDetailResponse.fromJson(List<dynamic> parsedJson) {

    List<CovidConfirmedResp> data = new List<CovidConfirmedResp>();
    data = parsedJson.map((i)=>CovidConfirmedResp.fromJson(i)).toList();

    return new CovidConfirmedDetailResponse(
        detailData: data
    );
  }
}




class CovidConfirmedResp {
  String provinceState;
  String countryRegion;
  int lastUpdate;
  num lat;
  num long;
  int confirmed;
  int deaths;
  int recovered;

  CovidConfirmedResp(
      {
        this.provinceState,
        this.countryRegion,
        this.lastUpdate,
        this.lat,
        this.long,
        this.confirmed,
        this.deaths,
        this.recovered});

  CovidConfirmedResp.fromJson(Map<String, dynamic> json) {
    provinceState = json['provinceState'];
    countryRegion = json['countryRegion'];
    lastUpdate = json['lastUpdate'];
    lat = json['lat'];
    long = json['long'];
    confirmed = json['confirmed'];
    deaths = json['deaths'];
    recovered = json['recovered'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['provinceState'] = this.provinceState;
    data['countryRegion'] = this.countryRegion;
    data['lastUpdate'] = this.lastUpdate;
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['confirmed'] = this.confirmed;
    data['deaths'] = this.deaths;
    data['recovered'] = this.recovered;
    return data;
  }
}
