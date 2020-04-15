import 'package:covid_stats/core/blocs/covid_blocs.dart';
import 'package:covid_stats/core/constant/string.dart';
import 'package:covid_stats/core/model/covid_confirmed_response.dart';
import 'package:covid_stats/core/model/covid_response.dart';
import 'package:covid_stats/core/model/user_location.dart';
import 'package:covid_stats/ui/shared/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';



class DetailScreen extends StatefulWidget {

  final String status;

  const DetailScreen({Key key, this.status}) : super(key: key);


  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>{

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  CovidBlocs _covidBlocs;
  UserLocation _location;
  static LatLng _initialPosition;
  GoogleMapController mapController;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  var logger = Logger();
  String _mapStyle;
  BitmapDescriptor pinLocationIcon;


  buildMarkers(List<CovidConfirmedResp> confirmed) {

  confirmed.forEach((data){
    final MarkerId markerId = MarkerId(data.lat.toString());
    final Marker marker = Marker(
        markerId: markerId,
        position: LatLng(
          data.lat.toDouble(),
          data.long.toDouble(),
        ),

        infoWindow: InfoWindow(
            title: data.provinceState??data.countryRegion,
            snippet:
            widget.status== Infected? 'Confirmed ${data.confirmed}' : widget.status == Recovered ? 'Recovered ${data.recovered}': 'Deaths ${data.deaths}'
        ),
        onTap: (){
          logger.d(data.countryRegion);
        },
        icon: pinLocationIcon
    );
    setState(() {
      markers[markerId] = marker;
    });
  });

//    for (var i = 0; i < confirmed.length; i++) {
//      final MarkerId markerId = MarkerId(confirmed[i].lat.toString());
//      final Marker marker = Marker(
//          markerId: markerId,
//          position: LatLng(
//            confirmed[i].lat.toDouble(),
//            confirmed[i].long.toDouble(),
//          ),
//
//          infoWindow: InfoWindow(
//              title: confirmed[i].provinceState??confirmed[i].countryRegion,
//              snippet: 'Confirmed ${confirmed[i].confirmed}'),
//
//
//          onTap: (){
//            logger.d(confirmed[i].countryRegion);
//          },
//          icon: pinLocationIcon
//      );
//
//      setState(() {
//        markers[markerId] = marker;
//      });
//    }
    print("Length:: + ${markers.length}");
  }

  void setCustomMapPin() async {
    if(widget.status == Infected){
      pinLocationIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 70),
      'assets/images/img_confirmed_marker.png');
    }else if (widget.status == Recovered){
      pinLocationIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 50),
      'assets/images/img_recovered_marker.png');
    }else{
      pinLocationIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 30),
      'assets/images/img_deaths_marker.png');
    }
  }

  @override
  void initState() {
    setCustomMapPin();
    rootBundle.loadString('assets/map_style.txt').then((string) {
      _mapStyle = string;
    });
    _covidBlocs = Provider.of<CovidBlocs>(context,listen: false);
    if(widget.status == Infected){
      logger.d(Infected);
      _covidBlocs.getConfirmedStats(
        onSuccess: (resp){
          buildMarkers(resp.detailData);
        }
      );
    }else if(widget.status == Recovered){
      logger.d(Recovered);
      _covidBlocs.getRecoveredStats(
        onSuccess: (resp){
          buildMarkers(resp.detailData);
        }
      );
    }else if(widget.status == Deaths){
      logger.d(Deaths);
      _covidBlocs.getDeathStats(
        onSuccess: (resp){
          buildMarkers(resp.detailData);
        }
      );
    }else{
      _covidBlocs.getConfirmedStats(
        onSuccess: (resp){
          buildMarkers(resp.detailData);
        }
      );
    }
    _initialPosition = LatLng(30.568041, 114.1603011);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
  return SafeArea(
    child: Scaffold(
//      appBar: AppBar(),
      key: _scaffoldKey,
      body: StreamBuilder<CovidConfirmedDetailResponse>(
        stream: _covidBlocs.confirmedStatsStream,
          builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }else if(snapshot.error != null){
            return Center(child: CircularProgressIndicator());
          }else{
            return GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: _initialPosition,
                  zoom: 0.0,
                ),
                gestureRecognizers:
                <Factory<OneSequenceGestureRecognizer>>[
                  Factory<OneSequenceGestureRecognizer>(
                          () => ScaleGestureRecognizer())
                ].toSet(),
                markers: Set<Marker>.of(markers.values),
                onMapCreated: (GoogleMapController controller) {
                  mapController = controller;
                  mapController.setMapStyle(_mapStyle);
                });
          }
          }),
//      bottomSheet: StreamBuilder<CovidResponse>(
//        stream: _covidBlocs.covidStream,
//        builder: (context,snapshot){
//          if (snapshot.hasData) {
//            return SolidBottomSheet(
//              headerBar: Container(
//                color: Theme.of(context).primaryColor,
//                height: 50,
//                child: Center(
//                  child: Text("Show Detail "),
//                ),
//              ),
//              maxHeight: 100,
//              body: ListView(
//                children: <Widget>[
//                  Row(
//                    mainAxisSize: MainAxisSize.max,
//                    children: <Widget>[
//                      Expanded(
//                        child: Container(
//                          height: 80,
//                          child: Card(
//                            color: confirmedColor,
//                            child: Padding(
//                              padding: const EdgeInsets.only(left:8, right: 8, top: 16, bottom: 8),
//                              child: Column(
//                                mainAxisSize: MainAxisSize.max,
//                                children: <Widget>[
//                                  Text(snapshot.data.confirmed.value.toString()),
//                                  Text('Infected')
//                                ],
//                              ),
//                            ),
//                          ),
//                        ),
//                      ),
//                      Expanded(
//                        child: Container(
//                          height: 80,
//                          child: Card(
//                            color: deathColor,
//                            child: Padding(
//                              padding: const EdgeInsets.only(left:8, right: 8, top: 16, bottom: 8),
//                              child: Column(
//                                mainAxisSize: MainAxisSize.max,
//                                children: <Widget>[
//                                  Text(snapshot.data.deaths.value.toString()),
//                                  Text('Deaths')
//                                ],
//                              ),
//                            ),
//                          ),
//                        ),
//                      ),
//                      Expanded(
//                        child: Container(
//                          height: 80,
//                          child: Card(
//                            color: recoverdColor,
//                            child: Padding(
//                              padding: const EdgeInsets.only(left:8, right: 8, top: 16, bottom: 8),
//                              child: Column(
//                                mainAxisSize: MainAxisSize.max,
//                                children: <Widget>[
//                                  Text(snapshot.data.recovered.value.toString()),
//                                  Text('Recovered')
//                                ],
//                              ),
//                            ),
//                          ),
//                        ),
//                      ),
//
//
//                    ],
//                  )
//                ],
//              ),
//            );
//          } else{
//            return Container();
//          }
//        },
//      ),

    ),
  );
  }
}
