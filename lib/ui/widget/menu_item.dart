import 'package:covid_stats/core/blocs/covid_blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';


class MenuItem extends StatelessWidget {

  @required final VoidCallback onTap;
  final Key key;
  @required final String images;
  final double width;
  final double height;
  @required final String title;


  MenuItem({this.onTap,this.key, this.images, this.width, this.height,this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              SvgPicture.asset(images,
                width: width??50,
                height: height??140,),
              Text(title)
            ],
          ),
        ),
      ),
    );
  }
}