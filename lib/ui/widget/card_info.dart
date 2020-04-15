import 'package:covid_stats/core/blocs/covid_blocs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class CardInfo extends StatelessWidget {

  @required final Color cardColorTheme;
  @required final String title;
  @required final TextStyle textStyle;
  @required final String total;
  final VoidCallback onTap;


  CardInfo({this.cardColorTheme, this.title, this.textStyle, this.total, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width/3.5,
        height: MediaQuery.of(context).size.height/10.5,
        child: Card(
          color: cardColorTheme,
          child: Padding(
            padding: const EdgeInsets.only(left:8, right: 8, top: 16, bottom: 8),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text(title,style: textStyle,),
                Text(total,style: textStyle,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
