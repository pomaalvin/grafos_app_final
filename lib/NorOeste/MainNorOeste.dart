import 'package:flutter/material.dart';
class MainNorOeste extends StatefulWidget {
  @override
  _MainNorOesteState createState() => _MainNorOesteState(numrow,numcol);
  double numcol,numrow;
  MainNorOeste(this.numrow,this.numcol);
}

class _MainNorOesteState extends State<MainNorOeste> {
  double numcol,numrow;
  _MainNorOesteState(this.numrow,this.numcol);
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      body:Column(
        children: <Widget>[
          Container(

          ),
          Container(

          )
        ],
      )
    );
  }
}
