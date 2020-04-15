class DailyResponse {
  final List<DailyResp> detailData;

  DailyResponse({
    this.detailData,
  });

  factory DailyResponse.fromJson(List<dynamic> parsedJson) {

    List<DailyResp> data = new List<DailyResp>();
    data = parsedJson.map((i)=>DailyResp.fromJson(i)).toList();
    return new DailyResponse(
        detailData: data
    );
  }
}


class DailyResp {
  int reportDate;
  int mainlandChina;
  int otherLocations;
  int totalConfirmed;
  int totalRecovered;
  String reportDateString;
  int deltaConfirmed;
  int deltaRecovered;
  int objectid;

  DailyResp(
      {this.reportDate,
        this.mainlandChina,
        this.otherLocations,
        this.totalConfirmed,
        this.totalRecovered,
        this.reportDateString,
        this.deltaConfirmed,
        this.deltaRecovered,
        this.objectid});

  DailyResp.fromJson(Map<String, dynamic> json) {
    reportDate = json['reportDate'];
    mainlandChina = json['mainlandChina'];
    otherLocations = json['otherLocations'];
    totalConfirmed = json['totalConfirmed'];
    totalRecovered = json['totalRecovered'];
    reportDateString = json['reportDateString'];
    deltaConfirmed = json['deltaConfirmed'];
    deltaRecovered = json['deltaRecovered'];
    objectid = json['objectid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reportDate'] = this.reportDate;
    data['mainlandChina'] = this.mainlandChina;
    data['otherLocations'] = this.otherLocations;
    data['totalConfirmed'] = this.totalConfirmed;
    data['totalRecovered'] = this.totalRecovered;
    data['reportDateString'] = this.reportDateString;
    data['deltaConfirmed'] = this.deltaConfirmed;
    data['deltaRecovered'] = this.deltaRecovered;
    data['objectid'] = this.objectid;
    return data;
  }
}
