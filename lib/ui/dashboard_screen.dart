import 'package:covid_stats/config/theme_provider.dart';
import 'package:covid_stats/core/blocs/covid_blocs.dart';
import 'package:covid_stats/core/constant/images.dart';
import 'package:covid_stats/core/constant/string.dart';
import 'package:covid_stats/core/model/covid_response.dart';
import 'package:covid_stats/ui/daily_report_screen.dart';
import 'package:covid_stats/ui/detail_screen.dart';
import 'package:covid_stats/ui/widget/card_info.dart';
import 'package:covid_stats/ui/widget/menu_item.dart';
import 'package:covid_stats/ui/widget/pie_chart.dart';
import 'package:covid_stats/ui/shared/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';
import 'package:flutter_easyrefresh/bezier_circle_header.dart';
import 'package:flutter_easyrefresh/bezier_hour_glass_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

//  final _headerKey = GlobalKey<RefreshHeaderState>();
  int touchedIndex;
  CovidBlocs _covidBlocs;
  Country _selected;
  DateFormat fn = DateFormat("dd MMM yyy HH:mm");

  @override
  void initState() {
    // TODO: implement initState
    _selected = Country.ID;
    _covidBlocs = CovidBlocs();
    _covidBlocs.getCovidStats();
    _covidBlocs.getDataPerCountry(iD: _selected.isoCode);


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isLight = false;
    final themeProvider = Provider.of<ThemeProvider>(context);
    Color bgColorTheme = themeProvider.isDarkTheme == false ? brokenWhite : bgColor;
    Color cardColorTheme = themeProvider.isDarkTheme == false ? brokenWhite : darkColor2;

    return Scaffold(
      backgroundColor: bgColorTheme,
        appBar: AppBar(
          title: Text('COVID19'),
          actions: <Widget>[
            Switch(
              value: themeProvider.isDarkTheme,
              onChanged: (val) {
                themeProvider.setThemeData = val;
              },
            )
          ],
          leading: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.asset('assets/images/icon.png'),
          ),
        ),
        body: EasyRefresh(
          onRefresh: (){
            _covidBlocs.getCovidStats();
            _covidBlocs.getDataPerCountry(iD: _selected.isoCode);
            return;
          },
          behavior: ScrollOverBehavior(),
          refreshHeader: BezierCircleHeader(
            color: recoverdColor,
            backgroundColor: themeProvider.getThemeData.scaffoldBackgroundColor
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StreamBuilder<CovidResponse>(
                    stream: _covidBlocs.covidStream,
                    builder: (context, snapshot) {
                      var data = snapshot.data;
                      if(snapshot.hasData){
                        return SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 2.35,
                          child: Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 8,top: 8),
                                  child: Text('Global Stats'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8,right: 8,bottom: 8),
                                  child: Text('Last Update ${fn.format(DateTime.parse(data.lastUpdate))
                                  }'),
                                ),
                                Row(
                                  children: <Widget>[
                                    Flexible(
                                      flex: 2,
                                      child: ChartsWidget(
                                        recovered: data.recovered.value.toDouble(),
                                        confirmed: data.confirmed.value.toDouble(),
                                        deaths: data.deaths.value.toDouble(),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: Column(
                                        children: <Widget>[
                                          CardInfo(
                                            onTap: () async {
                                              Navigator.push(context, CupertinoPageRoute(builder: (_)=> DetailScreen(status: Infected,)));
                                              await _covidBlocs.getConfirmedStats();
                                            },
                                            total: snapshot.data.confirmed.value.toString(),
                                            textStyle: confirmedStyle,
                                            title: 'Confirmed',
                                            cardColorTheme: cardColorTheme,
                                          ),
                                          CardInfo(
                                            onTap: () async {
                                              Navigator.push(context, CupertinoPageRoute(builder: (_)=> DetailScreen(status: Infected,)));
                                              await _covidBlocs.getConfirmedStats();
                                            },
                                            total: snapshot.data.deaths.value.toString(),
                                            textStyle: deathStyle,
                                            title: 'Death',
                                            cardColorTheme: cardColorTheme,
                                          ),
                                          CardInfo(
                                            onTap: () async {
                                              Navigator.push(context, CupertinoPageRoute(builder: (_)=> DetailScreen(status: Infected,)));
                                              await _covidBlocs.getConfirmedStats();
                                            },
                                            total: snapshot.data.recovered.value.toString(),
                                            textStyle: recoveredStyle,
                                            title: 'Recovered',
                                            cardColorTheme: cardColorTheme,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }else{
                        return SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 2.35,
                          child: Card(
                            child: Center(
                              child: Text('Something Went Wrong'),
                            ),
                          ),
                        );
                      }
                    }
                ),
                StreamBuilder<CovidResponse>(
                    stream: _covidBlocs.covidCountryStream,
                    builder: (context, snapshot) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 8,top: 8),
                                  child: Row(
                                    children: <Widget>[
                                      Text('Stats By Country'),
                                      SizedBox(width: 10,),
                                      CountryPicker(
                                        showDialingCode: false,
                                        onChanged: (Country country) {
                                          setState(() {
                                            _selected = country;
                                            _covidBlocs.getDataPerCountry(iD: _selected.isoCode);
                                          });
                                        },
                                        selectedCountry: _selected,
                                      ),
                                    ],),
                                ),
                                if(snapshot.data!=null)
                                  Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Flexible(
                                      child: CardInfo(
                                        cardColorTheme: cardColorTheme,
                                        textStyle: confirmedStyle,
                                        title: 'Confirmed',
                                        total: snapshot.data!=null?snapshot.data.confirmed.value.toString():'-',
                                      ),
                                    ),
                                    Flexible(
                                      child: CardInfo(
                                        cardColorTheme: cardColorTheme,
                                        textStyle: deathStyle,
                                        title: 'Deaths',
                                        total: snapshot.data!=null?snapshot.data.deaths.value.toString():'-',
                                      ),
                                    ),
                                    Flexible(
                                      child: CardInfo(
                                        cardColorTheme: cardColorTheme,
                                        textStyle: recoveredStyle,
                                        title: 'Recovered',
                                        total: snapshot.data!=null?snapshot.data.recovered.value.toString():'-',
                                      ),
                                    ),
                                  ],
                                ),
                                if(snapshot.data == null)
                                  Container(
                                    height: MediaQuery.of(context).size.height/10,
                                    width: MediaQuery.of(context).size.width,
                                    child: Card(
                                      color: cardColorTheme,
                                      child: Center(child: Text('No Data Available')),
                                    ),
                                  )
                              ],
                            ),
                          ),
                        );
                    }
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                      child: MenuItem(
                        onTap: (){
                          Navigator.push(context, CupertinoPageRoute(builder:(context)=> DailyReportScreen()));
                          _covidBlocs.getDailyStats();},
                        images: dailyReport,
                        title: 'Daily Report',),
                    ),
                    Expanded(
                      child: MenuItem(
                        onTap: null,
                        images: progress,
                        title: 'Local Report',),
                    ),
                  ],
                )
              ],
            ),
          )
          ),
    );
  }
}


