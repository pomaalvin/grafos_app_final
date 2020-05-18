
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:grafos/componentes/Nodo.dart';
import 'package:grafos/Grafos_game.dart';
import 'dart:math';
class Conexion_Arbol{
  Size ScreenSize;
  Offset posi1,posi2;
  Paint paint;
  double x1,y1,x2,y2;
  Conexion_Arbol(this.ScreenSize,this.x1,this.y1,this.x2,this.y2){
    paint=Paint();
    paint.color=Colors.teal;
    paint.style=PaintingStyle.stroke;
    paint.strokeWidth=3;
    y1=y1+(ScreenSize.width/30)/2;
    y2=y2-(ScreenSize.width/30)/2;
  }
  void render(Canvas c){
    posi1=Offset(x1,y1);
    posi2=Offset(x2,y2);
    c.drawLine(posi1, posi2, paint);
  }


}