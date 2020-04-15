import 'package:covid_stats/core/blocs/covid_blocs.dart';
import 'package:covid_stats/core/model/daily_response.dart';
import 'package:covid_stats/ui/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DailyReportScreen extends StatefulWidget {
  @override
  _DailyReportScreenState createState() => _DailyReportScreenState();
}

class _DailyReportScreenState extends State<DailyReportScreen> {
  
  CovidBlocs covidBlocs;
  DateFormat df = DateFormat("dd MMM yyyy");
  
  @override
  void initState() {
    // TODO: implement initState
    covidBlocs = CovidBlocs();
    covidBlocs.getDailyStats();
    super.initState();
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Report'),
      ),
      body: StreamBuilder<DailyResponse>(
        stream: covidBlocs.covidDailyStream,
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          else
            if (snapshot.hasData)
              return ListView.builder(
                itemCount: snapshot.data.detailData.length,
                itemBuilder: (context,index){
                  var data = snapshot.data.detailData[index];
                  return Card(
                    child: ListTile(
                      leading: Icon(Icons.access_time),
                      title: Text(df.format(DateTime.fromMillisecondsSinceEpoch(data.reportDate))),
                      subtitle: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text('Confirmed ${data.deltaConfirmed}', style: confirmedStyle2,),
                              SizedBox(width: 20,),
                              Text('Recovered ${data.deltaRecovered}', style: recoveredStyle2,),
                            ],
                          ),
                          Text('Total ${data.mainlandChina} cases on China and ${data.otherLocations} on the other locations')
                        ],
                      ),

                    ),
                  );
                });
            else
              return Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width/2,
                height: MediaQuery.of(context).size.height/10,
                child: Column(
                  children: <Widget>[
                    Text('Something Went Wrong'),
                    RaisedButton(
                        child: Text('Reload'),
                        onPressed: (){
                          covidBlocs.getDailyStats();
                        })
                  ],
                ),
              ),
            );
        },

      ),
    );
  }
}
