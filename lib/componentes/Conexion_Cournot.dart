
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:grafos/componentes/Nodo.dart';
import 'package:grafos/Grafos_game.dart';
import 'dart:math';
class Conexion_Cournot{
  Size ScreenSize;
  Offset posi1,posi2;
  Paint paint;
  double x1,y1,x2,y2;
  Conexion_Cournot(this.ScreenSize,this.x1,this.y1,this.x2,this.y2){
    paint=Paint();
    paint.color=Colors.teal.withOpacity(0.3);
    paint.style=PaintingStyle.stroke;
    paint.strokeWidth=3;
  }
  void render(Canvas c){
    posi1=Offset(x1,y1);
    posi2=Offset(x2,y2);
    c.drawLine(posi1, posi2, paint);
  }


}